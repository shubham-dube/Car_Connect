import 'package:flutter/material.dart';
import '../CategoryServicesScreen/Category_Services_Screen.dart';
import '../CategoryProductScreen/Category_Product_Screen.dart';

class Grids extends StatelessWidget {
  final allServices;
  final allProducts;
  Grids({required this.allProducts, required this.allServices});

  final List<String> appTitles = [
    'Car Washing Services',
    'Car Inspection Services',
    'Car Denting & Painting',
    'Car AC Service',
    'Car Detailing Services',
    'Car Wheels & Tyres',
    'Car Cleaning Products',
    'Car Batteries',
    'Car Oil Products',
    'Car Brakes'
  ];
  final List<String> topImages = [
    'assets/images/washBanner.jpg',
    'assets/images/inspectionBanner.png',
    'assets/images/scratchBanner.png',
    'assets/images/acBanner.png',
    'assets/images/detailingBanner.png',
    'assets/images/tyreBanner.png',
    'assets/images/cleaningBanner.webp',
    'assets/images/batteryBanner.jpg',
    'assets/images/oilBanner.png',
    'assets/images/brakeBanner.jpg',
  ];

  final List<String> topBrakeBrands = [
    'assets/images/masuLogo.jpg',
    'assets/images/mindaLogo.png',
    'assets/images/tvsClutchLogo.jpeg',
    'assets/images/boschLogo.jpg',
  ];
  final List<String> topBrakeBrandsName = [
    'Masu Brakes',
    'Uno Minda',
    'TVS AutoClutch',
    'Bosch',
  ];

  final List<String> topWheelBrands = [
    'assets/images/mrfLogo.png',
    'assets/images/neoLogo.jpg',
    'assets/images/michelinLogo.webp',
    'assets/images/apolloLogo.png',
    'assets/images/ceatLogo.png',
  ];
  final List<String> topWheelBrandsName = [
    'MRF',
    'Neo Wheels',
    'Michelin',
    'Apollo tyres',
    'CEAT Tyres'
  ];

  final List<String> topBatteriesBrands = [
    'assets/images/exideLogo.webp',
    'assets/images/amaronLogo.jpg',
    'assets/images/tataGreenLogo.png',
    'assets/images/johnsonControlLogo.png',
  ];
  final List<String> topBatteriesBrandsName = [
    'EXIDE',
    'Amaron',
    'TATA',
    'Johnson Control',
  ];

  final List<String> topCleaningBrands = [
    'assets/images/3mLogo.jpg',
    'assets/images/waxpolLogo.jpg',
  ];
  final List<String> topCleaningBrandsName = [
    '3M',
    'Waxpol',
  ];

  final List<String> topOilBrands = [
    'assets/images/castrolLogo.webp',
    'assets/images/mobilLogo.jpg',
  ];
  final List<String> topOilBrandsName = [
    'Castrol',
    'Mobil',
  ];

  final List<String> topService = [
    'assets/images/washGrid.png',
    'assets/images/inspectionGrid.jpg',
    'assets/images/dentGrid.jpg',
    'assets/images/acGrid.webp',
    'assets/images/detailingGrid.webp',
  ];

  final List<String> topProducts = [
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              CategoryServicesScreen(
                                  allServices: allServices, allProducts: allProducts,
                                category: 'Car Wash',appTitle: appTitles[0],topImage: topImages[0],
                              )
                          )
                      );
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              CategoryServicesScreen(
                                allServices: allServices, allProducts: allProducts,
                                category: 'Inspection',appTitle: appTitles[1],topImage: topImages[1],
                              )
                          )
                      );
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              CategoryServicesScreen(
                                allServices: allServices, allProducts: allProducts,
                                category: 'Denting & Painting',appTitle: appTitles[2],topImage: topImages[2],
                              )
                          )
                      );
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              CategoryServicesScreen(
                                allServices: allServices, allProducts: allProducts,
                                category: 'AC Repair',appTitle: appTitles[3],topImage: topImages[3],
                              )
                          )
                      );
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              CategoryServicesScreen(
                                allServices: allServices, allProducts: allProducts,
                                category: 'Detailing',appTitle: appTitles[4],topImage: topImages[4],
                              )
                          )
                      );
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                CategoryProductScreen(
                                  allServices: allServices, allProducts: allProducts,
                                  category: 'Wheels & Tyres',appTitle: appTitles[5],topImage: topImages[5],
                                  topBrands: topWheelBrands, topBrandsName: topWheelBrandsName,
                                )
                            )
                        );
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                CategoryProductScreen(
                                  allServices: allServices, allProducts: allProducts,
                                  category: 'Cleaning',appTitle: appTitles[6],topImage: topImages[6],
                                  topBrands: topCleaningBrands,topBrandsName: topCleaningBrandsName,
                                )
                            )
                        );
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                CategoryProductScreen(
                                  allServices: allServices, allProducts: allProducts,
                                  category: 'Batteries',appTitle: appTitles[7],topImage: topImages[7],
                                  topBrands: topBatteriesBrands,topBrandsName: topBatteriesBrandsName,
                                )
                            )
                        );
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                CategoryProductScreen(
                                  allServices: allServices, allProducts: allProducts,
                                  category: 'oil',appTitle: appTitles[8],topImage: topImages[8],
                                  topBrands: topOilBrands,topBrandsName: topOilBrandsName,
                                )
                            )
                        );
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                CategoryProductScreen(
                                  allServices: allServices, allProducts: allProducts,
                                  category: 'Brake',appTitle: appTitles[9],topImage: topImages[9],
                                  topBrands: topBrakeBrands,topBrandsName: topBrakeBrandsName,
                                )
                            )
                        );
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