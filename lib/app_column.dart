import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incredibleapp/small_text.dart';
import 'big_Text.dart';
import 'colors.dart';
import 'dimension.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final int rating;
  final int total_ratings;
  const AppColumn(
      {Key? key,
      required this.text,
      required this.rating,
      required this.total_ratings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimensions.height26,
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  rating,
                  (index) => Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                      )),
            ),
            SmallText(
              text: "${rating}",
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(
              text: "${total_ratings}",
            ),
            SizedBox(
              width: Dimensions.width10,
            ),
            SmallText(
              text: "comments",
            ),
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: AppColors.iconColor1),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7km",
                iconColor: AppColors.mainColor),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: "32min",
                iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
