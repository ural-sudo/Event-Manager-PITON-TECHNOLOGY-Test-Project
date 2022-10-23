

import 'package:event_manager/view/dashboard/model/eventModel.dart';
import 'package:sqflite/sqflite.dart';

class EventServiceManager{

  late Database database;
   

  String _dbName = "manager";
  String _tableName = "event"; 
  String _columnId = "id";
  String _columnEventName ="name";
  String _columnDescription ="description";
  String _columnDate = "date";
  String _columnParticipantId = "participantId";

  Future<void> openDb() async {
    
    database = await openDatabase("manager",version: 1,onCreate: (db, version) {
      db.execute(
        '''CREATE TABLE event(
          $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnEventName TEXT,
          $_columnDescription TEXT,
          $_columnDate TEXT,
          $_columnParticipantId TEXT
          )'''
        );
    },);
  }

  Future<List<EventModel>> getEventsFromDb() async {
    await openDb();
    List<Map<String,dynamic>> eventList = await database.rawQuery("SELECT * FROM $_tableName");
    close();
    return eventList.map((e) => EventModel.fromJson(e)).toList();
    
  }
  
  Future<void> insertEventToDb (EventModel model) async {
    await openDb();
    await database.insert("event", model.toJson());
  }

  Future<void> editEvent(int id, String name,String desc, String date) async {
    await openDb();
    var editedModel = Map<String,dynamic>();
    editedModel["$_columnEventName"] = name;
    editedModel["$_columnDescription"] = desc;
    editedModel["$_columnDate"] = date;  

     await database.update(
      _tableName,
      editedModel,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
  Future<int> deleteFromDb (int id) async {
    await openDb();
   final result = database.delete(
    _tableName,
    where:"$_columnId = ?",
    whereArgs: [id],
   );
   return result;
  }
  Future<EventModel> getSingleEvent(String id) async {
    await openDb();
    List<Map<String,dynamic>> list =await database.rawQuery("SELECT * FROM $_tableName WHERE id = $id");

    var satir = list[0];

    return EventModel(id:satir["id"],name: satir["name"],description: satir["description"],date: satir["date"]);
  }
  Future close() async => database.close(); 

}    