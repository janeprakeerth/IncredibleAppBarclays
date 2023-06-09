import 'package:flutter/cupertino.dart';

import 'dimension.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final double height;
  const SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 0,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontSize: size == 0 ? Dimensions.font12 : size,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          height: height),
    );
  }
}
