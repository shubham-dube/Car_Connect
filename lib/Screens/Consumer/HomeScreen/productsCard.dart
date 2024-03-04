import 'package:flutter/material.dart';
import 'data.dart';

class ProductsCard extends StatefulWidget {
  const ProductsCard();
  State<ProductsCard> createState() => _ProductsCard();
}

class _ProductsCard extends State<ProductsCard> {

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.25,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrangeAccent.shade200, Colors.deepOrange.shade300],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.card_giftcard, color: Colors.white, size: 35),
                ),
                Text("Car Products", style: TextStyle(color: Colors.white, fontSize: 20),)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 150,
                  child: ListView.builder (
                    itemCount: imagel2.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (true) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 5),
                          child: Container(
                            height: 130,
                            width: 130,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.white70,
                            ),
                            child:
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(imagel2[index], scale: 8,),
                                  Text(names2[index], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),


                          ),
                        );
                      }
                    },
                  )
              ),
            ),

          ],
        ),
      ),
    );

  }
}