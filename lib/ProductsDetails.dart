import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductsDetails extends StatefulWidget {
  final String productCategory;
  final String merchantId;
  const ProductsDetails(
      {Key? key, required this.productCategory, required this.merchantId})
      : super(key: key);

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  Map? mapUserInfo;
  var futures;
  List<Card> cards = [];
  @override
  getProductDetails() async {
    final url =
        "https://incredibleapp-production.up.railway.app/productsByStore?product_category=${widget.productCategory}&merchant_id=${widget.merchantId}";
    print(url);
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      mapUserInfo = json.decode(response.body);
      print("mapUserInfo  : $mapUserInfo");
    } else {
      print(response.statusCode);
    }
    return getCard(mapUserInfo);
  }

  List<Card> getCard(Map? mapuserinfo) {
    for (int i = 0; i < mapUserInfo?['products'].length; i++) {
      for (int j = 0;
          j < mapUserInfo?['products'][i]['product_catalogue'].length;
          j++) {
        var card = Card(
          margin: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          color: Color(0xffFFEBE8),
          elevation: 10,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: Image(
                        image: NetworkImage(
                            "https://cdn.thewirecutter.com/wp-content/media/2022/07/laptop-under-500-2048px-acer-1.jpg")),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Name : ${mapUserInfo?['products'][i]['product_catalogue'][j]['product_name']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                        Text(
                          "Brand : ${mapUserInfo?['products'][i]['product_catalogue'][j]['product_brand']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                        Text(
                          "Category : ${mapUserInfo?['products'][i]['product_catalogue'][j]['product_category']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        );
        cards.add(card);
      }
    }
    return cards;
  }

  @override
  void initState() {
    futures = getProductDetails();
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
              })
        ],
      ),
    );
  }
}
