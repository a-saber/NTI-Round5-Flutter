import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TestLocationView extends StatefulWidget {
  const TestLocationView({super.key});

  @override
  State<TestLocationView> createState() => _TestLocationViewState();
}

class _TestLocationViewState extends State<TestLocationView> {

  Set<Marker> markers = {};
  Set<Polyline> polylines = {
    Polyline(
      polylineId: PolylineId('1'),
      points: [
        LatLng(30.04855406300429, 31.22707262635231),
        LatLng(29.989687563027285 , 31.229701191186905),
      ]
    )
  };
  late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        polylines: polylines,
        onMapCreated: (controller){
          mapController = controller;
        },
        markers: markers,
        initialCameraPosition: CameraPosition(
          target: LatLng(30.04855406300429, 31.22707262635231),
          zoom: 12
        ),
        onTap: (LatLng latLng){
          print('Lat ${latLng.latitude} Long ${latLng.longitude}');
         setState(() {
           markers.add(Marker(
               markerId: MarkerId('onTap marker'),
               position: latLng
           ));
           mapController.animateCamera(
               CameraUpdate.newLatLng(latLng),
             duration: const Duration(seconds: 1)
           );
         });
        },
      ),
    );
  }
}
