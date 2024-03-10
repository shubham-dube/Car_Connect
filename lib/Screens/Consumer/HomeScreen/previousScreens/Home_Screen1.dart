import 'package:flutter/material.dart';
import '../../ProfileScreen/Profile_Screen.dart';
import 'servicesCard.dart';
import '../productsCard.dart';
import '../bottomNavBar.dart';
import 'categories.dart';
import '../discountBanner.dart';

class HomePage extends StatefulWidget {
  final token;
  const HomePage({required this.token});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 120,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Location of"),
                  ],
                ),

                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.account_circle,color: Colors.blue,),
                      onPressed: () {
                        // Show the profile menu.
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart,color: Colors.blue,),
                      onPressed: () {
                        // Show the cart.
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.directions_car,color: Colors.blue,),
                      onPressed: () {
                        // Show the car menu.
                      },
                    ),
                  ],
                ),

              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      style: TextStyle(
                          fontSize: 15
                      ),
                      cursorColor: Colors.blue,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search, size: 22,color: Colors.blue,),
                      ),
                      onChanged: (value) {
                        // Search for the entered value.
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[

        ],

      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
                child:
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.9,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Categories(),
                        DiscountBanner(),
                        ServicesCard(),
                        ProductsCard(),
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

      bottomNavigationBar: BottomNavBar(),
    );
  }
}