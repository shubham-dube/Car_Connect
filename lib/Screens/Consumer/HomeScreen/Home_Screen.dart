import 'package:FixItParts/Screens/Consumer/MyOrdersScreen/My_Orders_Screen.dart';
import 'package:FixItParts/Screens/Consumer/OneProductScreen/One_Product_Screen.dart';
import 'package:flutter/material.dart';
import '../ProfileScreen/Profile_Screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'grid10.dart';
import 'package:FixItParts/config.dart';
import 'package:FixItParts/Screens/Merchant/ManageServiceScreen/Manage_Screen.dart';
import 'package:FixItParts/Screens/Merchant/ManageProductScreen/Manage_Screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../SearchScreen/Search_Screen.dart';
import '../OneServiceScreen/One_Service_Screen.dart';
import '../CartScreen/Cart_Screen.dart';
import 'package:FixItParts/Cart_Model.dart';
import 'package:provider/provider.dart';

class Commitment {
  final String image;
  final String text;
  Commitment({required this.image, required this.text});
}

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Service> allServices = [];
  List<Product> allProducts = [];
  List<Product> recomendedProducts1 = [];
  List<Product> recomendedProducts = [];

  @override
  void initState() {
    super.initState();
    getAllData();
  }

  void addToCart(dynamic item, String type) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.addItem(item,type);
  }

  Future<void> getAllData() async {
    var productsJsonResponse = await http.post(
        Uri.parse(getProd),
        headers: {"content-Type": "application/json"},
    );
    var servicesJsonResponse = await http.post(
      Uri.parse(getServiceReq),
      headers: {"content-Type": "application/json"},
    );

    allServices = (jsonDecode(servicesJsonResponse.body) as List<dynamic>).map((json) => Service.fromJson(json)).toList();
    allProducts = (jsonDecode(productsJsonResponse.body) as List<dynamic>).map((json) => Product.fromJson(json)).toList();
    print(allServices[0].title);
    print(allProducts[0].title);
    for(int i=0;i<3;i++){
      recomendedProducts.add(allProducts[i]);
    }
    for(int i=3;i<6;i++){
      recomendedProducts1.add(allProducts[i]);
    }

  }

  int _current = 0;
  List<String> imageList = [
    'assets/images/wash.jpg',
    'assets/images/dentingPainting.jpg',
    'assets/images/cleaning.jpg',
    'assets/images/tireChange.jpg',
  ];

  List<Commitment> commitment = [
    Commitment(
      image: 'assets/images/pickupIcon.png',
      text: 'Free Pickup & Drop',
    ),
    Commitment(
      image: 'assets/images/partsIcon.png',
      text: 'Genuine Parts',
    ),
    Commitment(
      image: 'assets/images/warrantyIcon.png',
      text: '30 Days Warranty',
    ),
    Commitment(
      image: 'assets/images/walletIcon.png',
      text: 'Affordable Prices',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(
                color: Colors.white
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Raichur, Yermarus Camp', style: TextStyle(fontSize: 15),),
                  Row(
                    children: [
                      Consumer<CartModel>(
                        builder: (context, cartModel, child) {
                          return Stack(
                            children: [
                              IconButton(
                                icon: Icon(Icons.shopping_cart),
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(
                                    allServices: allServices,allProducts: allProducts,
                                  )));
                                },
                              ),
                              if (cartModel.itemCount > 0)
                                Positioned(
                                  right: 6,
                                  top: 5,
                                  child: CircleAvatar(
                                    radius: 9,
                                    backgroundColor: Colors.red,
                                    child: Text(
                                      cartModel.itemCount.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                            ],
                          );

                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.car_repair_outlined),
                        onPressed: () {

                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.account_circle_rounded),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Profile())
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              onSubmitted: (value){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchScreen(
                                          searchQuery: value,
                                          allProducts: allProducts,
                                          allServices: allServices,
                                        ),
                                    ),
                                );
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search Services & Products',
                                border: InputBorder.none,
                                filled: true,
                                contentPadding: EdgeInsets.all(8.0),
                                fillColor: Colors.grey[200],
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floating: true,
              pinned: true,
              snap: false,
              expandedHeight: 100.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.blue,
                ),
              ),
              elevation: 0,
            ),

          ];
        },

        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey.shade200,
          child: ListView(
            padding: EdgeInsets.only(top: 15,right: 6,left: 6),
            children: [
              CarouselSlider(
                items: imageList.map((url) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                            border: Border.all(color: Colors.black12,width: 3),
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(url),
                              fit: BoxFit.fitWidth
                            )
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  height: 162,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return Container(
                    width: 6.0,
                    height: 6.0,
                    margin: EdgeInsets.symmetric(vertical: 7.0, horizontal: 5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == entry.key ? Colors.blue : Colors.grey,
                    ),
                  );
                }).toList(),
              ),

              Grids(allProducts: allProducts, allServices: allServices),

              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7,left: 15,bottom: 10),
                          child: Text("Guaranteed Service", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.keyboard_arrow_right, weight: 2,size: 30,),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: CarouselSlider(
                        items: commitment.map((commit) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.sizeOf(context).width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Image.asset(commit.image),
                                      width: 30,
                                      height: 30,
                                      margin: EdgeInsets.only(left: 10,bottom: 5),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 10,bottom: 5,right: 10),
                                        child: Text(commit.text)
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                        options: CarouselOptions(
                          initialPage: 3,
                          height: 90,
                          autoPlay: false,
                          enlargeCenterPage: false,
                          viewportFraction: 0.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 0),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7,left: 15,bottom: 10),
                          child: Text("Suggested For You", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ),),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.keyboard_arrow_right, weight: 2,size: 30,),
                        )
                      ],
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          Row(
                          children: [
                            ...recomendedProducts.map((suggest){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  ProductScreen(product: suggest, allProducts: allProducts, allServices: allServices))
                                  );
                                },
                                child: Container(
                                  height: 190,
                                  width: MediaQuery.sizeOf(context).width*0.3,
                                  margin: EdgeInsets.only(right: 5,left: 5, bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                        ),
                                        height: 126,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Image.network(suggest.imageUrl),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 5),
                                        child: Text(suggest.title,overflow: TextOverflow.ellipsis, maxLines: 1,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 5),
                                        child: Text(suggest.category,overflow: TextOverflow.ellipsis, maxLines: 1,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '₹${suggest.mrp}',
                                                style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ₹${suggest.sellingPrice}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),

                        Row(
                          children: [
                            ...recomendedProducts1.map((suggest){
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                      ProductScreen(product: suggest, allProducts: allProducts, allServices: allServices))
                                  );
                                },
                                child: Container(
                                  height: 190,
                                  width: MediaQuery.sizeOf(context).width*0.3,
                                  margin: EdgeInsets.only(right: 5,left: 5, bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade400),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white
                                        ),
                                        height: 126,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Image.network(suggest.imageUrl),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 5),
                                        child: Text(suggest.title,overflow: TextOverflow.ellipsis, maxLines: 1,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 5),
                                        child: Text(suggest.category,overflow: TextOverflow.ellipsis, maxLines: 1,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '₹${suggest.mrp}',
                                                style: TextStyle(
                                                  decoration: TextDecoration.lineThrough,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' ₹${suggest.sellingPrice}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        )

                      ],
                    ),


                    //
                    // SizedBox(
                    //   width: 300,
                    //   child: GridView.count(
                    //     padding: EdgeInsets.only(top: 12),
                    //     crossAxisCount: 3,
                    //     childAspectRatio: 0.7,
                    //     children: recomendedProducts.map((suggest) {
                    //       return Container(
                    //         margin: EdgeInsets.only(right: 5,left: 5, bottom: 10),
                    //         decoration: BoxDecoration(
                    //             border: Border.all(color: Colors.grey.shade400),
                    //             borderRadius: BorderRadius.circular(5)
                    //         ),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Container(
                    //               decoration: BoxDecoration(
                    //                   image: DecorationImage(
                    //                     image: NetworkImage(suggest.imageUrl),
                    //                     fit: BoxFit.contain,
                    //                   ),
                    //                   color: Colors.white
                    //               ),
                    //               height: 126,
                    //               // child: Padding(
                    //               //   padding: const EdgeInsets.all(5.0),
                    //               //   child: Image.network(suggest.imageUrl),
                    //               // ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 5,right: 5),
                    //               child: Text(suggest.title,overflow: TextOverflow.ellipsis, maxLines: 1,),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 5,right: 5),
                    //               child: Text(suggest.category,overflow: TextOverflow.ellipsis, maxLines: 1,),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 5),
                    //               child: Text.rich(
                    //                 TextSpan(
                    //                   children: [
                    //                     TextSpan(
                    //                       text: '₹${suggest.mrp}',
                    //                       style: TextStyle(
                    //                         decoration: TextDecoration.lineThrough,
                    //                         color: Colors.grey,
                    //                       ),
                    //                     ),
                    //                     TextSpan(
                    //                       text: ' ₹${suggest.sellingPrice}',
                    //                       style: TextStyle(
                    //                         color: Colors.black,
                    //                         fontWeight: FontWeight.bold,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  children: [
                    Container(
                      height: 240,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/referal.jpg'),
                              fit: BoxFit.contain
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("     Earn ₹1000 for every Friend you Refer",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            Text("      Get a friend to start using FixItParts",
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: Colors.grey),
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SizedBox(height: 34,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      onPressed: (){},
                                      child: Text("Refer Now")
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}