import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:palmer/Screens/HomeScreen.dart';
import 'package:palmer/Screens/Login&Signup.dart';

class mapGoogle extends StatefulWidget {
  const mapGoogle({super.key});

  @override
  State<mapGoogle> createState() => _mapGoogleState();
}

class _mapGoogleState extends State<mapGoogle> {
  String stadress = "";
  String address = "";
  Completer<GoogleMapController> _completer = Completer();
  static final CameraPosition _kGoogleplex =
      CameraPosition(target: LatLng(24.879873, 67.139695), zoom: 15.5423);
  Future _location() async {
    List<Location> locations =
        await locationFromAddress("Gronausestraat 710, Enschede");
    List<Placemark> placemarks =
        await placemarkFromCoordinates(52.2165157, 6.9437819);
    setState(() {
      stadress = locations.last.longitude.toString() +
          "" +
          locations.last.latitude.toString();
      address = placemarks.last.name.toString();
    });
    print(stadress);
  }

  List<Marker> _marker = [];
  List<LatLng> latlan = [
    LatLng(24.879873, 67.139695),
    LatLng(24.901240, 67.116426),
  ];
  final Set<Polyline> _polylines = {};
  
  List<Marker> _list = [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(24.879873, 67.139695),
        infoWindow: InfoWindow(title: 'Current Location')),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(24.8598, 67.0700),
        infoWindow: InfoWindow(title: 'Current Location')),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(24.901240, 67.116426),
        infoWindow: InfoWindow(title: 'Destination')),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print(error);
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final BackArrow = IconButton(
        color: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHome()));
        },
        icon: Icon(Icons.arrow_back));
    return Scaffold(
      appBar: AppBar(leading: BackArrow),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGoogleplex,
          markers: Set<Marker>.of(_marker),
          mapType: MapType.normal,
          myLocationEnabled: true,
          polylines: _polylines,
          onMapCreated: (GoogleMapController controller) {
            _completer.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        getUserCurrentLocation().then((value) async {
          print(value.latitude.toString() + "" + value.longitude.toString());
          _marker.add(Marker(
              markerId: MarkerId('3'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: InfoWindow(title: 'My Location')));
          CameraPosition cameraPosition =
              CameraPosition(target: LatLng(24.8598, 67.0700), zoom: 20);

          final GoogleMapController mapController = await _completer.future;
          mapController
              .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {});
        });
      }),
    );
  }
}
