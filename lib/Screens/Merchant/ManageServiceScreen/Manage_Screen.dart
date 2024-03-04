import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';
import 'manageServicesWidget.dart';

class Service {
  final String id;
  final String serviceId;
  final String merchantId;
  final String imageUrl;
  final String title;
  final String duration;
  final String description;
  final String price;
  final String category;
  final int v;

  Service({
    required this.id,
    required this.serviceId,
    required this.merchantId,
    required this.imageUrl,
    required this.title,
    required this.duration,
    required this.description,
    required this.price,
    required this.category,
    required this.v,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      serviceId: json['serviceId'],
      merchantId: json['merchantId'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      duration: json['duration'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      v: json['__v'],
    );
  }
}

class ManageServices extends StatefulWidget {
  const ManageServices();

  @override
  State<ManageServices> createState() => _ManageServices();
}

class _ManageServices extends State<ManageServices> {
  var merchantId;
  List<Service> myList = [];

  void initState() {
    super.initState();
    getServices();
  }

  void getServices() async {
    var prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String,dynamic> tokenData = JwtDecoder.decode(token!);
    merchantId = tokenData['mobile'];

    var reqBody = {
      "merchantId": merchantId
    };

    var jsonresponse = await http.post(
        Uri.parse(getServiceReq),
        headers: {"content-Type": "application/json"},
        body: jsonEncode(reqBody)
    );

    myList = (jsonDecode(jsonresponse.body) as List<dynamic>).map((json) => Service.fromJson(json)).toList();

    print('Ab to thik lag raha hai - ${myList[0].title}');
    setState(() {});
  }

  Widget build(BuildContext context) {
    // print(Products[0].title);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text("Manage Services", style: TextStyle(fontSize: 20),),
        )),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          child: SelectableList1(
            myList: myList,
            // onDeleteSelected: ()=>{}
          ),
        ),
      ),
    );
  }
}