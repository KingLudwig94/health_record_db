// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorEHRDb {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EHRDbBuilder databaseBuilder(String name) => _$EHRDbBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$EHRDbBuilder inMemoryDatabaseBuilder() => _$EHRDbBuilder(null);
}

class _$EHRDbBuilder {
  _$EHRDbBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$EHRDbBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$EHRDbBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<EHRDb> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$EHRDb();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$EHRDb extends EHRDb {
  _$EHRDb([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  HeartRatesDao? _heartRatesDaoInstance;

  PatientDao? _patientDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HeartRate` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `hr` INTEGER NOT NULL, `dateTime` INTEGER NOT NULL, `patient` INTEGER NOT NULL, FOREIGN KEY (`patient`) REFERENCES `Patient` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Patient` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `birthday` INTEGER NOT NULL, `sex` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DrugIntake` (`quantity` INTEGER NOT NULL, `name` TEXT NOT NULL, `patient` INTEGER NOT NULL, `dateTime` INTEGER NOT NULL, `id` INTEGER PRIMARY KEY AUTOINCREMENT, FOREIGN KEY (`patient`) REFERENCES `Patient` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HeartRatesDao get heartRatesDao {
    return _heartRatesDaoInstance ??= _$HeartRatesDao(database, changeListener);
  }

  @override
  PatientDao get patientDao {
    return _patientDaoInstance ??= _$PatientDao(database, changeListener);
  }
}

class _$HeartRatesDao extends HeartRatesDao {
  _$HeartRatesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _heartRateInsertionAdapter = InsertionAdapter(
            database,
            'HeartRate',
            (HeartRate item) => <String, Object?>{
                  'id': item.id,
                  'hr': item.hr,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'patient': item.patient
                }),
        _heartRateUpdateAdapter = UpdateAdapter(
            database,
            'HeartRate',
            ['id'],
            (HeartRate item) => <String, Object?>{
                  'id': item.id,
                  'hr': item.hr,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'patient': item.patient
                }),
        _heartRateDeletionAdapter = DeletionAdapter(
            database,
            'HeartRate',
            ['id'],
            (HeartRate item) => <String, Object?>{
                  'id': item.id,
                  'hr': item.hr,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'patient': item.patient
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HeartRate> _heartRateInsertionAdapter;

  final UpdateAdapter<HeartRate> _heartRateUpdateAdapter;

  final DeletionAdapter<HeartRate> _heartRateDeletionAdapter;

  @override
  Future<List<HeartRate>> findHeartRatesbyDate(
    int patient,
    DateTime startTime,
    DateTime endTime,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HeartRate WHERE dateTime between ?2 and ?3 and patient == ?1 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => HeartRate(
            id: row['id'] as int?,
            hr: row['hr'] as int,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int),
            patient: row['patient'] as int),
        arguments: [
          patient,
          _dateTimeConverter.encode(startTime),
          _dateTimeConverter.encode(endTime)
        ]);
  }

  @override
  Future<List<HeartRate>> findAllHeartRates(int patient) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HeartRate WHERE patient == ?1',
        mapper: (Map<String, Object?> row) => HeartRate(
            id: row['id'] as int?,
            hr: row['hr'] as int,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int),
            patient: row['patient'] as int),
        arguments: [patient]);
  }

  @override
  Future<List<HeartRate>> _findLastHourHeartRate(
    int patient,
    DateTime time,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HeartRate WHERE patient=?1 and dateTime>?2 ORDER BY dateTime ASC',
        mapper: (Map<String, Object?> row) => HeartRate(id: row['id'] as int?, hr: row['hr'] as int, dateTime: _dateTimeConverter.decode(row['dateTime'] as int), patient: row['patient'] as int),
        arguments: [patient, _dateTimeConverter.encode(time)]);
  }

  @override
  Future<void> insertHeartRate(HeartRate heartRates) async {
    await _heartRateInsertionAdapter.insert(
        heartRates, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateHeartRate(HeartRate heartRates) async {
    await _heartRateUpdateAdapter.update(
        heartRates, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteHeartRate(HeartRate heartRates) async {
    await _heartRateDeletionAdapter.delete(heartRates);
  }
}

class _$PatientDao extends PatientDao {
  _$PatientDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _patientInsertionAdapter = InsertionAdapter(
            database,
            'Patient',
            (Patient item) => <String, Object?>{
                  'id': item.id,
                  'birthday': _dateTimeConverter.encode(item.birthday),
                  'sex': item.sex
                }),
        _patientUpdateAdapter = UpdateAdapter(
            database,
            'Patient',
            ['id'],
            (Patient item) => <String, Object?>{
                  'id': item.id,
                  'birthday': _dateTimeConverter.encode(item.birthday),
                  'sex': item.sex
                }),
        _patientDeletionAdapter = DeletionAdapter(
            database,
            'Patient',
            ['id'],
            (Patient item) => <String, Object?>{
                  'id': item.id,
                  'birthday': _dateTimeConverter.encode(item.birthday),
                  'sex': item.sex
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Patient> _patientInsertionAdapter;

  final UpdateAdapter<Patient> _patientUpdateAdapter;

  final DeletionAdapter<Patient> _patientDeletionAdapter;

  @override
  Future<Patient?> findPatient(int patient) async {
    return _queryAdapter.query('SELECT * FROM Patient WHERE patient == ?1',
        mapper: (Map<String, Object?> row) => Patient(
            id: row['id'] as int?,
            birthday: _dateTimeConverter.decode(row['birthday'] as int),
            sex: row['sex'] as String),
        arguments: [patient]);
  }

  @override
  Future<void> insertPatient(Patient patients) async {
    await _patientInsertionAdapter.insert(patients, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePatient(Patient patients) async {
    await _patientUpdateAdapter.update(patients, OnConflictStrategy.fail);
  }

  @override
  Future<void> deletePatient(Patient patients) async {
    await _patientDeletionAdapter.delete(patients);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
