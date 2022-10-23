
import 'package:event_manager/view/add_event/model/participant_model.dart';

class CreatePageState {

  bool isInsert;
  String isSuccessfull;
  
  ParticipantModel? model = ParticipantModel();

  CreatePageState({
    this.isInsert = false,
    this.model,
    this.isSuccessfull = ""
    });
}