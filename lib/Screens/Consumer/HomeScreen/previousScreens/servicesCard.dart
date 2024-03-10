import 'package:flutter/material.dart';
import 'data.dart';

class ServicesCard extends StatefulWidget {
  const ServicesCard();
  @override
  State<ServicesCard> createState() => _ServicesCard();
}

class _ServicesCard extends State<ServicesCard> {

  Widget build(BuildContext context)  {
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
                  child: Icon(Icons.car_repair, color: Colors.white, size: 38,),
                ),
                Text("Car Services", style: TextStyle(color: Colors.white, fontSize: 20),)
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 150,
                  child: ListView.builder (
                    itemCount: imagel.length,
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
                                  Image.asset(imagel[index], scale: 8,),
                                  Text(names[index], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
