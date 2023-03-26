import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapWithPath extends StatefulWidget {
  final LatLng source;
  final LatLng destination;

  MapWithPath({required this.source, required this.destination});

  @override
  _MapWithPathState createState() => _MapWithPathState();
}

class _MapWithPathState extends State<MapWithPath> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId("source"),
      position: widget.source,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ));
    _markers.add(Marker(
      markerId: MarkerId("destination"),
      position: widget.destination,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ));
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> points = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "YOUR_API_KEY",
      PointLatLng(widget.source.latitude, widget.source.longitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        points.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId("route"),
        points: points,
        color: Colors.blue,
        width: 5,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map with Path"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: widget.source,
          zoom: 12,
        ),
        onMapCreated: _onMapCreated,
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
