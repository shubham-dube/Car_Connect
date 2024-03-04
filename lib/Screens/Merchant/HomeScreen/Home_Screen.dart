import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../CommonWidgets/bottomNavBarMerchant.dart';
import 'appBarMerchant.dart';
import '../AddServicesScreen/AddServices_Screen.dart';
import '../AddProductScreen/AddProduct_Screen.dart';
import '../ManageProductScreen/Manage_Screen.dart';
import '../ManageServiceScreen/Manage_Screen.dart';

class MerchantHomePage extends StatefulWidget {
  final token;
  const MerchantHomePage({required this.token});

  @override
  State<MerchantHomePage> createState() => _MerchantHomePage();
}

class _MerchantHomePage extends State<MerchantHomePage> {

  final PageController imageController = PageController(viewportFraction: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMerchant(),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: Column(
          children: [
            Expanded(
                child:
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.grey.shade300, Colors.grey.shade300],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.5,right: 12,top: 12,bottom: 12),
                              child: Container(
                                width: 190,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(style: BorderStyle.none,color: Colors.deepOrange, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 22),
                                      child: Row(
                                        children: [
                                          Text("₹",style: TextStyle(fontSize: 15, fontFamily: 'Muli') ),
                                          Text("21599", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, fontFamily: 'Muli'),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 22),
                                      child: Text("Sales Today", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold, fontFamily: 'Muli')),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 12.5,top: 12,bottom: 12),
                              child: Container(
                                width: 190,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(style: BorderStyle.none,color: Colors.grey, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 22),
                                      child: Text("42", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, fontFamily: 'Muli'),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 22),
                                      child: Text("Units Today", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold, fontFamily: 'Muli')),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.5,right: 12,bottom: 12),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width*0.93,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(style: BorderStyle.none,color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Text("32", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, fontFamily: 'Muli'),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 22),
                                  child: Text("Total Services Given Today", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold, fontFamily: 'Muli')),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.5,right: 12,bottom: 12),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width*0.93,
                            height: 400,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(style: BorderStyle.none,color: Colors.grey.shade200, width: 2),
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 15.5,right: 12,bottom: 12,top: 7),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width*0.85,
                                    height: 170,
                                    decoration: BoxDecoration (
                                      color: Colors.white12,
                                      border: Border.all(style: BorderStyle.solid,color: Colors.deepOrange.shade100, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 22,top: 10),
                                          child: Text("Manage Products", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, fontFamily: 'Muli'),),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(11.0),
                                              child: GestureDetector(
                                                onTap: ()=>{
                                                  Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=> ManageProducts()),
                                                  ),
                                                },
                                                child: Container(
                                                  width: MediaQuery.sizeOf(context).width*0.38,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    color: Colors.deepOrange,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.manage_search,color: Colors.white,size: 40,),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Manage", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                                          Text("Products", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                                              child: GestureDetector(
                                                onTap: ()=>{
                                                  Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=> AddProduct()),
                                                  ),
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    color: Colors.blue,
                                                  ),
                                                  width: MediaQuery.sizeOf(context).width*0.38,
                                                  height: 100,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.add,color: Colors.white,size: 40,),
                                                      Text("Add Product", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 15.5,right: 12,bottom: 12,top: 7),
                                  child: Container(
                                    width: MediaQuery.sizeOf(context).width*0.85,
                                    height: 170,
                                    decoration: BoxDecoration (
                                      color: Colors.white12,
                                      border: Border.all(style: BorderStyle.solid,color: Colors.deepOrange.shade100, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 22,top: 10),
                                          child: Text("Manage Services", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, fontFamily: 'Muli'),),
                                        ),

                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(11.0),
                                              child: GestureDetector(
                                                onTap: (){
                                                  Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=> ManageServices()),
                                                  );
                                                },
                                                child: Container(
                                                  width: MediaQuery.sizeOf(context).width*0.38,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    color: Colors.deepOrange,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.manage_search,color: Colors.white,size: 40,),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text("Manage", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                                          Text("Services", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10,bottom: 10),
                                              child: GestureDetector(
                                                onTap: ()=>{
                                                  Navigator.push(context,
                                                    MaterialPageRoute(builder: (context)=> AddService()),
                                                  ),
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                    color: Colors.blue,
                                                  ),
                                                  width: MediaQuery.sizeOf(context).width*0.38,
                                                  height: 100,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(Icons.add,color: Colors.white,size: 40,),
                                                      Text("Add Service", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),



                      ],
                    ),
                  ),
                )
            )

            //   ],
            // ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavBarMerchant(),
    );
  }
}

void saveLoginState(bool state) async {
  var _prefs1 = await SharedPreferences.getInstance();
  _prefs1.setBool("loginState", state);
}
