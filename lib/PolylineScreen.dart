import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  final Map mapUserInfo;
  const PolylineScreen({Key? key, required this.mapUserInfo}) : super(key: key);

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(13.0826, 80.2707), zoom: 14);

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> st = [];
    List<String> st1 = [];
    for (int i = 0; i < widget.mapUserInfo['possiblemerchants'].length; i++) {
      var x = LatLng(
          widget.mapUserInfo['possiblemerchants'][i]['location']['coordinates']
              [1],
          widget.mapUserInfo['possiblemerchants'][i]['location']['coordinates']
              [0]);
      var y =
          widget.mapUserInfo['possiblemerchants'][i]['merchant_average_rating'];
      var z = widget.mapUserInfo['possiblemerchants'][i]['merchant_name'];

      st1.add(y.toString());
      st.add(z.toString());
      latlng.add(x);
    }

    for (int i = 0; i < latlng.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latlng[i],
        infoWindow:
            InfoWindow(title: "${st[i]}", snippet: "${st1[i]} Star rating"),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(
        Polyline(polylineId: PolylineId('1'), points: latlng),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
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
