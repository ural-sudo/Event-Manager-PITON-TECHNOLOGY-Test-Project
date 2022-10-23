

import 'dart:async';

import 'package:event_manager/view/add_event/model/participant_model.dart';
import 'package:event_manager/view/add_event/service/participant_service_manager.dart';
import 'package:event_manager/view/add_event/viewModel/create_page_state.dart';
import 'package:event_manager/view/dashboard/model/eventModel.dart';
import 'package:event_manager/view/dashboard/service/event_service_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePageCubit extends Cubit<CreatePageState>{
  CreatePageCubit() : super(CreatePageState());

  EventServiceManager manager = EventServiceManager();
  ParticipantService service = ParticipantService();
  ParticipantModel? model;
  Future<void> insertDb (EventModel model) async {
    emit(CreatePageState(isInsert: true));
    await manager.insertEventToDb(model);
    message();
    emit(CreatePageState(isInsert: false,));
  }

  void message(){
    Timer(Duration(milliseconds: 3), () {
      emit(CreatePageState(isSuccessfull: "Process Sucsessfull",));
    },); 
    Timer(Duration(seconds: 3),() {
      emit(CreatePageState(isSuccessfull: ""));
    },);
  }

  Future<void> insertParticipant (ParticipantModel model) async {
    await service.insertParticipantToDb(model);
  }

  Future<void> getParticipant(String id) async {
    model = await service.getSingleParticipant(id);
    emit(CreatePageState(model: model));
  }

  Future<void> edit(int id , String firstName, String lastName ,String contact ) async {
    emit(CreatePageState(isInsert: true));
    await service.editParticipant(id,firstName,lastName,contact);
    message();
    emit(CreatePageState(isInsert: false,));
  }

}