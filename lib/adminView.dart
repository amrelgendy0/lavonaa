import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'models/Request.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
class adminView extends StatefulWidget {
  @override
  _adminViewState createState() => _adminViewState();
}

class _adminViewState extends State<adminView> {
  List<Request> allData = [];
  String country;
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    _loadSavedData();
    ref.child('request').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      print(data);
      allData.clear();
      for (var key in keys) {
        Request d = new Request(
          data[key]['name'],
          data[key]['job'],
          data[key]['message'],
          data[key]['country'],
          data[key]['phone'],
          data[key]['time'],
          data[key]['Latitude'],
          data[key]['Longitude'],
        );
        if(data[key]['country']==country){
          allData.add(d);}
      }

      setState(() {
        print('Length : ${allData.length}');
      });
    });

  }
  _loadSavedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      country = (sharedPreferences.getString('Country')??'');
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
                                allData[index].job,
                                allData[index].message,
                                allData[index].country,
                                allData[index].phone,
                                allData[index].formattedDate,
                                allData[index].latitude,
                                allData[index].longitude,
                              );
                            },
                          )
                      ))]
                ))
        )
    );
  }

  Widget UI(String name,String job,String message,String country,String phone,String formattedDate,String latitude,String longitude) {
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new RaisedButton(onPressed:(){launch('tel:+$phone');} ,
                      child: new Text('اتصل',style: Theme.of(context).textTheme.title.apply(color: Colors.white)),
                      color: Colors.blue,
                      padding: new EdgeInsets.all(10.0)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(onPressed:(){_launchMapsUrl(double.parse('$latitude'), double.parse('$longitude'));} ,
                      child: new Text('location',style: Theme.of(context).textTheme.title.apply(color: Colors.white)),
                      color: Colors.blue,
                      padding: new EdgeInsets.all(10.0)),
                ),
              ],
            ),
          ),
        ));
  }
  void _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
