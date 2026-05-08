import 'package:flutter/foundation.dart';

import '../data/user_repository.dart';
import '../models/user_model.dart';
import '../services/google_auth_service.dart';

class UserProvider extends ChangeNotifier {
  UserProvider({
    UserRepository? userRepository,
    GoogleAuthService? googleAuthService,
  })  : _userRepository = userRepository ?? UserRepository(),
        _googleAuthService = googleAuthService ?? GoogleAuthService();

  final UserRepository _userRepository;
  final GoogleAuthService _googleAuthService;

  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get isLoggedIn => _user != null;
  bool get isConfigured => _user?.isConfigured ?? false;

  Future<void> signInWithGoogle() async {
    await _run(() async {
      final googleUser = await _googleAuthService.signIn();
      _user = await _userRepository.upsertGoogleUser(
        googleId: googleUser.id,
        name: googleUser.name,
        email: googleUser.email,
        photoUrl: googleUser.photoUrl,
      );
    });
  }

  Future<void> updateConfiguration({
    String? language,
    String? petName,
    SmokingType? smokingType,
    int? dailyUsage,
    double? vapePrice,
    int? vapeDurationDays,
    double? cigarettePackPrice,
    int? dailyCigarettes,
  }) async {
    if (_user == null) return;

    _user = _user!.copyWith(
      language: language,
      petName: petName,
      smokingType: smokingType,
      dailyUsage: dailyUsage,
      vapePrice: vapePrice,
      vapeDurationDays: vapeDurationDays,
      cigarettePackPrice: cigarettePackPrice,
      dailyCigarettes: dailyCigarettes,
    );
    _user = await _userRepository.save(_user!);
    notifyListeners();
  }

  Future<void> markAsConfigured() async {
    if (_user == null) return;

    _user = _user!.copyWith(isConfigured: true);
    _user = await _userRepository.save(_user!);
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    _user = user.copyWith(lastLogin: DateTime.now());
    _user = await _userRepository.save(_user!);
    notifyListeners();
  }

  Future<void> incrementPuffs() async {
    if (_user == null) return;

    _user = _user!.copyWith(totalPuffs: _user!.totalPuffs + 1);
    _user = await _userRepository.save(_user!);
    notifyListeners();
  }

  Future<void> incrementCigarettes() async {
    if (_user == null) return;

    _user = _user!.copyWith(totalCigarettes: _user!.totalCigarettes + 1);
    _user = await _userRepository.save(_user!);
    notifyListeners();
  }

  Future<void> incrementCravings() async {
    if (_user == null) return;

    _user = _user!.copyWith(cravingsReported: _user!.cravingsReported + 1);
    _user = await _userRepository.save(_user!);
    notifyListeners();
  }

  Future<void> logout() async {
    await _googleAuthService.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> _run(Future<void> Function() action) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await action();
    } catch (error) {
      debugPrint('Google sign-in failed: $error');
      _errorMessage = 'Nao foi possivel entrar com Google. Tente novamente.';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
