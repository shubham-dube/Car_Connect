import 'package:flutter/material.dart';
import 'package:FixItParts/Screens/Merchant/ManageServiceScreen/Manage_Screen.dart';
import '../SearchScreen/Search_Screen.dart';
import 'package:FixItParts/Cart_Model.dart';
import 'package:provider/provider.dart';
import '../CartScreen/Cart_Screen.dart';

class ServiceScreen extends StatefulWidget {
  final Service;
  final allProducts;
  final allServices;
  const ServiceScreen({required this.Service, required this.allProducts, required this.allServices});

  @override
  State<ServiceScreen> createState() => _ServiceScreen();
}

class _ServiceScreen extends State<ServiceScreen> {

  @override
  Widget build(BuildContext context) {
    double percentageDiff = ((widget.Service.mrp - double.parse(widget.Service.sellingPrice)) / widget.Service.mrp) * 100;
    int percentageDifference = percentageDiff.toInt();
    List<String> inclusions = widget.Service.inclusions.split(',');
    List<String> additionalInclusions = widget.Service.additionalInclusions.split(',');
    final List<int> count = [1,2,3,4];
    final List<String> steps = [
      'A Dedicated Service Buddy will arrange a doorstep pick-up from your location (if chosen)',
      'Your Car will be serviced at the store which added this listing',
      'if you chosen self going to the store, then you are given a time slot as per your convinience',
      'We will doorstep deliver your Car in the specified service time (if chosen)'
    ];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade300, Colors.deepOrange.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            titleTextStyle: TextStyle(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white),
            title: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search Services & Products',
                        border: InputBorder.none,
                        filled: true,
                        contentPadding: EdgeInsets.all(8.0),
                        fillColor: Colors.grey[200],
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            SearchScreen(searchQuery: '', allProducts: widget.allProducts, allServices:widget.allServices))
                        );
                      },
                    ),
                  ),
                ),
                Consumer<CartModel>(
                  builder: (context, cartModel, child) {
                    return Stack(
                      children: [
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(
                              allServices:widget.allServices,allProducts: widget.allProducts,
                            )));
                          },
                        ),
                        if (cartModel.itemCount > 0)
                          Positioned(
                            right: 6,
                            top: 5,
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: Colors.red,
                              child: Text(
                                cartModel.itemCount.toString(),
                                style: TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
                      ],
                    );

                  },
                ),
              ],
            ),

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

              Stack(
                children: [
                    Container(
                      height: 260,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.Service.imageUrl),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  Positioned(
                      top: 12,
                      left: MediaQuery.sizeOf(context).width*0.88,
                      child: Container(
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                          child: Icon(Icons.share))
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.only(left: 19,right: 19),
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green,size: 15,),
                        SizedBox(width: 10,),
                        Text('Takes ${widget.Service.duration}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade700),),
                      ],
                    ),
                    Container(height: 1,color: Colors.black12,margin: EdgeInsets.only(top: 10),),
                    SizedBox(height: 12,),
                    Row(
                      children: [
                        Icon(Icons.security, color: Colors.purple,size: 15,),
                        SizedBox(width: 10,),
                        (widget.Service.timeWarranty !='' || widget.Service.kilometerWarranty != '' ) ?
                        (widget.Service.timeWarranty !='' && widget.Service.kilometerWarranty != '') ?
                        Text('${widget.Service.timeWarranty.toString()} Warranty or\n'
                            '${widget.Service.kilometerWarranty.toString()} Kilometers Warranty',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                        ) : (widget.Service.timeWarranty !='') ?
                        Text('${widget.Service.timeWarranty.toString()} Warranty',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                        ) :
                        Text('• ${widget.Service.kilometerWarranty.toString()} Kilometers Warranty',
                          style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                        ) : Text('No Warranty',style: TextStyle(fontSize: 14, color: Colors.grey.shade700)) ,
                      ],
                    ),
                    Container(height: 1,color: Colors.black12,margin: EdgeInsets.only(top: 10),),

                    SizedBox(height: 12,),
                    Row(
                      children: [
                        Icon(Icons.punch_clock, color: Colors.deepOrange,size: 15,),
                        SizedBox(width: 10,),
                        Text('Merchant takes ${widget.Service.confirmTime} to confirm your appointment', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade700),),
                      ],
                    ),
                    Container(height: 1,color: Colors.black12,margin: EdgeInsets.only(top: 10),),

                    SizedBox(height: 12,),
                    Row(
                      children: [
                        Icon(Icons.category, color: Colors.blue,size: 15,),
                        SizedBox(width: 10,),
                        Text('${widget.Service.category}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey.shade700),),
                      ],
                    ),
                    Container(height: 1,color: Colors.black12,margin: EdgeInsets.only(top: 10),),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.only(left: 19,right: 19,top: 6,bottom: 12,),
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SizedBox(height: 10,),
                    Text(widget.Service.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 3,),
                    Text('from "Store Name"', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                    SizedBox(height: 20,),

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

                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${percentageDifference}% OFF ',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14
                              ),
                            ),

                            TextSpan(
                              text: '${widget.Service.mrp}',
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 16
                              ),
                            ),
                            TextSpan(
                              text: ' ₹${widget.Service.sellingPrice}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                  fontSize: 18
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.only(left: 19,right: 19,top: 6,bottom: 12,),
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Location for Pickup", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.deepOrange,),
                        SizedBox(width: 5,),
                        Expanded(child:
                          Text("Yermarus Camp, GEC Campus, Near SLN Road, Raichur, Karnataka, 584135",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.orange.shade700),
                          )
                        ),
                        SizedBox(width: 5,),
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

                    Container(height: 1,color: Colors.black12,margin: EdgeInsets.only(top: 10, bottom: 12),),
                    
                    Row(
                      children: [
                        Icon(Icons.car_repair, color: Colors.grey.shade700,size: 25,),
                        SizedBox(width: 7,),
                        (widget.Service.freePickup == 'Yes') ?
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '₹199',
                                style: TextStyle(color: Colors.grey, fontSize: 12.0,decoration: TextDecoration.lineThrough,),
                              ),
                              TextSpan(
                                text: '  FREE ',
                                style: TextStyle(color: Colors.green, fontSize: 13.0, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Pickup & Drop',
                                style: TextStyle(color: Colors.green, fontSize: 13.0),
                              ),
                            ],
                          ),
                        ) :
                        Text('₹${widget.Service.pickupCharges} Pickup & Drop Charges',style: TextStyle(color: Colors.red, fontSize: 13.0),),

                      ],
                    )

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.only(left: 19,right: 19,top: 6,bottom: 12,),
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("What's Included", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),

                    ...inclusions.map((inclusion) {
                      return Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,size: 20,),
                          SizedBox(width: 7,),
                          Padding(
                            padding: const EdgeInsets.only(top: 3,bottom: 3),
                            child: Text(inclusion.trim(), style: TextStyle(color: Colors.black54),),
                          ),
                        ],
                      );
                    }),

                  ],
                ),
              ),


              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                padding: EdgeInsets.only(left: 19,right: 19,top: 6,bottom: 12,),
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),

                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6,),
                          Text("Steps after Booking", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                          SizedBox(height: 15,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ...count.map((index) {
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(right: 3,left: 8,top: 2,bottom: 2),
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: Colors.red.shade100,
                                              shape: BoxShape.circle
                                          ),
                                          child: Text(count[index-1].toString(),
                                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 14),),
                                        ),
                                        (index-1 != count.length-1) ?
                                        Container(height: 32,color: Colors.red,width: 1,) :
                                            Container(),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                              SizedBox(width: 6,),
                              Expanded(
                                child: Column(
                                  children: [
                                    ...steps.map((step) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 20),
                                        child: Text(step, style: TextStyle(color: Colors.grey.shade800),),
                                      );
                                    })
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              (additionalInclusions.length >=1) ?
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.only(left: 19,right: 19,top: 6,bottom: 12,),
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Additional Inclusions", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),

                    ...additionalInclusions.map((inclusion) {
                      return Row(
                        children: [
                          Icon(Icons.check_box, color: Colors.green,size: 20,),
                          SizedBox(width: 7,),
                          Padding(
                            padding: const EdgeInsets.only(top: 3,bottom: 3),
                            child: Text(inclusion.trim(), style: TextStyle(color: Colors.black54),),
                          ),
                        ],
                      );
                    }),

                  ],
                ),
              ) :
              Container(),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonBar(service: widget.Service,),

    );
  }
}

class FloatingActionButtonBar extends StatefulWidget {
  final service;
  const FloatingActionButtonBar({required this.service});

  @override
  _FloatingActionButtonBarState createState() => _FloatingActionButtonBarState();
}

class _FloatingActionButtonBarState extends State<FloatingActionButtonBar> {
  int _counter = 0;

  void addToCart(dynamic service) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.addItem(service,'Service');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width*0.918,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width*0.459,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
              color: Colors.blueAccent,
            ),

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: (){
                addToCart(widget.service);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_shopping_cart, color: Colors.white,),
                  SizedBox(width: 5,),
                  Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width*0.459,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
              color: Colors.red,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.book_online_outlined, color: Colors.white,size: 20,),
                  SizedBox(width: 5,),
                  Text('Book Now', style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}