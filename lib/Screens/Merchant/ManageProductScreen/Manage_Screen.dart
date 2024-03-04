import 'manageListingsWidget.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';

class Product {
  final String id;
  final String productId;
  final String merchantId;
  final String imageUrl;
  final String title;
  final String color;
  final String description;
  final String price;
  final String category;
  final int v;

  Product({
    required this.id,
    required this.productId,
    required this.merchantId,
    required this.imageUrl,
    required this.title,
    required this.color,
    required this.description,
    required this.price,
    required this.category,
    required this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      productId: json['productId'],
      merchantId: json['merchantId'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      color: json['color'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      v: json['__v'],
    );
  }
}

class ManageProducts extends StatefulWidget {
  const ManageProducts();

  @override
  State<ManageProducts> createState() => _ManageProducts();
}

class _ManageProducts extends State<ManageProducts> {
  var merchantId;
  List<Product> myList = [];

  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    var prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String,dynamic> tokenData = JwtDecoder.decode(token!);
    merchantId = tokenData['mobile'];

    var reqBody = {
      "merchantId": merchantId
    };

    var jsonresponse = await http.post(
        Uri.parse(getProd),
        headers: {"content-Type": "application/json"},
        body: jsonEncode(reqBody)
    );

    myList = (jsonDecode(jsonresponse.body) as List<dynamic>).map((json) => Product.fromJson(json)).toList();

    print('Ab to thik lag raha hai - ${myList[0].title}');
    setState(() {});
  }

  Widget build(BuildContext context) {
    // print(Products[0].title);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text("Manage Products", style: TextStyle(fontSize: 20),),
        )),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: SelectableList(
            myList: myList,
            // onDeleteSelected: ()=>{}
          ),
        ),
      ),
    );
  }
}