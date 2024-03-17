import 'package:FixItParts/Screens/Consumer/HomeScreen/HandleFile.dart';
import 'package:FixItParts/Screens/Consumer/HomeScreen/Home_Screen.dart';
import 'package:FixItParts/Screens/Consumer/MyOrdersScreen/My_Orders_Screen.dart';
import 'package:flutter/material.dart';
import 'package:FixItParts/Cart_Model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessScreen extends StatefulWidget {
  final billDetails;
  const SuccessScreen({required this.billDetails});

  @override
  State<SuccessScreen> createState() => _SuccessScreen();
}

class _SuccessScreen extends State<SuccessScreen> {
  int totalItems = 0;
  int totalPrice = 0;
  int totalDiscount = 0;
  int deliveryCharges = 0;
  int pickupCharges = 0;
  int orderAmount = 0;

  void initState() {
    super.initState();
    setState(() {
      totalItems = widget.billDetails[0].totalItems;
      totalPrice = widget.billDetails[0].totalPrice;
      totalDiscount = widget.billDetails[0].totalDiscount;
      deliveryCharges = widget.billDetails[0].deliveryCharges;
      pickupCharges = widget.billDetails[0].pickupCharges;
      orderAmount = widget.billDetails[0].orderAmount;
    });
  }

  @override
  Widget build(BuildContext context){
    final cartModel = Provider.of<CartModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Placed"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white24,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Icon(Icons.check_circle_outline_outlined, color: Colors.green, size: 70),
                Text("Order Placed Successfully",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                  ),
                ),
                SizedBox(height: 20,),
          
                ...cartModel.inCartProducts.map((item){
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid, color: Colors.green)
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
                                child: Image.network(item.imageUrl),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                SizedBox(height: 3,),
                                Text('Brand: ${item.brand}', style: TextStyle(fontSize: 12),),
                                Text('Model Number: ${item.model}', style: TextStyle(fontSize: 12),)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          
                ...cartModel.inCartServices.map((item){
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid, color: Colors.green)
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
                                child: Image.network(item.imageUrl),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                SizedBox(width: 3,),
                                Text('Sit back and relax, one dedicated service buddy will assigned to you', style: TextStyle(fontSize: 12),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0),
                  padding: EdgeInsets.only(
                    left: 19, right: 19, top: 6, bottom: 12,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                          colors: [Colors.blue.shade50,Colors.yellow.shade50],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                      )
                  ),
                  width: MediaQuery.sizeOf(context).width * 0.94,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("Bill Summary", style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.add,
                                color: Colors.deepOrange,),
                              SizedBox(width: 5,),
                              Text("Item Total (${5})",
                                style: TextStyle(fontSize: 14,
                                    color: Colors.grey.shade700),),
                            ],
                          ),
                          Text("₹${totalPrice}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.black87),),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.discount,
                                color: Colors.deepOrange,),
                              SizedBox(width: 5,),
                              Text("Discount",
                                style: TextStyle(fontSize: 14,
                                    color: Colors.grey.shade700),),
                            ],
                          ),
                          Text("-₹${totalDiscount}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.green),),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.delivery_dining,
                                color: Colors.deepOrange,),
                              SizedBox(width: 5,),
                              Text("Delivery Charges",
                                style: TextStyle(fontSize: 14,
                                    color: Colors.grey.shade700),),
                            ],
                          ),
                          Text("₹${deliveryCharges}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.green),),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.money,
                                color: Colors.deepOrange,),
                              SizedBox(width: 5,),
                              Text("Pickup Charges",
                                style: TextStyle(fontSize: 14,
                                    color: Colors.grey.shade700),),
                            ],
                          ),
                          Text("₹${pickupCharges}",
                            style: TextStyle(
                                fontSize: 14, color: Colors.black87),),
                        ],
                      ),
          
                      Container(height: 1,
                        color: Colors.grey.shade300,
                        margin: EdgeInsets.only(top: 5, bottom: 5),),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                color: Colors.deepOrange,),
                              SizedBox(width: 5,),
                              Text("Total Amount",
                                style: TextStyle(fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700),),
                            ],
                          ),
                          Text("₹${orderAmount}",
                            style: TextStyle(fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(
                            "You Will Save ₹${totalDiscount} on this order",
                            style: TextStyle(fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),),
                        ],
                      ),
          
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () async {
                      var prefs = await SharedPreferences.getInstance();
                      var token = prefs.getString('token');
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HandleFile()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Go to HomPage', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                ),
          
                SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrdersScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow.shade800,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('My Orders', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}