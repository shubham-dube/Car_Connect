import 'package:FixItParts/Screens/Consumer/OneServiceScreen/One_Service_Screen.dart';
import 'package:flutter/material.dart';
import 'package:FixItParts/Cart_Model.dart';
import 'package:provider/provider.dart';
import '../OneProductScreen/One_Product_Screen.dart';
import '../PaymentScreen/Payment_Screen.dart';

class CartScreen extends StatefulWidget {
  final allServices;
  final allProducts;
  const CartScreen({required this.allProducts, required this.allServices});

  @override
  State<CartScreen> createState() => _CartScreen();
}

class _CartScreen extends State<CartScreen> {
  int totalDiscount = 0;
  int totalItems = 0;
  int totalPrice = 0;
  int deliveryCharges = 0;
  int pickupCharges = 0;
  int finalAmount = 0;
  int flag = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.deepOrange.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
          child: AppBar(
            iconTheme: IconThemeData(
                color: Colors.white
            ),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
            backgroundColor: Colors.transparent,
            title: Text('My Cart'),
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                padding: EdgeInsets.only(left: 19,right: 19,top: 6,bottom: 12,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                width: MediaQuery.sizeOf(context).width*0.94,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Address:", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.deepOrange,),
                        SizedBox(width: 5,),
                        Expanded(child:
                        Text("${'Shubham Dubey, '}Yermarus Camp, GEC Campus, Near SLN Road, Raichur, Karnataka, 584135",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.orange.shade700),)
                        ),
                        SizedBox(width: 15,),
                        SizedBox(
                          height: 30,
                          width: 100,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue,
                              textStyle: TextStyle(fontWeight: FontWeight.w400),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.grey.shade200
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              minimumSize: Size(80.0, 40.0),
                            ),
                            child: Text('Change'),
                            onPressed: () {
                              // Add your onPressed function here
                            },
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),

              Consumer<CartModel>(
                builder: (context, cartModel, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartModel.inCartProducts.length,
                    itemBuilder: (context, index) {
                      final product = cartModel.inCartProducts[index];
                      if(flag==0){
                        totalItems++;
                        totalDiscount += int.parse(product.mrp) - int.parse(product.sellingPrice);
                        totalPrice += int.parse(product.mrp);
                      }
                      double percentageDiff = ((double.parse(product.mrp) - double.parse(product.sellingPrice)) / double.parse(product.mrp)) * 100;
                      int percentageDifference = percentageDiff.toInt();
                      int nowQty = 1;
                      return Container(
                        margin: EdgeInsets.only(bottom: 15, right: 15,left: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16,left: 16,top: 18,bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image: NetworkImage(product.imageUrl),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                  ),
                                  ),

                                  SizedBox(height: 10,),
                                  Container(
                                    height: 39,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade100,
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                            onPressed: (){
                                              setState(() {
                                                nowQty--;
                                              });
                                            },
                                            icon: Icon(Icons.remove)),
                                        Text('${nowQty}'),
                                        IconButton(
                                            onPressed: (){
                                              setState(() {
                                                nowQty++;
                                              });
                                            },
                                            icon: Icon(Icons.add)),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left:0),
                                    child: SizedBox(
                                      height: 40,
                                      width: 105,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                          onPressed: (){
                                            setState(() {
                                              final cartModel = Provider.of<CartModel>(context, listen: false);
                                              cartModel.removeItem(product,'Product');
                                              totalItems--;
                                              totalPrice -= int.parse(product.sellingPrice);
                                              totalDiscount -= int.parse(product.mrp) - int.parse(product.sellingPrice);
                                            });
                                          },
                                          child: Text("Remove")
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              SizedBox(width: 10,),

                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                            ProductScreen(product: product, allProducts: widget.allProducts,
                                                allServices: widget.allServices))
                                        );
                                      },
                                        child: Text(product.title, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    SizedBox(height: 4,),
                                    Text('${product.color}, ${product.compatibility}', style: TextStyle(fontSize: 12),),
                                    SizedBox(height: 4,),

                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                          width: 100,
                                          child: Chip(
                                            label: Text('Big Saving Deal'),
                                            backgroundColor: Colors.green,
                                            labelStyle: TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.bold ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                            side: BorderSide.none,
                                            labelPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                        SizedBox(width: 6,),
                                        Container(
                                            padding: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              color: Colors.purple.shade50,
                                            ),
                                            child: Text("Product", style: TextStyle(color: Colors.purple,
                                                fontWeight: FontWeight.bold, fontSize: 12),)
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '₹${product.mrp}',
                                              style: TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                color: Colors.grey,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' ₹${product.sellingPrice}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Text('${percentageDifference}% OFF',
                                      style: TextStyle(color: Colors.green,fontSize: 13),
                                    ),

                                    Container(height: 1,color: Colors.black12,margin: EdgeInsets.only(top: 10, bottom: 12),),
                                    Row(
                                      children: [
                                        Icon(Icons.car_repair, color: Colors.grey.shade700,size: 25,),
                                        SizedBox(width: 7,),
                                        // (widget.product.freePickup == 'Yes') ?
                                        RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: 'Delivery by Tomorrow \n',
                                                style: TextStyle(color: Colors.black87, fontSize: 12.0),
                                              ),
                                              TextSpan(
                                                text: '₹99',
                                                style: TextStyle(color: Colors.grey, fontSize: 12.0,decoration: TextDecoration.lineThrough,),
                                              ),
                                              TextSpan(
                                                text: '  FREE ',
                                                style: TextStyle(color: Colors.green, fontSize: 13.0, fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text: 'Delivery',
                                                style: TextStyle(color: Colors.green, fontSize: 13.0),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    }
                  );
                },
              ),


