import 'package:lavona/providers/auth.dart';
import 'package:lavona/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MainScreen.dart';


class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    /*if(auth.status == Status.Uninitialized){
      return ShowDataPage();
    }else{*/
      if(auth.loggedIn){
        return MainScreen();
      }else {
        return Login();
      }
    }
  }
//}
