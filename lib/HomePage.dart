import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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

  @override
  getCordinate() async {
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    currentUserPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(currentUserPosition?.latitude);
    print(currentUserPosition?.longitude);
  }

  void initState() {
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    getCordinate();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: 5,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position);
                      }),
                ),
              ],
            ),
          ))
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
      var currScale =
          scalefactor + (_currPageValue - Index + 1) * (1 - scalefactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    } else if (Index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - Index) * (1 - scalefactor);
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    } else {
      var currScale = 0.8;
      var currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, currTrans, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(
                left: Dimensions.height10, right: Dimensions.height10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius30),
              color:
                  Index.isEven ? AppColors.mainColor : AppColors.mainBlackColor,
              image: DecorationImage(
                  image: AssetImage("assets/image/food1.jpg"),
                  fit: BoxFit.cover),
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
                  text: "Vegetables",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
