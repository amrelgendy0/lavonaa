import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CountryView.dart';
import 'customReqView.dart';
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: new EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Image.asset('assets/image/logo.jpg'),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ShowDataPage()));},
                    child: new Text('طلب جديد',style: Theme.of(context).textTheme.title.apply(color: Colors.white)),
                  color: Colors.blue,
                  padding: new EdgeInsets.all(10.0),),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: new RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => customReqView()));},
                    child: new Text('الطلبات السابقة',style: Theme.of(context).textTheme.title.apply(color: Colors.white)),
                    color: Colors.blue,
                      padding: new EdgeInsets.all(10.0)),
                ),
              ],

            )
          ],

        ),
      ),
    );
  }
}
