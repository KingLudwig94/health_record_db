import 'package:floor/floor.dart';
import 'package:health_record_db/model/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class HeartRatesDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the HeartRate table of a certain date belonging to a patient
  @Query(
      'SELECT * FROM HeartRate WHERE dateTime between :startTime and :endTime and patient == :patient ORDER BY dateTime ASC')
  Future<List<HeartRate>> findHeartRatesbyDate(
      int patient, DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the HeartRate table
  @Query('SELECT * FROM HeartRate WHERE patient == :patient')
  Future<List<HeartRate>> findAllHeartRates(int patient);

  //Query #2: INSERT -> this allows to add a HeartRate in the table
  @insert
  Future<void> insertHeartRate(HeartRate heartRates);

  //Query #3: DELETE -> this allows to delete a HeartRate from the table
  @delete
  Future<void> deleteHeartRate(HeartRate heartRates);

  //Query #4: UPDATE -> this allows to update a HeartRate entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateHeartRate(HeartRate heartRates);

  //Query #4: SELECT
  @Query(
      'SELECT * FROM HeartRate WHERE patient=:patient and dateTime >= :time ORDER BY dateTime ASC')
  Future<List<HeartRate>> _findLastHourHeartRate(int patient, DateTime time);

  Future<List<HeartRate>> findLastHourHeartRate(int patient) {
    return _findLastHourHeartRate(
        patient, DateTime.now().subtract(const Duration(hours: 1)));
  }
}//HeartRatesDao