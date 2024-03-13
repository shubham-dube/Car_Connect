import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:FixItParts/Cart_Model.dart';
import 'package:provider/provider.dart';
import 'package:FixItParts/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'successScreen.dart';

class PaymentScreen extends StatefulWidget {
  final int orderAmount;
  final orderDetails;
  const PaymentScreen({required this.orderAmount, required this.orderDetails});

  @override
  State<PaymentScreen> createState() => _PaymentScreen();
}

class _PaymentScreen extends State<PaymentScreen> {
  bool selected = false;
  String SelectedPaymentOption = '';

  void checkOut() async {
    showWaiting();
    final cartModel = await Provider.of<CartModel>(context, listen: false);
    var prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString('token');
    Map<String,dynamic> tokenData = JwtDecoder.decode(token!);
    final customerId = tokenData['mobile'];
    List<Map<String, dynamic>> productDetails = [];
    List<Map<String, dynamic>> serviceDetails = [];

    for (var product in cartModel.inCartProducts) {
      productDetails.add({
        'merchantId': product.merchantId,
        'productId': product.id,
        'title': product.title,
        'quantity': '1',
        'price': product.sellingPrice,
      });
    }

    for (var service in cartModel.inCartServices) {
      serviceDetails.add({
        'merchantId': service.merchantId,
        'serviceId': service.id,
        'title': service.title,
        'price': service.sellingPrice,
      });
    }

    Map<String, dynamic> orderBody = {
      'paymentMode': SelectedPaymentOption,
      'customerId': customerId,
      'productDetails': productDetails,
      'serviceDetails': serviceDetails,
      'orderAmount': widget.orderAmount,
      'deliveryAddress': 'Academic Block, IIIT Raichur, GEC Campus, Yermarus Camp, Raichur, Karnataka - 584135',
      'status': 'pending'
    };

    var jsonResponse = await http.post(
        Uri.parse(placeOrder),
        headers: {"content-Type": "application/json"},
        body: jsonEncode(orderBody)
    );
    var response = jsonDecode(jsonResponse.body);

    if(response['status']==true){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          SuccessScreen(
            billDetails: widget.orderDetails,
          )));
    }
  }

  Future<void> showWaiting() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            buttonPadding: EdgeInsets.all(8),
            backgroundColor: Colors.white,
            title: const Text('Placing your Order', style: TextStyle(fontSize: 15,),),
            content: SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator(color: Colors.black,)))
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(60, 70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange.shade100,Colors.blue.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
            )
          ),
          child: AppBar(
            title: Text('Payment Mode'),
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selected = !selected;
                      if(selected==true){
                        SelectedPaymentOption = 'Cash on Delivery';
                      }
                      else {
                        SelectedPaymentOption = '';
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: (selected) ? Colors.yellow.shade200 : Colors.white,
                    ),
                    width: MediaQuery.sizeOf(context).width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cash on Delivery", style: TextStyle(fontSize: 16),),
                        (selected) ?
                            Icon(Icons.check_circle,color: Colors.blue,) :
                            Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.orange.shade50,Colors.green.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Items total"),
                  Text('₹${widget.orderAmount}',
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(
              width: 210,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    checkOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Confirm", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
            )

          ],
        ),
      ),


    );
  }
}