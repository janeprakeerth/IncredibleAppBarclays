import 'package:flutter/cupertino.dart';
import 'package:incredibleapp/small_text.dart';

import 'dimension.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: Dimensions.icon24,
          color: iconColor,
        ),
        SizedBox(
          width: Dimensions.width5,
        ),
        SmallText(
          text: text,
        )
      ],
    );
  }
}
