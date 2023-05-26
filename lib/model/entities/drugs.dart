import 'package:floor/floor.dart';

import 'entities.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['patient'],
      parentColumns: ['id'],
      entity: Patient,
    )
  ],
)
class DrugIntake {
  int quantity;
  String name;
  int patient;
  int dateTime;
  String? note;

  @PrimaryKey(autoGenerate: true)
  int? id;
  DrugIntake(
      {required this.dateTime,
      required this.quantity,
      required this.name,
      this.id,
      this.note,
      required this.patient});
}
