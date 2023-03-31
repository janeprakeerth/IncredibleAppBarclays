import 'package:flutter/material.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:permission/permission.dart';
class directionsPoly extends StatefulWidget {
  const directionsPoly({Key? key}) : super(key: key);

  @override
  State<directionsPoly> createState() => _directionsPolyState();
}

class _directionsPolyState extends State<directionsPoly> {
  final Set<Polyline> polyline  = {};
  late GoogleMapController _controller;
  late List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
        new GoogleMapPolyline(apiKey: "AIzaSyAHZZ4kl39I6I9ZOz-DhpmoaJvzGh8FZZs");
  getsomePoints() async {
    print("ruunn");
    // var permission = await Permission.getPermissionsStatus([PermissionName.Location]);
    // if(permission[0].permissionStatus == PermissionStatus.notAgain){
    //   var askpermision =
    //       await Permission.requestPermissions([PermissionName.Location]);
    // }else {
      routeCoords = (await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(13.0826, 80.2707),
          destination: LatLng(13.000, 80.2972),
          mode: RouteMode.driving))!;
    //}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsomePoints();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(onMapCreated : onMapCreated,
          polylines: polyline,
          initialCameraPosition: CameraPosition(
        target:LatLng(13.0826,80.2707),zoom: 14.0
      ),
        mapType: MapType.normal,

      ),
    );
  }
  void onMapCreated(GoogleMapController controller){
    setState(() {
        _controller = controller;
        polyline.add(Polyline(polylineId: PolylineId('route1'),visible: true,
        points: routeCoords,width: 4,color: Colors.blue,startCap: Cap.roundCap,
        endCap: Cap.buttCap));
    });
  }
}
