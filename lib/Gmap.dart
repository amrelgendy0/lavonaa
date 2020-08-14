import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'Request.dart';

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  String lat,long;
  SharedPreferences prefs;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

 _saveLatitude(String latitude) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("Latitude", lat);
    });
  }
  _saveLongitude(String longitude) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString("Longitude", long);
    });
  }

  void getLocation() async {
    var location = new Location();
    try {
      await location.getLocation().then((onValue) {
        print(onValue.latitude.toString() + "," + onValue.longitude.toString());
        lat = onValue.latitude.toString();
        long = onValue.longitude.toString();
        setState(() {
          _saveLatitude(onValue.latitude.toString());
          _saveLongitude(onValue.longitude.toString());
          if(onValue.latitude.toString()!=null&&onValue.longitude.toString()!=null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Request()));}
        });
      });
    } catch (e) {
      print(e);
    }
  }
  void _current_location() async {
    final GoogleMapController controller = await _controller.future;
    var makerIdValue = "val";
    final MarkerId markerId = MarkerId(makerIdValue);
    LocationData location;
    var _location = new Location();
    try {
      location = await _location.getLocation();
    } catch (e) {
      print('ERROR' + e.toString());
      location = null;
    }
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 0,
        target: LatLng(location.latitude, location.longitude),
        zoom: 17.0
    )));

 }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _saveLatitude(lat);
      _saveLongitude(long);
    });

  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (LatLng latLng) {
          // you have latitude and longitude here
          lat = latLng.latitude.toString();
          long = latLng.longitude.toString();
          setState(() {
            _saveLatitude(lat);
            _saveLongitude(long);
          });
          if(_saveLatitude(lat)!=null&&_saveLongitude(long)!=null){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Request()));}


        },
        myLocationEnabled: true,
      ),
      floatingActionButton: _getFAB(),

    );

  }
  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Color(0xFF801E48),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.location_on),
            backgroundColor: Color(0xFF801E48),
            onTap: (){getLocation();
            },
            label: 'Current location',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color(0xFF801E48)),
        // FAB 2
         SpeedDialChild(
            child: Icon(Icons.location_on),
            backgroundColor: Color(0xFF801E48),
            onTap: () {
            _current_location();
            },
            label: 'Another location',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color(0xFF801E48))
      ],
    );
  }
}

