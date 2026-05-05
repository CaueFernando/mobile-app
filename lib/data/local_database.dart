import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._();

  static final LocalDatabase instance = LocalDatabase._();

  static const _databaseName = 'steptostop.db';
  static const _databaseVersion = 2;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _createSchema,
      onUpgrade: _upgradeSchema,
    );

    return _database!;
  }

  Future<void> _createSchema(Database database, int version) async {
    await database.transaction((txn) async {
      await txn.execute('''
        CREATE TABLE app_user (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          google_id TEXT,
          name TEXT NOT NULL,
          email TEXT,
          photo_url TEXT,
          auth_provider TEXT NOT NULL DEFAULT 'google',
          language TEXT NOT NULL DEFAULT 'pt',
          pet_name TEXT NOT NULL DEFAULT 'Puff',
          smoking_type TEXT NOT NULL,
          daily_usage INTEGER NOT NULL DEFAULT 0,
          vape_price_cents INTEGER NOT NULL DEFAULT 0,
          vape_duration_days INTEGER NOT NULL DEFAULT 0,
          cigarette_pack_price_cents INTEGER NOT NULL DEFAULT 0,
          daily_cigarettes INTEGER NOT NULL DEFAULT 0,
          total_puffs INTEGER NOT NULL DEFAULT 0,
          total_cigarettes INTEGER NOT NULL DEFAULT 0,
          cravings_reported INTEGER NOT NULL DEFAULT 0,
          is_configured INTEGER NOT NULL DEFAULT 0,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          last_login TEXT NOT NULL
        )
      ''');

      await txn.execute('''
        CREATE TABLE pet (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          name TEXT NOT NULL,
          stage TEXT NOT NULL,
          mood TEXT NOT NULL,
          days_without_nicotine INTEGER NOT NULL DEFAULT 0,
          happiness INTEGER NOT NULL DEFAULT 80,
          health INTEGER NOT NULL DEFAULT 100,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE CASCADE
        )
      ''');

      await txn.execute('''
        CREATE TABLE wallet (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_id INTEGER NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          is_active INTEGER NOT NULL DEFAULT 1,
          FOREIGN KEY (user_id) REFERENCES app_user (id) ON DELETE CASCADE
        )
      ''');

      await txn.execute('''
        CREATE TABLE money_data (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          wallet_id INTEGER NOT NULL,
          amount_cents INTEGER NOT NULL,
          created_at TEXT NOT NULL,
          FOREIGN KEY (wallet_id) REFERENCES wallet (id) ON DELETE CASCADE
        )
      ''');

      await txn.execute('''
        CREATE TABLE coin_data (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          wallet_id INTEGER NOT NULL,
          amount INTEGER NOT NULL,
          created_at TEXT NOT NULL,
          FOREIGN KEY (wallet_id) REFERENCES wallet (id) ON DELETE CASCADE
        )
      ''');

      await txn.execute(
        'CREATE INDEX idx_pet_user_id ON pet (user_id)',
      );
      await txn.execute(
        'CREATE UNIQUE INDEX idx_app_user_google_id '
        'ON app_user (google_id) WHERE google_id IS NOT NULL',
      );
      await txn.execute(
        'CREATE INDEX idx_wallet_user_id ON wallet (user_id)',
      );
      await txn.execute(
        'CREATE INDEX idx_money_data_wallet_latest '
        'ON money_data (wallet_id, id DESC)',
      );
      await txn.execute(
        'CREATE INDEX idx_coin_data_wallet_latest '
        'ON coin_data (wallet_id, id DESC)',
      );
    });
  }

  Future<void> _upgradeSchema(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await database.transaction((txn) async {
        await txn.execute('ALTER TABLE app_user ADD COLUMN google_id TEXT');
        await txn.execute('ALTER TABLE app_user ADD COLUMN photo_url TEXT');
        await txn.execute(
          "ALTER TABLE app_user ADD COLUMN auth_provider TEXT "
          "NOT NULL DEFAULT 'google'",
        );
        await txn.execute(
          'CREATE UNIQUE INDEX IF NOT EXISTS idx_app_user_google_id '
          'ON app_user (google_id) WHERE google_id IS NOT NULL',
        );
      });
    }
  }

  Future<void> close() async {
    final database = _database;
    if (database == null) return;

    await database.close();
    _database = null;
  }
}
