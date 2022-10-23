
import 'dart:async';
import 'package:event_manager/core/cache/shared_cache.dart';
import 'package:event_manager/core/constant/color_constants.dart';
import 'package:event_manager/view/add_event/view/add_event_page.dart';
import 'package:event_manager/view/add_event/viewModel/create_page_cubit.dart';
import 'package:event_manager/view/add_event/viewModel/create_page_state.dart';
import 'package:event_manager/view/auth/login/view/login.dart';
import 'package:event_manager/view/dashboard/model/eventModel.dart';
import 'package:event_manager/view/dashboard/service/event_service_manager.dart';
import 'package:event_manager/view/dashboard/view/dashboard_product.dart';
import 'package:event_manager/view/dashboard/viewModel/dashboard_cubit.dart';
import 'package:event_manager/view/dashboard/viewModel/dashboard_state.dart';
import 'package:event_manager/view/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  SharedManager smanager = SharedManager();
  List<EventModel>? list;
  late EventServiceManager manager;


  @override
  void initState() {
    super.initState();  
    manager = EventServiceManager();
    get(); 
  }
   Future<void> get() async {
      list  = await manager.getEventsFromDb();
      if(list != null){
        print(list);
      }
      setState(() {
        
    });
  } 
  Future<void> delete() async {
    await smanager.removePref("Authenticated");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<CreatePageCubit,CreatePageState>(
      builder: (context, state) {
      return state.isInsert ? const Splash() 
      :BlocBuilder<DashBoardCubit,DashboardState>(  
        builder: (context, state) {
        return state.isLoading ? Splash() : Scaffold(
      backgroundColor: ProjectColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: ProjectColors.specialBlue,
        title:  const Text("Dashboard",),
        actions: [
          TextButton(onPressed: ()async {
            delete();
            Navigator.of(context).pushReplacementNamed("/login");
          }, 
          child: Text("LogOut",style:TextStyle(color: ProjectColors.white),))
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              WelcomeWidget(size: size),
               Card(
                color:ProjectColors.white,
                child:Padding(
                  padding: const EdgeInsets.only(right: 4,left: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SucsessContainer(size: size),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Events",style: TextStyle(color: ProjectColors.black,fontWeight: FontWeight.bold),),
                          TextButton(onPressed: (){
                            Navigator.of(context).pushNamed("/add",);
                          }, child: Text("Create Event",style: TextStyle(color: ProjectColors.black),))
                        ]
                      ),
                      Divider(color: ProjectColors.black),
                      DescriptionRow(size: size,),
                      list?.length != 0 ? SizedBox(
                        height: size.height*0.6,
                        child:ListView.builder(
                          itemCount:list?.length ,
                          itemBuilder:(context,index){
                            return Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(width: 0.1,),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: size.width*0.7,
                                      child: ListRow(
                                        size: size,
                                        itemId: (list?[index].id ?? "").toString(),
                                        itemName: (list?[index].name ??"").toString(),
                                        itemDescription: (list?[index].description ?? "").toString(),
                                        itemDate: (list?[index].date ?? "").toString(),
                                      ),
                                    ),
                                    IconRow(size: size,id:list?[index].id ?? 0,model:list?[index] ?? EventModel(),)
                                  ],
                                ),
                              ),
                            );
                          } , 
                        ) ,
                      ) :  Padding(
                        padding:  EdgeInsets.only(top: size.height*0.2),
                        child: Container(
                            width: size.width,
                            color: ProjectColors.errorColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 25),
                              child: Text(
                                " No registered event found !"
                              ,style: TextStyle(color: ProjectColors.white ,fontWeight: FontWeight.bold,fontSize: 20),
                              ),
                            )
                          ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ); 
        },
      );   
    },
    );
  }
}



