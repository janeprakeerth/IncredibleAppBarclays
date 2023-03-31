import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:incredibleapp/ShopDetails.dart';
import 'package:incredibleapp/small_text.dart';

import 'app_column.dart';
import 'big_Text.dart';
import 'colors.dart';
import 'dimension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? currentUserPosition;
  PageController pageController = PageController(viewportFraction: 0.85);
  double _currPageValue = 0.0;
  double scalefactor = 0.8;
  double height = 35;
  List<Container> container = [];
  var futures;
  Map? mapUserInfo;

  @override
  getCordinate() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(currentUserPosition?.latitude);
    print(currentUserPosition?.longitude);
    return getHomeDetails(
        currentUserPosition?.latitude, currentUserPosition?.longitude);
  }

  List<Container> getPages(Map? mapUserinfo) {
    List<dynamic> details = mapUserInfo?['possiblemerchants'];
    var container1 = Container(
      height: Dimensions.pageView,
      child: PageView.builder(
          controller: pageController,
          itemCount: details.length,
          itemBuilder: (context, position) {
            return _buildPageItem(position);
          }),
    );
    container.add(container1);
    return container;
  }

  getHomeDetails(double? latitude, double? longitude) async {
    if (latitude != Null && longitude != Null) {
      final url =
          "https://incredibleapp-production.up.railway.app/getRecentDeals?long=${longitude}&lat=${latitude}&distinKm=100&username=rb0585";
      print(url);
      var response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        mapUserInfo = json.decode(response.body);
        print("mapUserInfo  : $mapUserInfo");
      } else {
        print(response.statusCode);
      }
      return getPages(mapUserInfo);
    }
  }

  void initState() {
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    futures = getCordinate();
    print(mapUserInfo);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF1ED),
      appBar: AppBar(
        backgroundColor: Color(0xffE8553C),
        elevation: 0,
        title: Text(
          "        Incredible App",
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "         Shops Near You",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: futures,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  children: snapshot.data,
                );
              }
            },
          ),
          Text(
            "         Around You",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Center(
            child: Container(
              width: 320,
              height: 250,
              child: Image(
                image: NetworkImage(
                    "https://mologmedia.s3.ap-south-1.amazonaws.com/GoogleMapImage.png"),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPageItem(int Index) {
    Matrix4 matrix = new Matrix4.identity();
    if (Index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - Index) * (1 - scalefactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (Index == _currPageValue.floor() + 1) {
      // var currScale =
      //     scalefactor + (_currPageValue - Index + 1) * (1 - scalefactor);
      // var currTrans = height * (1 - currScale) / 2;
      // matrix = Matrix4.diagonal3Values(1, currScale, 1)
      //   ..setTranslationRaw(1, currTrans, 1);
    } else if (Index == _currPageValue.floor() - 1) {
      // var currScale = 1 - (_currPageValue - Index) * (1 - scalefactor);
      // var currTrans = height * (1 - currScale) / 2;
      // matrix = Matrix4.diagonal3Values(1, currScale, 1)
      //   ..setTranslationRaw(1, currTrans, 1);
    } else {
      // var currScale = 0.8;
      // var currTrans = height * (1 - currScale) / 2;
      // matrix = Matrix4.diagonal3Values(1, currScale, 1)
      //   ..setTranslationRaw(1, currTrans, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ShopDetails(mapUserInfo: mapUserInfo!, Index: Index),
                ),
              );
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.height10, right: Dimensions.height10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: Index.isEven
                    ? AppColors.mainColor
                    : AppColors.mainBlackColor,
                image: DecorationImage(
                    image: NetworkImage(
                        "${mapUserInfo?['possiblemerchants'][Index]['Img_url']}"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.height30,
                  right: Dimensions.height30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xffe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.height15,
                    right: Dimensions.height15),
                child: AppColumn(
                  text: mapUserInfo?['possiblemerchants'][Index]
                      ['merchant_name'],
                  rating: mapUserInfo?['possiblemerchants'][Index]
                      ['merchant_average_rating'],
                  total_ratings: mapUserInfo?['possiblemerchants'][Index]
                          ['merchant_ratings']
                      .length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
