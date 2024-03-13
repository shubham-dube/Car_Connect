import 'package:flutter/material.dart';
import '../SearchScreen/Search_Screen.dart';
import 'package:FixItParts/Screens/Merchant/ManageProductScreen/Manage_Screen.dart';
import '../OneProductScreen/One_Product_Screen.dart';
import 'package:FixItParts/Cart_Model.dart';
import 'package:provider/provider.dart';
import '../CartScreen/Cart_Screen.dart';

class CategoryProductScreen extends StatefulWidget {

  final List<Product> allProducts;
  final allServices;
  final String category;
  final String topImage;
  final String appTitle;
  final List<String> topBrands;
  final List<String> topBrandsName;

  const CategoryProductScreen({required this.allProducts,required this.allServices,
    required this.category, required this.appTitle, required this.topImage, required this.topBrands, required this.topBrandsName});

  @override
  State<CategoryProductScreen> createState() => _CategoryProductScreen();
}

class _CategoryProductScreen extends State<CategoryProductScreen> {
  List<Product> filteredProduct = [];

  void initState() {
    super.initState();
    setState(() {
      filteredProduct = widget.allProducts.where((Product product) =>
          product.category.toLowerCase().contains(widget.category.toLowerCase())
      ).toList();
    });
  }

  void addToCart(Product product) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.addItem(product,'Product');
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Top Brands", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.topBrands.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(width: 5),
                          Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 1,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(widget.topBrands[index]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(widget.topBrandsName[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),)
                            ],
                          ),
                          SizedBox(width: 16),
                        ],
                      );
                    },
                  ),
                ),
              ),

              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.topImage),
                        fit: BoxFit.fill
                    )
                ),
              ),

              ...filteredProduct.map((product){
                double percentageDiff = ((double.parse(product.mrp) - double.parse(product.sellingPrice)) / double.parse(product.mrp)) * 100;
                int percentageDifference = percentageDiff.toInt();
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            ProductScreen(product: product, allProducts: widget.allProducts,
                                allServices: widget.allServices))
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.title, style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),),
                                    SizedBox(height: 7,),
                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      padding: EdgeInsets.only(top: 5,bottom: 5,right: 7,left: 7),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green.shade50,
                                      ),
                                      child: Text('Free Delivery by Tomorrow',
                                        style: TextStyle(fontSize: 13, color: Colors.green, fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(top: 8),
                                      padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.purple.shade50,
                                      ),
                                      child: Text('Deal of the Day',
                                        style: TextStyle(fontSize: 13, color: Colors.purple, fontWeight: FontWeight.bold),
                                      ),
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
                                                fontSize: 15,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' ₹${product.sellingPrice}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    Text('${percentageDifference}% OFF',
                                      style: TextStyle(color: Colors.green,fontSize: 13),
                                    )

                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Stack(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          height: 150,
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

                                        Padding(
                                          padding: const EdgeInsets.only(top: 10, left:0),
                                          child: SizedBox(
                                            height: 40,
                                            width: 90,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                ),
                                                onPressed: (){
                                                  addToCart(product);
                                                },
                                                child: Text("Add")
                                            ),
                                          ),
                                        ),

                                      ],
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
                          label: Text('Recommended'),
                          backgroundColor: Colors.green,
                          labelStyle:TextStyle(color: Colors.white,
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
              }).toList(),


            ],
          ),
        ),
      ),
    );
  }
}