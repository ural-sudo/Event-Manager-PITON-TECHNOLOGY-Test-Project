

import '../model/eventModel.dart';

class DashboardState{

  bool isLoading;
  
  EventModel? model = EventModel();
  List<EventModel>? eventList = [];

  DashboardState({ this.eventList, this.isLoading = false, this.model});

}