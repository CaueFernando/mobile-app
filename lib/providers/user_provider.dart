import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null;

  // Criar novo usuário
  void createUser(String name, String email) {
    _user = User(
      name: name,
      email: email,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      totalPuffs: 0,
      totalCigarettes: 0,
      cravingsReported: 0,
    );
    notifyListeners();
  }

  // Atualizar usuário
  void updateUser(User user) {
    _user = user.copyWith(lastLogin: DateTime.now());
    notifyListeners();
  }

  // Incrementar puffs
  void incrementPuffs() {
    if (_user != null) {
      _user = _user!.copyWith(totalPuffs: _user!.totalPuffs + 1);
      notifyListeners();
    }
  }

  // Incrementar cigarros
  void incrementCigarettes() {
    if (_user != null) {
      _user = _user!.copyWith(totalCigarettes: _user!.totalCigarettes + 1);
      notifyListeners();
    }
  }

  // Incrementar vontades relatadas
  void incrementCravings() {
    if (_user != null) {
      _user = _user!.copyWith(cravingsReported: _user!.cravingsReported + 1);
      notifyListeners();
    }
  }

  // Logout
  void logout() {
    _user = null;
    notifyListeners();
  }
}