              Consumer<CartModel>(
                builder: (context, cartModel, child) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartModel.inCartServices.length,
                      itemBuilder: (context, index) {
                        final service = cartModel.inCartServices[index];
                        if(flag ==0){
                          totalItems++;
                          totalDiscount += service.mrp - int.parse(service.sellingPrice);
                          if(service.pickupCharges != null || service.pickupCharges != '')
                            pickupCharges += int.parse(service.pickupCharges);
                          totalPrice += service.mrp;
                          if(index == cartModel.inCartServices.length - 1) flag  = 1;
                        }
                        double percentageDiff = ((service.mrp - double.parse(service.sellingPrice)) / service.mrp) * 100;
                        int percentageDifference = percentageDiff.toInt();
                        return Container(
                          margin: EdgeInsets.only(bottom: 15, right: 15,left: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16,left: 16,top: 18,bottom: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.shade300),
                                            borderRadius: BorderRadius.circular(12),
                                            image: DecorationImage(
                                                image: NetworkImage(service.imageUrl),
                                                fit: BoxFit.contain
                                            )
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 40,),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 10, left:0),
                                      child: SizedBox(
                                        height: 40,
                                        width: 105,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                            onPressed: (){
                                              setState(() {
                                                final cartModel = Provider.of<CartModel>(context, listen: false);
                                                cartModel.removeItem(service,'Service');
                                                totalItems--;
                                                totalPrice -= int.parse(service.sellingPrice);
                                                if(service.pickupCharges != null || service.pickupCharges != '')
                                                pickupCharges -= int.parse(service.pickupCharges);
                                                totalDiscount -= service.mrp - int.parse(service.sellingPrice);
                                              });
                                            },
                                            child: Text("Remove")
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                                SizedBox(width: 10,),

                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                                ServiceScreen(Service: service, allProducts: widget.allProducts,
                                                    allServices: widget.allServices))
                                            );
                                          },
                                          child: Text(service.title, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                      SizedBox(height: 4,),
                                      Text('• Takes ${service.duration} ', style: TextStyle(fontSize: 12),),
                                      SizedBox(height: 4,),

                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 30,
                                            width: 100,
                                            child: Chip(
                                              label: Text('Big Saving Deal'),
                                              backgroundColor: Colors.green,
                                              labelStyle: TextStyle(color: Colors.white,fontSize: 12, fontWeight: FontWeight.bold ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(2),
                                              ),
                                              side: BorderSide.none,
                                              labelPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                          SizedBox(width: 6,),
                                          Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Colors.purple.shade50,
                                              ),
                                              child: Text("Service", style: TextStyle(color: Colors.purple,
                                                  fontWeight: FontWeight.bold, fontSize: 12),)
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '₹${service.mrp}',
                                                style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ₹${service.sellingPrice}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      Text('${percentageDifference}% OFF',
                                        style: TextStyle(color: Colors.green,fontSize: 13),
                                      ),

                                      Container(height: 1,color: Colors.black12,margin: EdgeInsets.only(top: 10, bottom: 12),),
                                      Row(
                                        children: [
                                          Icon(Icons.timer, color: Colors.grey.shade700,size: 25,),
                                          SizedBox(width: 7,),

                                          Expanded(child: TextButton(onPressed: (){},
                                              child: Text("Click Here to choose time of appointment or pick-up"))),

                                        ],
                                      ),

                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
              ),

              FutureBuilder(
                future: Future.wait([
                    Future.delayed(Duration(seconds: 1))
                ]),
                builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                  } else {
                    return Container(
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
                                  Text("Item Total (${totalItems})",
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
                              Text("₹${0}",
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
                              Text("₹${totalPrice-totalDiscount+deliveryCharges+pickupCharges}",
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
                    );
                  }
                }
              ),

              SizedBox(height: 10,)

            ],
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
                  FutureBuilder(
                      future: Future.wait([
                      Future.delayed(Duration(seconds: 1))
                      ]),
                      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(strokeWidth: 1,);
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text('₹${totalPrice - totalDiscount +
                              deliveryCharges + pickupCharges}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),);
                        }
                      }
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 260,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: ElevatedButton(
                  onPressed: () {
                    var billDetails = [
                      bill(totalDiscount: totalDiscount, deliveryCharges: deliveryCharges,
                      pickupCharges: pickupCharges, totalPrice: totalPrice,
                      orderAmount: (totalPrice - totalDiscount + deliveryCharges + pickupCharges), totalItems: totalItems)
                      ];
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentScreen(
                      orderAmount: (totalPrice - totalDiscount + deliveryCharges + pickupCharges),
                          orderDetails: billDetails),));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Place Order", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}

class bill {
  int totalItems = 0;
  int totalPrice = 0;
  int totalDiscount = 0;
  int deliveryCharges = 0;
  int pickupCharges = 0;
  int orderAmount = 0;
  bill({required this.totalDiscount, required this.deliveryCharges, required this.pickupCharges,
  required this.totalPrice, required this.orderAmount, required this.totalItems});
}