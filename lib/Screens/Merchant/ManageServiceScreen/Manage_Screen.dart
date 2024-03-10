import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';

class Service {
  final String id;
  final int v;
  final String merchantId;
  final String title;
  final String imageUrl;
  final String status;
  final String category;
  final String skuId;
  final int mrp;
  final String sellingPrice;
  final String duration;
  final String confirmTime;
  var pickupCharges;
  final String pickupFlag;
  final String freePickup;
  final String hsn;
  var inclusions;
  var additionalInclusions;
  var kilometerWarranty;
  var timeWarranty;
  var compatibility;

  Service({
    required this.id,
    required this.v,
    required this.merchantId,
    required this.title,
    required this.imageUrl,
    required this.status,
    required this.category,
    required this.skuId,
    required this.mrp,
    required this.sellingPrice,
    required this.duration,
    required this.confirmTime,
    required this.pickupCharges,
    required this.pickupFlag,
    required this.freePickup,
    required this.hsn,
    required this.inclusions,
    required this.additionalInclusions,
    required this.kilometerWarranty,
    required this.timeWarranty,
    required this.compatibility,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    // Update this based on actual data types in the JSON
    return Service(
      id: json['_id'],
      v: json['__v'],
      merchantId: json['merchantId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      status: json['status'],
      category: json['category'],
      skuId: json['skuId'],
      mrp: json['mrp'],
      sellingPrice: json['sellingPrice'],
      duration: json['duration'],
      confirmTime: json['confirmTime'],
      pickupCharges: json['pickupCharges'],
      pickupFlag: json['pickupFlag'],
      freePickup: json['freePickup'],
      hsn: json['hsn'],
      inclusions: json['inclusions'],
      additionalInclusions: json['additionalInclusions'],
      kilometerWarranty: json['kilometerWarranty'],
      timeWarranty: json['timeWarranty'],
      compatibility: json['compatibility'],
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
  List<Service> allServices = [];
  List<Service> filteredServices = [];
  String searchQuery = '';
  String displayNone = '';

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

    allServices = (jsonDecode(jsonresponse.body) as List<dynamic>).map((json) => Service.fromJson(json)).toList();
    filteredServices = allServices;
    print('Ab to thik lag raha hai - ${allServices[0].title}');
    setState(() {});
  }

  Widget build(BuildContext context) {
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
        color: Colors.grey.shade200,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 5,),
                  Expanded(
                    child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.toLowerCase();
                            filteredServices = allServices.where((Service service) =>
                                service.title.toLowerCase().contains(searchQuery)
                            ).toList();
                            if (filteredServices.isEmpty) {
                              displayNone = "No Services found matching your search";
                            }
                            else {
                              displayNone = "";
                            }
                          });
                        },
                        style: TextStyle(fontSize: 16),
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          floatingLabelStyle: TextStyle(color: Colors.black),
                          labelText: "Search Service in your Catalogue",
                          labelStyle: TextStyle(fontSize: 13),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black,width: 1),
                          ),
                          focusColor: Colors.black,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        )
                    ),
                  ),
                ],
              ),

              Text(displayNone, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              Expanded(
                child: ListView.builder(
                    itemCount: filteredServices.length,
                    itemBuilder: (context, index){
                      final service = filteredServices[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(service.imageUrl),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(service.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      Text('${service.status}', style: TextStyle(fontSize: 12),),
                                      SizedBox(height: 5,),
                                      Text('Duration: ${service.duration}', style: TextStyle(fontSize: 12),),
                                      Text('Category: ${service.category}', style: TextStyle(fontSize: 12),),
                                      Text('Listed Price: ₹${service.sellingPrice}', style: TextStyle(fontSize: 12),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}