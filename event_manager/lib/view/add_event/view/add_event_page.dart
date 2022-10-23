
import 'package:event_manager/core/constant/color_constants.dart';
import 'package:event_manager/core/constant/padding_constants.dart';
import 'package:event_manager/core/widget/button/button.dart';
import 'package:event_manager/view/add_event/model/participant_model.dart';
import 'package:event_manager/view/add_event/viewModel/create_page_cubit.dart';
import 'package:event_manager/view/dashboard/model/eventModel.dart';
import 'package:event_manager/view/dashboard/view/dashboard.dart';
import 'package:event_manager/view/dashboard/viewModel/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_event_page_product.dart';
 
class CreateEventPage extends StatefulWidget {
   CreateEventPage({Key? key, required this.isUpdate}) : super(key: key);
   
   final bool isUpdate;
  @override
  State<CreateEventPage> createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {

  int itemCount = 1;
  int? _id; 
  EventModel? eventModel; 

  GlobalKey<FormState> globalKey = GlobalKey();
  
  late TextEditingController nameController; 
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var contactController = TextEditingController();
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    dateController = TextEditingController();
    Future.microtask(() {
      final model = ModalRoute.of(context)?.settings.arguments;
      final modelId = ModalRoute.of(context)?.settings.arguments;
      if(modelId is List){
        _id = modelId[1];
        
      }
      print(model);
      setState(() {
        eventModel = model is List ? model[0] : null ;
        nameController.text = eventModel?.name.toString() ?? "";
        descriptionController.text = eventModel?.description.toString() ?? "";
        dateController.text = eventModel?.date.toString() ?? "";
      });
    },);
  }
  


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:ProjectColors.scaffoldColor,
      appBar: AppBar(
        title: widget.isUpdate ? Text("Update Event ") :Text("Create Event "),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: ProjectPaddings.allFour,
            child: Card(
              color: Colors.white,
              child: Padding(
                padding: ProjectPaddings.allFour,
                child:
                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.isUpdate ?Text("Update Event",style: TextStyle(fontSize: 20),) :Text("Create Event",style: TextStyle(fontSize: 20),),
                        AddEventFormTextField(
                          size: size,
                          hintText: "Event Name",
                          labelText: "Event Name",
                          controller: nameController,
                        ),
                        AddEventFormTextField(
                          size: size,
                          hintText: "Event Description",
                          labelText: "Event Description",
                          controller: descriptionController,
                          
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: FormDateTextField(size: size,controller: dateController,),
                        )
                      ],
                    ),
                    
                    AddParticipantList(firstNameController: firstNameController,lastNameController: lastNameController,contactController: contactController,),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: ProjectButtons(
                          size: size,
                          press: (){
                             
                            if(widget.isUpdate){
                              final isvalid = globalKey.currentState!.validate();
                              if(isvalid){
                                EventModel editedEvent = EventModel(
                                name: nameController.text,
                                description: descriptionController.text,
                                date: dateController.text
                              );
                              ParticipantModel editedParticipant = ParticipantModel(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                contact: contactController.text
                              );
                              
                              context.read<CreatePageCubit>().edit(_id ?? 0,editedParticipant.firstName.toString() ,editedParticipant.lastName.toString(), editedParticipant.contact.toString());
                              context.read<DashBoardCubit>().edit(_id ?? 0,editedEvent.name.toString(),editedEvent.description.toString(),editedEvent.date.toString());
                              context.read<DashBoardCubit>().get();
                              Navigator.of(context).pushReplacementNamed("/dashboard");
                              }
                            }else{
                              final isValid = globalKey.currentState!.validate();
                              if(isValid){
                              ParticipantModel participantModel = ParticipantModel(
                              firstName:firstNameController.text ,
                              contact: contactController.text,
                              lastName: lastNameController.text,
                              );
                            
                              context.read<CreatePageCubit>().insertParticipant(participantModel);
                              final eventModel = EventModel(name: nameController.text,
                              description: descriptionController.text,
                              date: dateController.text,participantId:participantModel.id);
                              context.read<CreatePageCubit>().insertDb(eventModel);
                              context.read<DashBoardCubit>().get();
                              Navigator.of(context).pushReplacementNamed("/dashboard");
                              }
                              
                            }
                             
                          },
                          btnText:widget.isUpdate ? "Update Event" : "Create New Event",
                        )
                      ),
                  ],
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
