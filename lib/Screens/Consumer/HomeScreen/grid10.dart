import 'package:flutter/material.dart';

class Grids extends StatelessWidget {

  final topService = [
    'assets/images/washGrid.png',
    'assets/images/inspectionGrid.jpg',
    'assets/images/dentGrid.jpg',
    'assets/images/acGrid.webp',
    'assets/images/detailingGrid.webp',
  ];

  final topProducts = [
    'assets/images/wheelGrid.jpg',
    'assets/images/cleanItemGrid.jpg',
    'assets/images/batteryGrid.jpg',
    'assets/images/mobilGrid.webp',
    'assets/images/brakeGrid.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,bottom: 10,top: 5),
            child: Text("Top Services", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900, color: Colors.black),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      margin: EdgeInsets.only(left: 8,top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                        image: DecorationImage(
                          image: AssetImage(topService[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("Car Wash", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      margin: EdgeInsets.only(left: 8,top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                        image: DecorationImage(
                          image: AssetImage(topService[1]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("Inspection", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      margin: EdgeInsets.only(left: 8,top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                        image: DecorationImage(
                          image: AssetImage(topService[2]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("Painting", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      margin: EdgeInsets.only(left: 8,top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                        image: DecorationImage(
                          image: AssetImage(topService[3]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("AC Repair", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      margin: EdgeInsets.only(left: 8,right:8,top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black12),
                        image: DecorationImage(
                          image: AssetImage(topService[4]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text("Detailing", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 15,bottom: 10, top: 20),
            child: Text("Top Products", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900, color: Colors.black),),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(left: 8,top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                          image: DecorationImage(
                            image: AssetImage(topProducts[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text("Wheels", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(left: 8,top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                          image: DecorationImage(
                            image: AssetImage(topProducts[1]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text("Cleaning", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(left: 8,top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                          image: DecorationImage(
                            image: AssetImage(topProducts[2]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text("Batteries", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(left: 8,top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                          image: DecorationImage(
                            image: AssetImage(topProducts[3]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text("Oil Products", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){

                      },
                      child: Container(
                        width: 65,
                        height: 65,
                        margin: EdgeInsets.only(left: 8,right:8,top: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black12),
                          image: DecorationImage(
                            image: AssetImage(topProducts[4]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Text("Brakes", style: TextStyle(fontWeight: FontWeight.w900,color: Colors.black87, fontSize: 13),),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}