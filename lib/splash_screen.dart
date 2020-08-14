import 'package:flutter/material.dart';
import 'dart:async';
import 'HomeScreen.dart';
import 'package:shimmer/shimmer.dart';
class splash_screen extends StatefulWidget {
  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  void initState(){
    super.initState();
    mockCheckForSession().then((status) => navigateToHome());
  }

  Future<bool> mockCheckForSession() async{
    await Future.delayed(Duration(milliseconds: 4000),(){});
    return true;
  }
  void navigateToHome(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (BuildContext context)=>ScreensController()
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            /*Opacity(
                opacity: 0.9,
                child: Image.asset('assets/image/logo.jpg')
            ),*/

            Shimmer.fromColors(
              period: Duration(milliseconds: 1000),
              baseColor: Color(0xff81d4fa),
              highlightColor: Color(0xff00838f),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Lavona",
                  style: TextStyle(
                      fontSize: 90.0,
                      fontFamily: 'Pacifico',
                      shadows: <Shadow>[
                        Shadow(
                            blurRadius: 18.0,
                            color: Colors.black87,
                            offset: Offset.fromDirection(120, 12)
                        )
                      ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
