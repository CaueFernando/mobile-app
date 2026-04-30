import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;
  bool get isConfigured => _user?.isConfigured ?? false;

  void initializeIfNeeded() {
    _user ??= User(
      name: 'Usuario',
      email: 'user@example.com',
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      totalPuffs: 0,
      totalCigarettes: 0,
      cravingsReported: 0,
      language: 'pt',
      petName: 'Puff',
      smokingType: SmokingType.cigarette,
      dailyUsage: 10,
      vapePrice: 50,
      vapeDurationDays: 7,
      cigarettePackPrice: 10,
      dailyCigarettes: 10,
      isConfigured: false,
    );
  }

  void createUser({
    required String name,
    required String email,
    required String language,
    required String petName,
    required SmokingType smokingType,
    required int dailyUsage,
    double vapePrice = 50,
    int vapeDurationDays = 7,
    double cigarettePackPrice = 10,
    int dailyCigarettes = 10,
  }) {
    _user = User(
      name: name,
      email: email,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      totalPuffs: 0,
      totalCigarettes: 0,
      cravingsReported: 0,
      language: language,
      petName: petName,
      smokingType: smokingType,
      dailyUsage: dailyUsage,
      vapePrice: vapePrice,
      vapeDurationDays: vapeDurationDays,
      cigarettePackPrice: cigarettePackPrice,
      dailyCigarettes: dailyCigarettes,
      isConfigured: true,
    );
    notifyListeners();
  }

  void updateConfiguration({
    String? language,
    String? petName,
    SmokingType? smokingType,
    int? dailyUsage,
    double? vapePrice,
    int? vapeDurationDays,
    double? cigarettePackPrice,
    int? dailyCigarettes,
  }) {
    initializeIfNeeded();
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
    notifyListeners();
  }

  void markAsConfigured() {
    initializeIfNeeded();
    _user = _user!.copyWith(isConfigured: true);
    notifyListeners();
  }

  void updateUser(User user) {
    _user = user.copyWith(lastLogin: DateTime.now());
    notifyListeners();
  }

  void incrementPuffs() {
    if (_user != null) {
      _user = _user!.copyWith(totalPuffs: _user!.totalPuffs + 1);
      notifyListeners();
    }
  }

  void incrementCigarettes() {
    if (_user != null) {
      _user = _user!.copyWith(totalCigarettes: _user!.totalCigarettes + 1);
      notifyListeners();
    }
  }

  void incrementCravings() {
    if (_user != null) {
      _user = _user!.copyWith(cravingsReported: _user!.cravingsReported + 1);
      notifyListeners();
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
