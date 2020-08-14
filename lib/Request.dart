import 'package:flutter/material.dart';
import 'CountryView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lavona/widgets/custom_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'MainScreen.dart';
class Request extends StatefulWidget {
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  BuildContext scaffoldContext;
  final ref = FirebaseDatabase.instance.reference();
  String name, message, country, job,phone;
  String latitude,longitude;
  static var now = new DateTime.now();
 static var dateformat = new DateFormat('yyyy-MMM-dd hh:mm:ss aa');
  String formattedDate = dateformat.format(now);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      country = (sharedPreferences.getString('Country')??'');
      job = (sharedPreferences.getString('job')??'');
      phone = (sharedPreferences.getString('phone')??'');
      latitude = (sharedPreferences.getString('Latitude')??'');
      longitude = (sharedPreferences.getString('Longitude')??'');

    });}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Image.asset('assets/image/logo.jpg'),
        ),
        new Row(
          children: <Widget>[
            new Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  decoration: new InputDecoration(hintText: 'Name'),
                   style: TextStyle(color: Colors.blue),
                  onChanged: (val) {
                    name = val;
                  },
                  maxLength: 32,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: new TextFormField(
            decoration: new InputDecoration(hintText: 'Message'),
            style: TextStyle(color: Colors.blue),
            onChanged: (val) {
              message = val;
            },
            maxLines: 5,
            maxLength: 100,
          ),
        ),
         Builder(
            builder: (context)=>new CustomButton(msg: "سجل", onTap: (){
              if(message!=null&&name!=null){
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(' تم '),duration:Duration(seconds: 5),
                )
                );
                _sendToServer();
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));}else{
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(' من فضلك تأكد من ادخال الأسم و المشكلة '),duration:Duration(seconds: 5),
                )
                );
              }
            }),
          ),
          new SizedBox(height: 20.0),
      ],
    ));
  }

  _sendToServer() {
    ref.child('request').push().set({
      "name": name,
      "message": message,
      "country": country,
      "job": job,
      "phone":phone,
      "time":formattedDate,
      "Latitude":latitude,
      "Longitude":longitude,
    });
  }


}