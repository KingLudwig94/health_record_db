import 'package:floor/floor.dart';
import 'package:health_record_db/model/entities/patients.dart';

//Here, we are saying to floor that this is a class that defines an entity
@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['patient'],
      parentColumns: ['id'],
      entity: Patient,
    )
  ],
)
class HeartRate {
  //id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;

  //The hr value
  final int hr;

  //When the meal occured
  final DateTime dateTime;

  final int patient;

  //Default constructor
  HeartRate({this.id, required this.hr, required this.dateTime, required this.patient});
} //HeartRates