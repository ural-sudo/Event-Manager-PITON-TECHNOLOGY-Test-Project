
import 'package:event_manager/core/widget/icon/delete_icon.dart';
import 'package:event_manager/view/add_event/viewModel/create_page_cubit.dart';
import 'package:event_manager/view/dashboard/viewModel/dashboard_cubit.dart';
import 'package:event_manager/view/dashboard/viewModel/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constant/color_constants.dart';
import '../../add_event/viewModel/create_page_state.dart';
import '../model/eventModel.dart';

class IconRow extends StatefulWidget {
  const IconRow({
    Key? key,
    required this.model,
    required this.size,
    required this.id,
    
  }) : super(key: key);

  final Size size;
  final int id;
  final EventModel model;

  @override
  State<IconRow> createState() => _IconRowState();
}

class _IconRowState extends State<IconRow> {

  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget.size.width*0.20,
      child: BlocBuilder<DashBoardCubit,DashboardState>(
        builder: (context, state) {
          return Row(
            children: [
            ListRowIcon(
            size: widget.size,
            iconData: Icons.edit,
            iconColor: ProjectColors.specialBlue,
            press: (){
              context.read<DashBoardCubit>().getEvent(widget.id.toString());
              Navigator.of(context).pushNamed("/updateEvent",arguments: [widget.model,widget.id],);
            },
          ),
          ListRowIcon(
            size: widget.size,
            iconData: Icons.delete,
            iconColor: Colors.pink,
            press: (){
              context.read<DashBoardCubit>().delete(widget.id);
              Navigator.of(context).pushReplacementNamed("/dashboard");
            },
          ),
          ListRowIcon(
            size: widget.size,
            iconData: Icons.person_pin_outlined,
            iconColor: ProjectColors.errorColor,
            press: (){
              context.read<DashBoardCubit>().getEvent(widget.id.toString());
              String name = state.model?.name ?? "";
              context.read<CreatePageCubit>().getParticipant(widget.id.toString());
              String firstName = context.read<CreatePageCubit>().model?.firstName ?? "";
              String lastName= context.read<CreatePageCubit>().model?.lastName ?? "";
              String contact= context.read<CreatePageCubit>().model?.contact ?? "";
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text("Participants of $name event"),
                    content: SizedBox(
                      height: widget.size.height *0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("firstName",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              Text("LastName",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                              Text("Contact",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold))
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              Text("$firstName",style: const TextStyle(fontSize: 12,),),
                              Text("$lastName",style: const TextStyle(fontSize: 12),),
                              Text("$contact",style:const  TextStyle(fontSize: 12),),
                              
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              );
            },
          ),
          ],
          );
        },
      ),
    );
  }
}
class SucsessContainer extends StatelessWidget {
  const SucsessContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePageCubit,CreatePageState>(builder: (context, state) {
      return state.isSuccessfull == 'Process Sucsessfull' ? Container(
        color: ProjectColors.succsessColor,
        width: size.width,
        child: Padding(
          padding:const  EdgeInsets.all(8.0),
          child:  Text(state.isSuccessfull,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        )
      ): const SizedBox.shrink();
    },);
  }
}



class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:size.width ,
      child: const Card(
        color:  Color(0xA98EE3EF),
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text("Welcome Automation Test User"),
        ),
      ),
    );
  }
}

class ListRow extends StatelessWidget {
  const ListRow({
    Key? key,
    required this.size,
    required this.itemDate,
    required this.itemId,
    required this.itemName,
    required this.itemDescription
  }) : super(key: key);

  final Size size;
  final String itemName;
  final String itemId;
  final String itemDescription;
  final String itemDate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
          ListRowItem(size: size,item: itemId,),
          ListRowItem(size: size,item: itemName,),
          ListRowItem(size: size,item: itemDescription,),
          ListRowItem(size: size,item: itemDate,),
      ],
    );
  }
}

class ListRowItem extends StatelessWidget {
  const ListRowItem({
    Key? key,
    required this.size,
    required this.item,
  }) : super(key: key);

  final Size size;
  final String item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width*0.16,
      child: Container(
        alignment: Alignment.centerLeft,
        height: size.height*0.042,
        child: Text(item,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 10,color:ProjectColors.rowItemColors),),
      ),
    );
  }
}

class DescriptionRow extends StatelessWidget {
   DescriptionRow({
    required this.size,
    Key? key,
  }) : super(key: key);
  Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width*0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DescriptionRowTexts(descriptionText: "ID",size: size,),
          DescriptionRowTexts(descriptionText: "Name",size: size,),
          DescriptionRowTexts(descriptionText: "Description",size: size,),
          DescriptionRowTexts(descriptionText: "Date",size: size,),
        ],
      ),
    );
  }
}

class DescriptionRowTexts extends StatelessWidget {
   DescriptionRowTexts({
    required this.descriptionText,
    required this.size,
    Key? key,
  }) : super(key: key);

  String descriptionText;
  Size size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width*0.16,
      child: Text(descriptionText,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),));
  }
}