

import 'package:event_manager/view/add_event/model/participant_model.dart';
import 'package:sqflite/sqflite.dart';

class ParticipantService {

  late Database database;

   String _dbName = "parti";
   String _tableName = "participant";
   String _columnId = "id";
   String _columnFirstName = "firstname";
   String _columnLastName = "lastname";
   String _columnContact = "contact";
   
   
   Future<void> openDb() async {
    
    database = await openDatabase(_dbName,version: 1,onCreate: (db, version) {
      db.execute(
        '''CREATE TABLE $_tableName(
          $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $_columnFirstName TEXT,
          $_columnLastName TEXT,
          $_columnContact TEXT)'''
        );
    },);
  }

  Future<void> insertParticipantToDb(ParticipantModel model) async {
    await openDb();
    await database.insert(_tableName, model.toJson());
  }

  Future<List<ParticipantModel>> getPartiFromDb() async {
    await openDb();
    List<Map<String,dynamic>> partiList = await database.rawQuery("SELECT * FROM $_tableName");
    return partiList.map((e) => ParticipantModel.fromJson(e)).toList();
  }

  Future<ParticipantModel> getSingleParticipant(String id) async {
    await openDb();
    List<Map<String,dynamic>> list =await database.rawQuery("SELECT * FROM $_tableName WHERE id = $id");

    var satir = list[0];

    return ParticipantModel(id:satir["id"],firstName: satir["firstname"],lastName: satir["lastname"],contact: satir["contact"]);
  }
  Future<void> editParticipant(int id, String firstName,String lastName, String contact) async {
    await openDb();
    var editedModel = Map<String,dynamic>();
    editedModel["$_columnFirstName"] = firstName;
    editedModel["$_columnLastName"] = lastName;
    editedModel["$_columnContact"] = contact;  

     await database.update(
      _tableName,
      editedModel,
      where: '$_columnId = ?',
      whereArgs: [id],
    );
  }
 
}