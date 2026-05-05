import 'package:sqflite/sqflite.dart';

import '../models/user_model.dart';
import 'local_database.dart';

class UserRepository {
  UserRepository({LocalDatabase? database})
      : _localDatabase = database ?? LocalDatabase.instance;

  final LocalDatabase _localDatabase;

  Future<User?> findByGoogleId(String googleId) async {
    final database = await _localDatabase.database;
    final rows = await database.query(
      'app_user',
      where: 'google_id = ?',
      whereArgs: [googleId],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return _fromRow(rows.first);
  }

  Future<User?> findByEmail(String email) async {
    final database = await _localDatabase.database;
    final rows = await database.query(
      'app_user',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (rows.isEmpty) return null;
    return _fromRow(rows.first);
  }

  Future<User> upsertGoogleUser({
    required String googleId,
    required String name,
    required String email,
    String? photoUrl,
  }) async {
    final now = DateTime.now();
    final existing = await findByGoogleId(googleId) ?? await findByEmail(email);

    if (existing != null) {
      final updated = existing.copyWith(
        googleId: googleId,
        name: name,
        email: email,
        photoUrl: photoUrl,
        lastLogin: now,
      );
      return save(updated);
    }

    final user = User(
      googleId: googleId,
      name: name,
      email: email,
      photoUrl: photoUrl,
      createdAt: now,
      lastLogin: now,
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

    final id = await insert(user);
    return user.copyWith(id: id);
  }

  Future<int> insert(User user) async {
    final database = await _localDatabase.database;
    return database.insert('app_user', _toRow(user));
  }

  Future<User> save(User user) async {
    final database = await _localDatabase.database;
    final id = user.id;

    if (id == null) {
      final insertedId = await insert(user);
      return user.copyWith(id: insertedId);
    }

    await database.update(
      'app_user',
      _toRow(user, updateTimestamp: true),
      where: 'id = ?',
      whereArgs: [id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  User _fromRow(Map<String, Object?> row) {
    final createdAt = DateTime.parse(row['created_at'] as String);
    final lastLogin = DateTime.parse(row['last_login'] as String);

    return User(
      id: row['id'] as int?,
      googleId: row['google_id'] as String?,
      name: row['name'] as String,
      email: (row['email'] as String?) ?? '',
      photoUrl: row['photo_url'] as String?,
      createdAt: createdAt,
      lastLogin: lastLogin,
      totalPuffs: row['total_puffs'] as int,
      totalCigarettes: row['total_cigarettes'] as int,
      cravingsReported: row['cravings_reported'] as int,
      language: row['language'] as String,
      petName: row['pet_name'] as String,
      smokingType: SmokingType.values.firstWhere(
        (type) => type.name == row['smoking_type'],
        orElse: () => SmokingType.cigarette,
      ),
      dailyUsage: row['daily_usage'] as int,
      vapePrice: ((row['vape_price_cents'] as int) / 100),
      vapeDurationDays: row['vape_duration_days'] as int,
      cigarettePackPrice: ((row['cigarette_pack_price_cents'] as int) / 100),
      dailyCigarettes: row['daily_cigarettes'] as int,
      isConfigured: row['is_configured'] == 1,
    );
  }

  Map<String, Object?> _toRow(
    User user, {
    bool updateTimestamp = false,
  }) {
    final now = DateTime.now().toIso8601String();
    final updatedAt = updateTimestamp ? now : user.createdAt.toIso8601String();

    return {
      'google_id': user.googleId,
      'name': user.name,
      'email': user.email,
      'photo_url': user.photoUrl,
      'auth_provider': 'google',
      'language': user.language,
      'pet_name': user.petName,
      'smoking_type': user.smokingType.name,
      'daily_usage': user.dailyUsage,
      'vape_price_cents': (user.vapePrice * 100).round(),
      'vape_duration_days': user.vapeDurationDays,
      'cigarette_pack_price_cents': (user.cigarettePackPrice * 100).round(),
      'daily_cigarettes': user.dailyCigarettes,
      'total_puffs': user.totalPuffs,
      'total_cigarettes': user.totalCigarettes,
      'cravings_reported': user.cravingsReported,
      'is_configured': user.isConfigured ? 1 : 0,
      'created_at': user.createdAt.toIso8601String(),
      'updated_at': updatedAt,
      'last_login': user.lastLogin.toIso8601String(),
    };
  }
}
