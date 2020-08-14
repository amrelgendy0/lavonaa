import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/CustomerReq.dart';

class customReqView extends StatefulWidget {
  @override
  _customReqViewState createState() => _customReqViewState();
}

// ignore: camel_case_types
class _customReqViewState extends State<customReqView> {
  List<CustomerReq> allData = [];
  String phone;
  
  @override
  void initState() {
    super.initState();
    _loadSavedData();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('request').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {

        CustomerReq d = new CustomerReq(
            data[key]['name'],
          data[key]['message'],
          data[key]['job'],
          data[key]['phone'],
          data[key]['country'],
          data[key]['time'],
        );
        if(data[key]['phone']==phone){
        allData.add(d);}
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }
  _loadSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   phone = (sharedPreferences.getString('phone')??'');
    setState(() {
      phone = (sharedPreferences.getString('phone')??'');
    });}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:new Scaffold(
            body:new Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(child: Expanded(
                          child: allData.length == 0
                              ? new Text(' Loading')
                              : new ListView.builder(
                            itemCount: allData.length,
                            itemBuilder: (_, index) {
                              return UI(
                                allData[index].name,
                                allData[index].message,
                                allData[index].country,
                                allData[index].phone,
                                allData[index].job,
                                allData[index].formattedDate,
                              );
                            },
                          )
                      ))]
                ))
        )
    );
  }

  Widget UI(String name,String message,String country,String phone,String formattedDate,String job) {
    return GestureDetector(
        onTap: () {
        },
        child: new Card(
          elevation: 10.0,
          child: new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text('$name',style: Theme.of(context).textTheme.title.apply(color: Colors.black87)),
                  new Text('$message',style: Theme.of(context).textTheme.title.apply(color: Colors.black87)),
                  new Text('$country',style: Theme.of(context).textTheme.title.apply(color: Colors.black87)),
                  new Text('$phone',style: Theme.of(context).textTheme.title.apply(color: Colors.black87)),
                  new Text('$job',style: Theme.of(context).textTheme.title.apply(color: Colors.black87)),
                  new Text('$formattedDate',style: Theme.of(context).textTheme.title.apply(color: Colors.black87)),
                ],
            ),
          ),
        ));
  }
}