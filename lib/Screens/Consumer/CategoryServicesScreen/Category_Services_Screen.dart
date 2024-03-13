import 'package:flutter/material.dart';
import '../SearchScreen/Search_Screen.dart';
import 'package:FixItParts/Screens/Merchant/ManageServiceScreen/Manage_Screen.dart';
import '../OneServiceScreen/One_Service_Screen.dart';
import 'package:FixItParts/Cart_Model.dart';
import 'package:provider/provider.dart';
import '../CartScreen/Cart_Screen.dart';

class CategoryServicesScreen extends StatefulWidget {
  final allProducts;
  final List<Service> allServices;
  final String category;
  final String topImage;
  final String appTitle;
  const CategoryServicesScreen({required this.allServices,
    required this.allProducts, required this.category, required this.appTitle, required this.topImage});

  @override
  State<CategoryServicesScreen> createState() => _CategoryServicesScreen();
}

class _CategoryServicesScreen extends State<CategoryServicesScreen> {
  List<Service> filteredServices = [];

  void initState() {
    super.initState();
    setState(() {
      filteredServices = widget.allServices.where((Service service) =>
          service.category.toLowerCase().contains(widget.category.toLowerCase())
      ).toList();
    });
  }

  void addToCart(dynamic service) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.addItem(service,'Service');
  }

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.appTitle),
                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              SearchScreen(searchQuery: '', allProducts: widget.allProducts, allServices:widget.allServices))
                          );
                        },
                        icon: Icon(Icons.search)
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
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.topImage),
                    fit: BoxFit.cover
                  )
                ),
              ),

              ...filteredServices.map((service){
                double percentageDiff = ((service.mrp - double.parse(service.sellingPrice)) / service.mrp) * 100;
                int percentageDifference = percentageDiff.toInt();
                    return Stack(
                      children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  ServiceScreen(Service: service, allServices: widget.allServices, allProducts: widget.allProducts,))
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 25, right: 15,left: 15),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                borderRadius: BorderRadius.circular(12)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 16,left: 16,top: 30,bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(service.title, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 7,),
                                          Text('• Takes ${service.duration.toString()}',
                                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                          ),

                                          (service.timeWarranty !='' || service.kilometerWarranty != '' ) ?
                                          (service.timeWarranty !='' && service.kilometerWarranty != '') ?
                                          Text('• ${service.timeWarranty.toString()} Warranty\n'
                                              '• ${service.kilometerWarranty.toString()} Kilometers Warranty',
                                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                          ) : (service.timeWarranty !='') ?
                                          Text('• ${service.timeWarranty.toString()} Warranty',
                                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                          ) :
                                          Text('• ${service.kilometerWarranty.toString()} Kilometers Warranty',
                                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                          ) : Text('• No Warranty',style: TextStyle(fontSize: 12, color: Colors.grey.shade700)) ,

                                          Text('• Maximum ${service.confirmTime} required to confirm your appointment',
                                            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                          ),

                                          (service.freePickup == 'Yes') ?
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            padding: EdgeInsets.only(top: 5,bottom: 5,right: 7,left: 7),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.green.shade50,
                                            ),
                                            child: Text('Free Pickup & Drop',
                                              style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),
                                            ),
                                          ) :
                                          Container(
                                            margin: EdgeInsets.only(top: 8),
                                            padding: EdgeInsets.only(top: 5,bottom: 5,right: 7,left: 7),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.green.shade50,
                                            ),
                                            child: Text('₹${service.pickupCharges} Pickup & Drop Charges ',
                                              style: TextStyle(fontSize: 12, color: Colors.deepOrange, fontWeight: FontWeight.bold),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Stack(
                                      children: [
                                        Column(
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
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' ₹${service.sellingPrice}',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Text('${percentageDifference}% OFF',
                                              style: TextStyle(color: Colors.green,fontSize: 12),
                                            )
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 82, left: 14),
                                          child: SizedBox(
                                            height: 30,
                                            width: 73,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                ),
                                                onPressed: (){
                                                  addToCart(service);
                                                },
                                                child: Text("Add")
                                            ),
                                          ),
                                        ),
                                      ]
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        Positioned(
                          top: 15,
                          left: 20,
                          child: SizedBox(
                            height: 30,
                            width: 120,
                            child: Chip(
                              label: (service.freePickup == 'Yes') ? Text('Recommended'): Text('Newly Added'),
                              backgroundColor: (service.freePickup == 'Yes') ? Colors.green : Colors.blue.shade100,
                              labelStyle:TextStyle(color: (service.freePickup == 'Yes') ? Colors.white: Colors.blue,
                                  fontSize: 12, fontWeight: FontWeight.bold ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide.none,
                              labelPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),


                      ],
                    );
                }).toList()
            ],
          ),
        ),
      ),
    );
  }
}