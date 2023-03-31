import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? currentUserPosition;

  @override
  getCordinate() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(currentUserPosition!.latitude);
    print(currentUserPosition!.longitude);
  }

  void initState() {
    getCordinate();
  }

  Widget build(BuildContext context) {
    return Container();
  }
}
