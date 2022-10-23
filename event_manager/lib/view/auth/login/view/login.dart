

import 'dart:async';

import 'package:event_manager/core/cache/shared_cache.dart';
import 'package:event_manager/core/constant/color_constants.dart';
import 'package:event_manager/core/widget/button/button.dart';
import 'package:event_manager/view/dashboard/view/dashboard.dart';
import 'package:event_manager/view/dashboard/viewModel/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../dashboard/viewModel/dashboard_state.dart';
import 'login_product.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> key = GlobalKey();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String btnText = "Login";
    String usernameHintandLabelText = "Username";
    String passwordHintAndLabelText = "Password";
    return  Scaffold(
      backgroundColor:Color(0xFFEEECEC),
      appBar:AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body:SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(size.width*0.014),
            child: SizedBox(
              height: size.height*0.6,
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                color: ProjectColors.white,
                child: Padding(
                  padding: LoginPaddings.formGeneralPadding,
                  child: Form(
                    key: key,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                          Padding(
                           padding:LoginPaddings.titlePadding,
                           child: const LoginFormTitle(),
                         ),
                          const Divider(color:Colors.black),
                          LoginFormTextItem(
                            hintText: usernameHintandLabelText,
                            labelText:usernameHintandLabelText,
                            controller: usernameController,
                          ),
                          LoginFormTextItem(
                            hintText: passwordHintAndLabelText,
                            labelText: passwordHintAndLabelText,
                            controller: passwordController,
                            obsecureText: true,
                          ),
                          BlocBuilder<DashBoardCubit,DashboardState>(
                            builder: (context, state){
                              return ProjectButtons(
                            size: size,
                            btnText:btnText,
                            press: (){
                              key.currentState?.validate();
                              //context.read<DashBoardCubit>().get();
                              AuthControlAndSave().isEqual(usernameController.text, passwordController.text, context);                             
                            },
                          );
                            },)
                          
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthControlAndSave {
  void isEqual(String username, String password, BuildContext context){
    if(username == "automationtest" && password == "123456789"){
      userIsAuthenticated();
      Navigator.of(context).pushReplacementNamed("/dashboard");
  }
}
}

Future<void> userIsAuthenticated() async {
  final SharedManager manager = SharedManager();
  await manager.savePref("Authenticated", "true");
}


class LoginPaddings {
  static EdgeInsets titlePadding =const  EdgeInsets.only(top: 10.0);
  static EdgeInsets formGeneralPadding = const  EdgeInsets.all(8.0);
}
