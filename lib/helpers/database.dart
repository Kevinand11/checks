import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

const int DatabaseVersionNumber = 1;

class Database {
	static final Database _instance = new Database._singeton();

	factory Database() => _instance;

	Database._singeton();

	sql.Database _db;

	Future<sql.Database> get connection async {
		if(_db == null) _db = await initDb();
		return _db;
	}

	initDb() async {
		final String databasesPath = await sql.getDatabasesPath();
		final String dbpath = path.join(databasesPath, 'main.db');

		return await sql.openDatabase(dbpath,
			version: DatabaseVersionNumber,
			onCreate: _onCreate,
			onUpgrade: _onUpgrade
		);
	}

	_onCreate(sql.Database db, int version) async {
		await db.execute("CREATE TABLE IF NOT EXISTS entries(id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER, month integer, day integer, price INTEGER, title TEXT, description TEXT)");
	}

	_onUpgrade(sql.Database db, int oldVersion, int newVersion) async {
		await db.execute("CREATE TABLE IF NOT EXISTS entries(id INTEGER PRIMARY KEY AUTOINCREMENT, year INTEGER, month integer, day integer, price INTEGER, title TEXT, description TEXT)");
	}
}
