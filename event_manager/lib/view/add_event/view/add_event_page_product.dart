
import 'package:event_manager/core/widget/icon/delete_icon.dart';
import 'package:flutter/material.dart';

class AddParticipantList extends StatefulWidget {
  AddParticipantList({Key? key, required this.firstNameController, required this.lastNameController, required this.contactController,}) : super(key: key);

  TextEditingController firstNameController;
  TextEditingController lastNameController;
  TextEditingController contactController;
  @override
  State<AddParticipantList> createState() => _AddParticipantListState();
}

class _AddParticipantListState extends State<AddParticipantList> {

  

  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                  onPressed: (){
                  setState(() {
                  itemCount += 1;
                  });
                  }, child: Text("Add Participant")),
                ),
                itemCount == 0 ? Text("Please add participant") : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                        padding: const EdgeInsets.all(4.0),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: AddParticipantItem(
                                controller: widget.firstNameController,
                                size: size,
                                hinText: "First Name",
                                labelText: "First Name",
                                description: "First Name",
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: AddParticipantItem(
                                controller: widget.lastNameController,
                                size: size,
                                hinText: "Last Name",
                                labelText: "Last Name",
                                description: "Last Name",
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: AddParticipantItem(
                                controller: widget.contactController,
                                size: size,
                                hinText: "Contact",
                                labelText: "Contact",
                                description: "Contact",
                              )
                            ),
                            ListRowIcon(
                              iconData: Icons.delete,
                              size: size,
                              iconColor: Colors.red,
                              iconSize: 25,
                              press: (){
                                setState(() {
                                  itemCount -= 1;
                                });
                              }
                            )      
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
  }
}

class AddParticipantItem extends StatelessWidget {
   AddParticipantItem({
    Key? key,
     required this.hinText, 
     required this.labelText, 
     required this.description,
     required this.size,
     required this.controller
  }) : super(key: key);
  final String hinText;
  final String labelText;
  final String description;
  TextEditingController controller;
  Size size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Text(description),
       SizedBox(
        width: size.width*0.25,
        height: size.width*0.2,
         child: TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 12),
          decoration:InputDecoration(
            filled: true,
            fillColor:const Color(0xFFF2F1F1) ,
            hintText: hinText,
            labelText: labelText,
          ),
         ),
       )
      ],
    );
  }
}
class FormDateTextField extends StatefulWidget {
    FormDateTextField({
    Key? key,
    required this.size,
    required this.controller,
    }) :super(key: key);
    
  final Size size;
  TextEditingController controller;

  @override
  State<FormDateTextField> createState() => _FormDateTextFieldState();
}

class _FormDateTextFieldState extends State<FormDateTextField> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.size.width,
      child: Container(
        decoration: BoxDecoration(
          color:const  Color(0xFFF2F1F1),
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        
        child: Row(
          children: [
            SizedBox(
              width: widget.size.width*0.85,
              height: widget.size.height*0.08,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  validator: (value) {
                    if(value?.isNotEmpty == false){
                      return "This field not be empty";
                    }
                  },
                  controller: widget.controller,
                  style: const TextStyle(fontSize: 12), 
                  decoration: const InputDecoration(
                    border:InputBorder.none,
                    hintText: "Event Date",
                    labelText: "Event Date"
                  ),
                ),
              )
            ),
            IconButton(
              constraints:const BoxConstraints(),
              padding: EdgeInsets.zero ,
              onPressed: (){
                showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(1920), 
                  lastDate: DateTime(2023)
                ).then((value) {
                  setState(() {
                    if(value != null){
                      String day = value.day.toString();
                      String month = value.month.toString();
                      String year = value.year.toString();
                      String dateText ="$month/$day/$year";
                      widget.controller.text = dateText;
                    }
                  });
                });
              },
              icon: const Icon(Icons.date_range_outlined)
            )
          ],
        )
      ),
    );
  }
}
class AddEventFormTextField extends StatelessWidget {
   const AddEventFormTextField({
    Key? key,
    required this.size,
    required this.hintText,
    required this.labelText,
    required this.controller,
    
  }) : super(key: key);

  final Size size;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:size.height*0.02 ),
      child: SizedBox(
        width: size.width,
        height: size.height*0.08,
        child: TextFormField(
          style:const TextStyle(fontSize: 12) ,
          controller: controller,
          
          validator: (value){
            if(value?.isNotEmpty == false){
              return "This field not be empty";
            }
          },
          decoration:InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            labelText: labelText,
            filled: true,
            fillColor: Color(0xFFF2F1F1)
          ),
        ),
      ),
    );
  }
}