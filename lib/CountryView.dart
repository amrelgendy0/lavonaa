import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lavona/Gmap.dart';
import 'models/Country.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Gmap.dart';

class ShowDataPage extends StatefulWidget {
  @override
  _ShowDataPageState createState() => _ShowDataPageState();
}

class _ShowDataPageState extends State<ShowDataPage> {
  String _selectedType="السعودية";
  SharedPreferences prefs;
  _saveJob(String job) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("job", job );
  }
  List<CountryListitem> allData = [];
  List<DropdownMenuItem<String>> items = [
    new DropdownMenuItem(
      child: new Text('السعودية'),
      value: 'السعودية',
    ),
    new DropdownMenuItem(
      child: new Text('الأمارات'),
      value: 'الأمارات',
    ),
    new DropdownMenuItem(
      child: new Text('السودان'),
      value: 'السودان',
    ),
  ];


  @override
  void initState() {
    super.initState();
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('jobs').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        CountryListitem d = new CountryListitem(
          data[key]['name'],
          data[key]['image']
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
    _saveCountry(_selectedType);
  }

 _saveCountry(String country) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("Country", _selectedType);
    });
  }
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
               Container(
                    child: Column(
                      children:<Widget>[
                       new Text("قم بأختيار الدولة",style:Theme.of(context).textTheme.title.apply(color: Colors.black87)  ),
                       new SizedBox(width: 20.0,height: 10.0,),
                        new DropdownButtonHideUnderline(
                            child: new DropdownButton<String>(
                              items: items,
                               hint: new Text('السعودية'),
                                value: _selectedType,
                                  onChanged: (String val) {
                                setState(() {
                                  _selectedType=val;
                                });
                                _saveCountry(_selectedType);
                                    },
                                   ))
        ]
          )
          ,),
              Container(child: Expanded(
                    child: allData.length == 0
                ? new Text(' Loading')
                : new ListView.builder(
              itemCount: allData.length,
              itemBuilder: (_, index) {
                return UI(
                    allData[index].Cname,
                    allData[index].Cimg
                );
              },
            )
        ))]
        ))
      )
    );
  }

  Widget UI(String Cname, String Cimg) {
    return GestureDetector(
        onTap: () {
          _saveJob(Cname);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Gmap()));
          },
        child: new Card(
      elevation: 10.0,
           child: new Container(
        padding: new EdgeInsets.all(20.0),
             child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
                  new Image.network('$Cimg'),
                new Text('$Cname',style: Theme.of(context).textTheme.title.apply(color: Colors.black87),
            )],
        ),
      ),
    ));
  }
}