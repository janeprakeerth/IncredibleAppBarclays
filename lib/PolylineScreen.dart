import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex  = CameraPosition(target: LatLng(
    13.0826,80.2707),zoom: 14);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    LatLng(
        13.0826,80.2707),
    LatLng(
        13.10000,80.2207)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i  = 0 ; i  < latlng.length ; i ++){
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latlng[i],
          infoWindow: InfoWindow(
            title: "Really bad place",
            snippet: "0 Star rating"
          ),
          icon: BitmapDescriptor.defaultMarker,
        )
      );
      setState(() {

      });
      _polyline.add(
        Polyline(polylineId : PolylineId('1'),
            points: latlng
        ),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        //polylines: _polyline,
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
      ),
    );
  }
}
