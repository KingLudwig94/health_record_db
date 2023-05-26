// Define a database to describe a simple
// Electronic Health Record containing:
// - patients information such as birthday, sex
// - heart rate data (full series of data)
// - drugs (time of intake, quantity, name and note)
// Write the required DAOs to insert and retrieve patient's information
// and the last hour of heart rate data

//Imports that are necessary to the code generator of floor
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'daos/dao.dart';
import 'entities/entities.dart';
import 'typeConverters/dateTimeConverter.dart';

//Here, we are importing the entities and the daos of the database

//The generated code will be in db.g.dart
part 'db.g.dart';

//Here we are saying that this is the first version of the Database.
//We also added a TypeConverter to manage the DateTime of an entry, since DateTimes are not natively
//supported by Floor.
@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [HeartRate, Patient, DrugIntake])
abstract class EHRDb extends FloorDatabase {
  //Add all the daos as getters here
  HeartRatesDao get heartRatesDao;
  PatientDao get patientDao;
}//AppDatabase
