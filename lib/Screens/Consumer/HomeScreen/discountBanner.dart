import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner();
  
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Weekend Offer", style: TextStyle(color: Colors.white, fontSize: 18),),
            Text("Get Car Service upto 60% Discount", style: TextStyle(color: Colors.white, fontSize: 23,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}