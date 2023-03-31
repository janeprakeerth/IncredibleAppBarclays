import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:label_marker/label_marker.dart';


class mapDart extends StatefulWidget {
  const mapDart({Key? key}) : super(key: key);

  @override
  State<mapDart> createState() => _mapDartState();
}

class _mapDartState extends State<mapDart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: latLng.LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        children: [
          TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']
          ),
          MarkerLayer(
            markers: [
              Marker(point: new LatLng(double.parse("62.003"),double.parse("23.555")), builder:
              (ctx) => Container(
                child: FlutterLogo(),
              ))
            ],
          ),
        ],
      )
      );

  }
}
