import 'package:flutter/material.dart';
import '../SearchScreen/Search_Screen.dart';
import 'package:FixItParts/Cart_Model.dart';
import 'package:provider/provider.dart';
import '../CartScreen/Cart_Screen.dart';

class ProductScreen extends StatefulWidget {
  final product;
  final allProducts;
  final allServices;
  const ProductScreen({required this.product, required this.allProducts, required this.allServices});

  @override
  State<ProductScreen> createState() => _ProductScreen();
}

class _ProductScreen extends State<ProductScreen> {

  @override
  Widget build(BuildContext context) {
    double percentageDiff = ((double.parse(widget.product.mrp) - double.parse(widget.product.sellingPrice)) / double.parse(widget.product.mrp)) * 100;
    int percentageDifference = percentageDiff.toInt();
    Map<String, String> highlights = {
      'Brand': widget.product.brand.toString(),
      'Category': widget.product.category.toString(),
      'Model': widget.product.model.toString(),
      'Color': widget.product.color.toString(),
      'Warranty': widget.product.warranty.toString(),
    };

    Map<String, String> details = {
      'Product ID': widget.product.id.toString(),
      'Brand': widget.product.brand.toString(),
      'Category': widget.product.category.toString(),
      'Model': widget.product.model.toString(),
      'Color': widget.product.color.toString(),
      'Length': widget.product.length.toString(),
      'Breadth': widget.product.breadth.toString(),
      'Height': widget.product.height.toString(),
      'Weight': widget.product.weight.toString(),
      'HSN': widget.product.hsn.toString(),
      'Manufacturer': widget.product.manufacturer.toString(),
      'Packer': widget.product.packer.toString(),
      'Importer': widget.product.importer.toString(),
      'Country of Origin': widget.product.countryOfOrigin.toString(),
      'Warranty': widget.product.warranty.toString(),
      'Compatibility': widget.product.compatibility.toString(),
    };

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
                    height: 500,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(widget.product.imageUrl),
                            fit: BoxFit.contain
                        )
                    ),
                  ),
                  Positioned(
                      top: 12,
                      left: MediaQuery.sizeOf(context).width*0.88,
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ),
                              child: Icon(Icons.share)
                          ),
                          Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ),
                              child: Icon(Icons.thumb_up_off_alt,size: 27,)
                          ),
                        ],
                      )
                  )
                ],
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
                    Text(widget.product.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                              text: '${widget.product.mrp.toString()}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                  fontSize: 16
                              ),
                            ),
                            TextSpan(
                              text: ' ₹${widget.product.sellingPrice}',
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
                    Text("Deliver to:", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
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
                        // (widget.product.freePickup == 'Yes') ?
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: '₹99',
                                style: TextStyle(color: Colors.grey, fontSize: 12.0,decoration: TextDecoration.lineThrough,),
                              ),
                              TextSpan(
                                text: '  FREE ',
                                style: TextStyle(color: Colors.green, fontSize: 13.0, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'Delivery by Tomorrow',
                                style: TextStyle(color: Colors.green, fontSize: 13.0),
                              ),
                            ],
                          ),
                        ),
                            // : Text('₹${widget.Service.pickupCharges} Pickup & Drop Charges',style: TextStyle(color: Colors.red, fontSize: 13.0),),

                      ],
                    )

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.only(left: 19,right: 19,top: 15,bottom: 15,),
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    Column(
                      children: [
                        Icon(Icons.recycling_outlined,color: Colors.deepOrange,),
                        SizedBox(height: 4,),
                        Text("7 Days Replacement")
                      ],
                    ),

                    Column(
                      children: [
                        Icon(Icons.money_outlined, color: Colors.green,),
                        SizedBox(height: 4,),
                        Text("Cash on Delivery Available")
                      ],
                    )

                  ],
                )
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
                    Text("Highlights", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),

                  ...highlights.entries.map((entry) {
                    return Row(
                      children: [
                        Icon(Icons.check_box, color: Colors.green, size: 20,),
                        SizedBox(width: 7,),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, bottom: 3),
                          child: Text('${entry.key}: ${entry.value}', style: TextStyle(color: Colors.black54),),
                        ),
                      ],
                    );
                  }),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 2,bottom: 15),
                padding: EdgeInsets.only(left: 19,right: 19,top: 6,bottom: 12,),
                color: Colors.white,
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Product Details", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),

                    ...details.entries.map((entry) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 11, bottom: 11),
                                child: Text('${entry.key}', style: TextStyle(color: Colors.black54),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 11, bottom: 11),
                                child: Text('${entry.value}', style: TextStyle(color: Colors.black87),),
                              ),
                            ],
                          ),
                          Container(color: Colors.black12,height: 1,)
                        ],
                      );
                    }),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButtonBar(product: widget.product,),

    );
  }
}

class FloatingActionButtonBar extends StatefulWidget {
  final product;
  const FloatingActionButtonBar({required this.product});

  @override
  _FloatingActionButtonBarState createState() => _FloatingActionButtonBarState();
}

class _FloatingActionButtonBarState extends State<FloatingActionButtonBar> {

  void addToCart(dynamic product) {
    final cartModel = Provider.of<CartModel>(context, listen: false);
    cartModel.addItem(product,'Product');
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
                addToCart(widget.product);
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
                  Icon(Icons.currency_rupee, color: Colors.white,size: 20,),
                  SizedBox(width: 5,),
                  Text('Buy Now', style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}