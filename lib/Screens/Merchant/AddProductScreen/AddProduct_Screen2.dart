import 'package:flutter/material.dart';
import '../CommonWidgets/bottomNavBarMerchant.dart';
import 'addProductForm.dart';

class AddProduct extends StatefulWidget {
  const AddProduct();
  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> with TickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  List<String> topVerticals = [
    "Screen Guards",
    "T Shirts",
    "Bottles",
    "Regional Books",
    "Gift Cards",
    "Jewellery",
    "Mobile & Tablets",
    "Industrial Furniture",
    "Musical Instruments",
    "Smart Devices"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          unselectedLabelColor: Colors.black87,
          labelColor: Colors.white,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.deepOrange,
                width: 2,
              ),
            ),
          ),
          controller: _tabController,
          tabs: [
            Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(Icons.check_circle_outline_outlined, size: 15,),
                    ),
                    Text("Select Category", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)
                  ],
                )
            ),
            Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(Icons.check_circle_outline_outlined, size: 15,),
                    ),
                    Text("Select Brand", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                  ],
                )
            ),
            Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Icon(Icons.check_circle_outline_outlined, size: 15,),
                    ),
                    Text("Product Info", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                  ],
                )
            ),
          ],
        ),
        title: Text("Add Listings", style: TextStyle(fontSize: 20),),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                SizedBox(
                  height: 56,
                  width: MediaQuery.sizeOf(context).width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.search),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                              style: TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                floatingLabelStyle: TextStyle(color: Colors.black),
                                labelText: "Search Category of a Product",
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
                  ),
                ),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("Top Categories", style: TextStyle(fontWeight: FontWeight.bold),),
                ),


                SizedBox(
                  height: 170,
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.6,
                    children: topVerticals.map((vertical) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: ListTile(
                              title: Text(vertical, style: TextStyle(fontSize: 12),),
                              onTap: () {
                                _tabController.animateTo(
                                  _tabController.index + 1,
                                  duration: Duration(milliseconds: 300),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("All Categories", style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                SizedBox(height: 7,),
                Expanded(
                    child: ListView.builder(
                      itemCount: topVerticals.length,
                        itemBuilder: (context,index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8,left: 8),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey.shade100,width: 1))
                              ),
                              child: ListTile(
                                title: Text(topVerticals[index], style: TextStyle(fontSize: 12),),
                                onTap: () {
                                  _tabController.animateTo(
                                    _tabController.index + 1,
                                    duration: Duration(milliseconds: 300),
                                  );
                                },
                              ),
                            ),
                          );
                        }
                    )
                )

              ],
            ),
          ),

          Container(
            child: Center(
              child: Text("QSearch category of a product"),
            ),
          ),

          Container(
            child: Center(
              child: Text("Top verticals"),
            ),
          ),

        ],
      ),
    );
  }
}