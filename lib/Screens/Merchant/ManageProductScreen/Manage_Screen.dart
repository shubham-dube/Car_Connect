import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';

class Product {
  var id;
  var merchantId;
  var imageUrl;
  var title;
  var color;
  var brand;
  var skuId;
  var category;
  var mrp;
  var sellingPrice;
  var stock;
  var length;
  var breadth;
  var height;
  var weight;
  var hsn;
  var manufacturer;
  var packer;
  var importer;
  var status;
  var countryOfOrigin;
  var model;
  var warranty;
  var compatibility;
  final int v;

  Product({
    required this.id,
    required this.merchantId,
    required this.imageUrl,
    required this.title,
    required this.color,
    required this.brand,
    required this.skuId,
    required this.category,
    required this.mrp,
    required this.sellingPrice,
    required this.stock,
    required this.length,
    required this.breadth,
    required this.height,
    required this.weight,
    required this.hsn,
    required this.manufacturer,
    required this.packer,
    required this.importer,
    required this.status,
    required this.countryOfOrigin,
    required this.model,
    required this.warranty,
    required this.compatibility,
    required this.v,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      merchantId: json['merchantId'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      color: json['color'],
      brand: json['brand'],
      skuId: json['skuId'],
      category: json['category'],
      mrp: json['mrp'],
      sellingPrice: json['sellingPrice'],
      stock: json['stock'],
      length: json['length'],
      breadth: json['breadth'],
      height: json['height'],
      weight: json['weight'],
      hsn: json['hsn'],
      manufacturer: json['manufacturer'],
      packer: json['packer'],
      importer: json['importer'],
      status: json['status'],
      countryOfOrigin: json['countryOfOrigin'],
      model: json['model'],
      warranty: json['warranty'],
      compatibility: json['compatibility'],
      v: json['__v']
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
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  String searchQuery = '';
  String displayNone = '';

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

    allProducts = (jsonDecode(jsonresponse.body) as List<dynamic>).map((json) => Product.fromJson(json)).toList();
    filteredProducts = allProducts;
    print('Ab to thik lag raha hai - ${allProducts[0].title}');
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
                            filteredProducts = allProducts.where((Product product) =>
                                product.title.toLowerCase().contains(searchQuery)
                            ).toList();
                            if (filteredProducts.isEmpty) {
                              displayNone = "Product Not Found";
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
                          labelText: "Search Product in your Catalogue",
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
                  itemCount: filteredProducts.length,
                    itemBuilder: (context, index){
                      final product = filteredProducts[index];
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
                                      child: Image.network(product.imageUrl),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(product.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 5,),
                                      (product.color=='' || product.color == null) ?
                                      SizedBox(width: 1,) :
                                      Text('${product.color}', style: TextStyle(fontSize: 12),),
                                      SizedBox(height: 5,),
                                      Text('Brand: ${product.brand}', style: TextStyle(fontSize: 12),),
                                      Text('Category: ${product.category}', style: TextStyle(fontSize: 12),),
                                      Text('Model Number: ${product.model}', style: TextStyle(fontSize: 12),)
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