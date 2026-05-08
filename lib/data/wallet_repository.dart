import 'package:sqflite/sqflite.dart';

import 'local_database.dart';

class WalletSnapshot {
  const WalletSnapshot({
    required this.walletId,
    required this.moneySaved,
    required this.vcoins,
  });

  final int walletId;
  final double moneySaved;
  final int vcoins;
}

class WalletRepository {
  WalletRepository({LocalDatabase? database})
      : _localDatabase = database ?? LocalDatabase.instance;

  final LocalDatabase _localDatabase;

  Future<WalletSnapshot> getOrCreateForUser(int userId) async {
    final database = await _localDatabase.database;
    final walletId = await _getOrCreateWalletId(database, userId);
    final moneySaved = await _getOrCreateLatestMoney(database, walletId);
    final vcoins = await _getOrCreateLatestCoins(database, walletId);

    return WalletSnapshot(
      walletId: walletId,
      moneySaved: moneySaved,
      vcoins: vcoins,
    );
  }

  Future<void> recordMoneySaved({
    required int walletId,
    required double amount,
  }) async {
    final database = await _localDatabase.database;
    await database.insert('money_data', {
      'wallet_id': walletId,
      'amount_cents': (amount * 100).round(),
      'created_at': DateTime.now().toIso8601String(),
    });
    await _touchWallet(database, walletId);
  }

  Future<void> recordCoins({
    required int walletId,
    required int amount,
  }) async {
    final database = await _localDatabase.database;
    await database.insert('coin_data', {
      'wallet_id': walletId,
      'amount': amount,
      'created_at': DateTime.now().toIso8601String(),
    });
    await _touchWallet(database, walletId);
  }

  Future<int> _getOrCreateWalletId(Database database, int userId) async {
    final rows = await database.query(
      'wallet',
      columns: ['id'],
      where: 'user_id = ? AND is_active = 1',
      whereArgs: [userId],
      orderBy: 'id DESC',
      limit: 1,
    );

    if (rows.isNotEmpty) return rows.first['id'] as int;

    final now = DateTime.now().toIso8601String();
    final walletId = await database.insert('wallet', {
      'user_id': userId,
      'created_at': now,
      'updated_at': now,
      'is_active': 1,
    });

    await database.insert('money_data', {
      'wallet_id': walletId,
      'amount_cents': 0,
      'created_at': now,
    });
    await database.insert('coin_data', {
      'wallet_id': walletId,
      'amount': 0,
      'created_at': now,
    });

    return walletId;
  }

  Future<double> _getOrCreateLatestMoney(
    Database database,
    int walletId,
  ) async {
    final rows = await database.query(
      'money_data',
      columns: ['amount_cents'],
      where: 'wallet_id = ?',
      whereArgs: [walletId],
      orderBy: 'id DESC',
      limit: 1,
    );

    if (rows.isNotEmpty) {
      return ((rows.first['amount_cents'] as int) / 100).toDouble();
    }

    await database.insert('money_data', {
      'wallet_id': walletId,
      'amount_cents': 0,
      'created_at': DateTime.now().toIso8601String(),
    });
    return 0;
  }

  Future<int> _getOrCreateLatestCoins(Database database, int walletId) async {
    final rows = await database.query(
      'coin_data',
      columns: ['amount'],
      where: 'wallet_id = ?',
      whereArgs: [walletId],
      orderBy: 'id DESC',
      limit: 1,
    );

    if (rows.isNotEmpty) return rows.first['amount'] as int;

    await database.insert('coin_data', {
      'wallet_id': walletId,
      'amount': 0,
      'created_at': DateTime.now().toIso8601String(),
    });
    return 0;
  }

  Future<void> _touchWallet(Database database, int walletId) async {
    await database.update(
      'wallet',
      {'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [walletId],
    );
  }
}
