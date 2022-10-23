
import 'package:event_manager/view/dashboard/service/event_service_manager.dart';
import 'package:event_manager/view/dashboard/viewModel/dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/eventModel.dart';

class DashBoardCubit extends Cubit<DashboardState>{
  DashBoardCubit():super(DashboardState());

  final EventServiceManager manager = EventServiceManager();
  List<EventModel> list = [];
  EventModel? model;
  
  Future<void> get() async {
    emit(DashboardState(isLoading: true));
    list =await manager.getEventsFromDb();
    //print(list[0].name);
    emit(DashboardState(isLoading: false,eventList: list));
  }

  Future<void> delete(int id) async {
    emit(DashboardState(isLoading: true));
    await manager.deleteFromDb(id);
    emit(DashboardState(isLoading: false));
  }

  Future<void> edit(int id , String name, String desc, String date ) async {
    await manager.editEvent(id,name,desc,date);
  }
  Future<void> getEvent(String id) async {
    model = await manager.getSingleEvent(id);
    emit(DashboardState(model: model));
  }

}
