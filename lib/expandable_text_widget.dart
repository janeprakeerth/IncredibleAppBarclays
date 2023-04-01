import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incredibleapp/ProductsDetails.dart';
import 'package:incredibleapp/small_text.dart';

import 'big_Text.dart';
import 'colors.dart';
import 'dimension.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final Map mapUserInfo;
  final int Index;
  const ExpandableTextWidget(
      {Key? key,
      required this.text,
      required this.mapUserInfo,
      required this.Index})
      : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;
  double TextHeight = Dimensions.screenheight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > TextHeight) {
      firstHalf = widget.text.substring(0, TextHeight.toInt());
      secondHalf =
          widget.text.substring(TextHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  List<Container> buildButtons(Map mapuserInfo, int Index, int start, int end) {
    List<Container> buttons = [];
    for (int i = start; i < end; i++) {
      var button = Container(
        margin: EdgeInsets.only(right: 10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductsDetails(
                  productCategory: mapuserInfo['possiblemerchants'][Index]
                      ['service_categories'][i],
                  merchantId: mapuserInfo['possiblemerchants'][Index]
                      ['merchant_id'],
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffE8553C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Text(
            "${mapuserInfo['possiblemerchants'][Index]['service_categories'][i]}",
            style: TextStyle(fontSize: 10),
          ),
        ),
      );
      buttons.add(button);
    }

    return buttons;
  }

  List<Text> buildTexts(Map mapuserInfo, int Index) {
    List<Text> texts = [];
    for (int i = 0;
        i < mapuserInfo['possiblemerchants'][Index]['Offers']['items'].length;
        i++) {
      var text = Text(
          "-> ${mapuserInfo['possiblemerchants'][Index]['Offers']['items'][i]['Offer_Category']}");
      texts.add(text);
    }
    return texts;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: buildButtons(widget.mapUserInfo, widget.Index, 0, 3),
          ),
          Row(
            children: buildButtons(widget.mapUserInfo, widget.Index, 3, 4),
          ),
          SizedBox(
            height: 15,
          ),
          BigText(
            text: "Offers",
            size: Dimensions.height26,
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: buildTexts(widget.mapUserInfo, widget.Index),
          )
        ],
      ),
    );
  }
}
