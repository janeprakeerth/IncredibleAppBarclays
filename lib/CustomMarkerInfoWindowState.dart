import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class CustomMarkerInfoWindowSate extends StatefulWidget {
  const CustomMarkerInfoWindowSate({Key? key}) : super(key: key);

  @override
  State<CustomMarkerInfoWindowSate> createState() => _CustomMarkerInfoWindowSateState();
}

class _CustomMarkerInfoWindowSateState extends State<CustomMarkerInfoWindowSate> {

  CustomInfoWindowController _customInfoWindowController = CustomInfoWindowController();
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latlng = [
    LatLng(33.6941 , 72.9734) ,LatLng(33.7008 , 72.9682),LatLng(33.6992 , 72.9744),
    LatLng(33.6939 , 72.9771),LatLng(33.6910 , 72.9807),LatLng(33.7036 , 72.9785)
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  loadData(){
      for(int i = 0 ;i  < _latlng.length ; i ++){
    _markers.add(Marker(markerId: MarkerId(i.toString()),icon :BitmapDescriptor.defaultMarker));}
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marker Window"),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
            GoogleMap(initialCameraPosition: CameraPosition(
              target: LatLng(33.6941,72.9734),

            ),
              markers: Set<Marker>.of(_markers),
              onTap: (position){

              },
            onMapCreated: (GoogleMapController controller){
              _customInfoWindowController.googleMapController = controller;
            },

            ),
          CustomInfoWindow(controller: _customInfoWindowController
          ,height: 200,
            width: 300,
            offset: 35,
          )
        ],
      ),
    );
  }
}
