import 'package:flutter/material.dart';
import 'searchAppBar.dart';
import 'servicesCard.dart';
import 'productsCard.dart';
import 'bottomNavBar.dart';
import 'categories.dart';
import 'discountBanner.dart';

class HomePage extends StatefulWidget {
  final token;
  const HomePage({required this.token});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  final PageController imageController = PageController(viewportFraction: 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(),
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