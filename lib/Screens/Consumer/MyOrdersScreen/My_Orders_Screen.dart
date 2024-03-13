import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:FixItParts/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderModel {
  final String paymentType;
  final String customerId;
  final List<ProductDetail> productDetails;
  final List<ServiceDetail> serviceDetails;
  final double orderAmount;
  final String deliveryAddress;
  final String status;

  OrderModel({
    required this.paymentType,
    required this.customerId,
    required this.productDetails,
    required this.serviceDetails,
    required this.orderAmount,
    required this.deliveryAddress,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      paymentType: json['paymentType'],
      customerId: json['customerId'],
      productDetails: (json['productDetails'] as List<dynamic>)
          .map((e) => ProductDetail.fromJson(e))
          .toList(),
      serviceDetails: (json['serviceDetails'] as List<dynamic>)
          .map((e) => ServiceDetail.fromJson(e))
          .toList(),
      orderAmount: json['orderAmount'].toDouble(),
      deliveryAddress: json['deliveryAddress'],
      status: json['status'],
    );
  }
}

class ProductDetail {
  final String merchantId;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  ProductDetail({
    required this.merchantId,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      merchantId: json['merchantId'],
      productId: json['productId'],
      title: json['title'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }
}

class ServiceDetail {
  final String merchantId;
  final String serviceId;
  final String title;
  final double price;

  ServiceDetail({
    required this.merchantId,
    required this.serviceId,
    required this.title,
    required this.price,
  });

  factory ServiceDetail.fromJson(Map<String, dynamic> json) {
    return ServiceDetail(
      merchantId: json['merchantId'],
      serviceId: json['serviceId'],
      title: json['title'],
      price: json['price'].toDouble(),
    );
  }
}

class MyOrdersScreen extends StatelessWidget {

  Future<List<OrderModel>> fetchOrders() async {
    await Future.delayed(Duration(seconds: 2));

    var prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String,dynamic> tokenData = JwtDecoder.decode(token!);
    var customerId = tokenData['mobile'];
    var reqBody = {
      "customerId": customerId
    };
    final jsonResponse = await http.post(
      Uri.parse(getOrders),
      headers: {"content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );

    final jsonOrders = jsonDecode(jsonResponse.body) as List<dynamic>;

    return jsonOrders.map((e) => OrderModel.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey.shade200,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final order = snapshot.data![index];
                  return Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Products Ordered"),
                        ...order.productDetails.map((product){
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(style: BorderStyle.solid, color: Colors.green)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                SizedBox(height: 3,),
                                Text('Quantity: ${product.quantity}', style: TextStyle(fontSize: 12),),
                                Text('Price: ${product.price}', style: TextStyle(fontSize: 12),)
                              ],
                            ),
                          );
                        }),
                        if(order.serviceDetails.length != 0)
                        Text("Services Booked"),
                        ...order.serviceDetails.map((service){
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(style: BorderStyle.solid, color: Colors.green)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(service.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                SizedBox(height: 3,),
                                Text('Price: ${service.price}', style: TextStyle(fontSize: 12),)
                              ],
                            ),
                          );
                        }),

                        Text("Order Status : ${order.status}"),
                        Text("Order Value : ${order.orderAmount}")

                      ],
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          // By default, show a loading spinner
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}