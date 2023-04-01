// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/flutter_map.dart' as Polyline;
// import 'package:latlong2/latlong.dart' as LatLng;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class FlutterMap1 extends StatefulWidget {
//   const FlutterMap1({Key? key}) : super(key: key);
//
//   @override
//   State<FlutterMap1> createState() => _FlutterMap1State();
// }
//
// class _FlutterMap1State extends State<FlutterMap1> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: FlutterMap(
//       options: MapOptions(
//         center: LatLng.LatLng(51.0, 0.0),
//         zoom: 13.0,
//       ),
//       layers: [
//         TileLayerOptions(
//           urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//           subdomains: ['a', 'b', 'c'],
//         ),
//       ],
//     ));
//   }
// }
