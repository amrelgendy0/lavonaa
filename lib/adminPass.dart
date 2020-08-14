import 'package:flutter/material.dart';
import 'package:lavona/adminView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lavona/widgets/custom_button.dart';
import 'package:lavona/helpers/screen_navigation.dart';

class adminPass extends StatefulWidget {
  @override
  _adminPassState createState() => _adminPassState();
}

class _adminPassState extends State<adminPass> {
  String _selectedType="السعودية";
  SharedPreferences prefs;
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
  String pass;
  _saveCountry(String country) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("Country", _selectedType);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _saveCountry(_selectedType);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
            ),
          )
          ,),
        Container(
            child: Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  decoration: new InputDecoration(hintText: 'password'),
                  style: TextStyle(color: Colors.blue),
                  onChanged: (val) {
                    pass = val;
                  },
                  maxLength: 32,
                ),
              ),
            )
        ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            child:CustomButton(
            msg: "دخول",
              onTap: (){
              if(pass=="0000"){
                changeScreen(context,adminView());
              }
              },
          )
        ),
      )]
      )
    );
  }
}
