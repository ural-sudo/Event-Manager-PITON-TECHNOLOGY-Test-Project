
import 'package:event_manager/core/cache/shared_cache.dart';
import 'package:event_manager/view/add_event/view/add_event_page.dart';
import 'package:event_manager/view/add_event/viewModel/create_page_cubit.dart';
import 'package:event_manager/view/auth/login/view/login.dart';
import 'package:event_manager/view/dashboard/view/dashboard.dart';
import 'package:event_manager/view/dashboard/viewModel/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<DashBoardCubit>(create: (context) {
        return DashBoardCubit();
      },),
      BlocProvider<CreatePageCubit>(create: (context){
        return CreatePageCubit();
      }),
    ],
     child: EventManager()
    )
  );
}

class EventManager extends StatelessWidget {
  EventManager({Key? key}) : super(key: key);
  
  final SharedManager manager = SharedManager();

  String? result;
  
  Future<bool> getPref() async {
    final result = await manager.getPref("Authenticated");

    if(result == "true"){
      return true;
    }else{
      return false;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    
    return 
    MaterialApp(
      title: 'Event Manager',
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:{
        "/" : (context) => FutureBuilder<bool>(
          future: getPref(),
          builder: (context,snapshot){
          bool value = snapshot.data ?? false;
          return value ? const DashBoardPage() :  const LoginPage();
        }),
        "/login":(context) => const LoginPage(),
        "/dashboard":(context) => const DashBoardPage(),
        "/add":(context) => CreateEventPage(isUpdate: false),
        "/updateEvent":(context) => CreateEventPage(isUpdate: true)
      } ,
      /* home:FutureBuilder<bool>(
        future: getPref(),
        builder:(context, snapshot){
          bool value = snapshot.data ?? false;
          return value ? const DashBoardPage() : const LoginPage();
        } ,
      )  */
    );
  }
}

