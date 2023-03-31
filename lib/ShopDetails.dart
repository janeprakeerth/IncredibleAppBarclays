import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_column.dart';
import 'app_icon.dart';
import 'big_Text.dart';
import 'colors.dart';
import 'dimension.dart';
import 'expandable_text_widget.dart';

class ShopDetails extends StatefulWidget {
  final Map mapUserInfo;
  final int Index;
  const ShopDetails({Key? key, required this.mapUserInfo, required this.Index})
      : super(key: key);
  @override
  State<ShopDetails> createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.height350,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "${widget.mapUserInfo?['possiblemerchants'][widget.Index]['Img_url']}"))),
              )),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.height20,
            right: Dimensions.height20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                  ),
                ),
                Text("")
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.height350 - Dimensions.height20,
            child: Container(
              padding: EdgeInsets.only(
                left: Dimensions.height20,
                right: Dimensions.height20,
                top: Dimensions.height20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppColumn(
                    text:
                        "${widget.mapUserInfo?['possiblemerchants'][widget.Index]['merchant_name']}",
                    rating: widget.mapUserInfo['possiblemerchants']
                        [widget.Index]['merchant_average_rating'],
                    total_ratings: widget
                        .mapUserInfo['possiblemerchants'][widget.Index]
                            ['merchant_ratings']
                        .length,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  BigText(
                    text: "Categories",
                    size: Dimensions.height26,
                  ),
                  SizedBox(
                    height: Dimensions.height20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text:
                            "gdibdjkidgsalorem35sdvbshkdvuidguiwqdgbisuuisvbguiscvuisjdgvsdvbaskdvbasvbsihcvaskcvbascjbaskcjakscjksvjkacvasjvcaskcviuscvusvsdvshdvhsdvshjdvsjhcvyfyuwfdywvdhvdjkdvwfvfhvfbkdwbfjiwdbfjiwdbjcbwksfb jkbfjfkewb djbdojsbdjoksbnjokbdjosbd ",
                        mapUserInfo: widget.mapUserInfo,
                        Index: widget.Index,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      // bottomNavigationBar: Container(
      //   height: Dimensions.height120,
      //   padding: EdgeInsets.only(
      //       top: Dimensions.height30,
      //       bottom: Dimensions.height30,
      //       left: Dimensions.height20,
      //       right: Dimensions.height20),
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.only(
      //           topRight: Radius.circular(Dimensions.height40),
      //           topLeft: Radius.circular(Dimensions.height40)),
      //       color: AppColors.buttonBackgroundColor),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         padding: EdgeInsets.only(
      //             top: Dimensions.height20,
      //             bottom: Dimensions.height20,
      //             left: Dimensions.height20,
      //             right: Dimensions.height20),
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(Dimensions.radius20),
      //             color: Colors.white),
      //         child: Row(
      //           children: [
      //             Icon(
      //               Icons.remove,
      //               color: AppColors.signColor,
      //             ),
      //             SizedBox(
      //               width: Dimensions.height10 / 2,
      //             ),
      //             BigText(text: "0"),
      //             SizedBox(
      //               width: Dimensions.height10 / 2,
      //             ),
      //             Icon(
      //               Icons.add,
      //               color: AppColors.signColor,
      //             )
      //           ],
      //         ),
      //       ),
      //       Container(
      //         padding: EdgeInsets.only(
      //             top: Dimensions.height20,
      //             bottom: Dimensions.height20,
      //             left: Dimensions.height20,
      //             right: Dimensions.height20),
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(Dimensions.height20),
      //             color: AppColors.mainColor),
      //         child: BigText(
      //           text: "\$ 10 add to cart",
      //           color: Colors.white,
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
