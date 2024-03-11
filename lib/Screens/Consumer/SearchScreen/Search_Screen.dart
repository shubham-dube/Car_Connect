import 'package:flutter/material.dart';
import 'package:FixItParts/Screens/Merchant/ManageProductScreen/Manage_Screen.dart';
import 'package:FixItParts/Screens/Merchant/ManageServiceScreen/Manage_Screen.dart';
import '../OneProductScreen/One_Product_Screen.dart';
import '../OneServiceScreen/One_Service_Screen.dart';

class Both {
  final String id;
  final int v;
  final String merchantId;
  final String title;
  final String imageUrl;
  var status;
  var category;
  var skuId;
  var mrp;
  var sellingPrice;
  var duration;
  var confirmTime;
  var pickupCharges;
  var pickupFlag;
  var freePickup;
  var hsn;
  var inclusions;
  var additionalInclusions;
  var kilometerWarranty;
  var timeWarranty;
  var compatibility;
  var color;
  var brand;
  var stock;
  var length;
  var breadth;
  var height;
  var weight;
  var manufacturer;
  var packer;
  var importer;
  var countryOfOrigin;
  var model;
  var warranty;
  final String type;

  Both({
    required this.id,
    required this.v,
    required this.merchantId,
    required this.title,
    required this.imageUrl,
    required this.status,
    required this.category,
    required this.skuId,
    required this.mrp,
    required this.sellingPrice,
    required this.duration,
    required this.confirmTime,
    required this.pickupCharges,
    required this.pickupFlag,
    required this.freePickup,
    required this.hsn,
    required this.inclusions,
    required this.additionalInclusions,
    required this.kilometerWarranty,
    required this.timeWarranty,
    required this.compatibility,
    required this.color,
    required this.brand,
    required this.stock,
    required this.length,
    required this.breadth,
    required this.height,
    required this.weight,
    required this.manufacturer,
    required this.packer,
    required this.importer,
    required this.countryOfOrigin,
    required this.model,
    required this.warranty,
    required this.type,
  });
}
class SearchScreen extends StatefulWidget {
  final String searchQuery;
  final List<Product> allProducts;
  final List<Service> allServices;
  const SearchScreen({required this.searchQuery, required this.allProducts, required this.allServices});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  TextEditingController searchQueryController = TextEditingController();
  List<Service> filteredServices = [];
  List<Product> filteredProducts = [];
  late List<Both> allItems;
  List<Both> filteredItems = [];
  String displayNone = '';
  String searchQuery = '';

  void initState() {
    super.initState();
    searchQueryController.text = widget.searchQuery;
    filteredServices = widget.allServices;
    filteredProducts = widget.allProducts;
    searchQuery = widget.searchQuery.toLowerCase();

    allItems = filteredServices.map((service) {
      return Both(
        id: service.id,
        v: service.v,
        merchantId: service.merchantId,
        title: service.title,
        imageUrl: service.imageUrl,
        status: service.status,
        category: service.category,
        skuId: service.skuId,
        mrp: service.mrp,
        sellingPrice: service.sellingPrice,
        duration: service.duration,
        confirmTime: service.confirmTime,
        pickupCharges: service.pickupCharges,
        pickupFlag: service.pickupFlag,
        freePickup: service.freePickup,
        hsn: service.hsn,
        inclusions: service.inclusions,
        additionalInclusions: service.additionalInclusions,
        kilometerWarranty: service.kilometerWarranty,
        timeWarranty: service.timeWarranty,
        compatibility: service.compatibility,
        color: null,
        brand: null,
        stock: null,
        length: null,
        breadth: null,
        height: null,
        weight: null,
        manufacturer: null,
        packer: null,
        importer: null,
        countryOfOrigin: null,
        model: null,
        warranty: null,
        type: "Service"
      );
    }).toList();

    allItems.addAll(filteredProducts.map((product) {
      return Both(
        id: product.id,
        v: product.v,
        merchantId: product.merchantId,
        title: product.title,
        imageUrl: product.imageUrl,
        status: product.status,
        category: product.category,
        skuId: product.skuId,
        mrp: product.mrp,
        sellingPrice: product.sellingPrice,
        duration: null,
        confirmTime: null,
        pickupCharges: null,
        pickupFlag: null,
        freePickup: null,
        hsn: product.hsn,
        inclusions: null,
        additionalInclusions: null,
        kilometerWarranty: null,
        timeWarranty: null,
        compatibility: null,
        color: product.color,
        brand: product.brand,
        stock: product.stock,
        length: product.length,
        breadth: product.breadth,
        height: product.height,
        weight: product.weight,
        manufacturer: product.manufacturer,
        packer: product.packer,
        importer: product.importer,
        countryOfOrigin: product.countryOfOrigin,
        model: product.model,
        warranty: product.warranty,
          type: "Product"
      );
    }).toList());
    filteredItems = allItems;
    setState(() {
      filteredItems = allItems.where((Both item) =>
          item.title.toLowerCase().contains(searchQuery)
      ).toList();
      if (filteredItems.isEmpty) {
        displayNone = "No Item found matching your search";
      }
      else {
        displayNone = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              title: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        controller: searchQueryController,
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
                        onChanged: (value){
                          setState(() {
                            searchQuery = value.toLowerCase();
                            filteredItems = allItems.where((Both item) =>
                                item.title.toLowerCase().contains(searchQuery)
                            ).toList();
                            if (filteredItems.isEmpty) {
                              displayNone = "No Item found matching your search";
                            }
                            else {
                              displayNone = "";
                            }
                          });
                        },
                      ),
                    ),
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
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  (displayNone=='') ?
                  Row(
                    children: [
                      Text("   Search Items", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    ],
                  ) :
                  Text('${displayNone}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
          
                  ...filteredItems.map((item){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          (item.type != 'Service') ?
                              ProductScreen(product: item, allProducts: widget.allProducts,
                                  allServices: widget.allServices) :
                              ServiceScreen(Service: item, allProducts: widget.allProducts, allServices: widget.allServices)
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.black12,
                                width: 1.0,
                              ),
                            ),
                            color: Colors.white
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(item.imageUrl),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: (item.type=='Service') ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                                            margin: EdgeInsets.only(right: 8,top: 3),
                                            decoration: BoxDecoration(
                                                color: Colors.green.shade50,
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            child: Text('${item.category.toString()}',
                                              style: TextStyle(fontSize: 12,color: Colors.green,fontWeight: FontWeight.w900),)
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                                          margin: EdgeInsets.only(right: 8,top: 3),
                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent.shade100,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Text('${item.type.toString()}',
                                            style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text('• Takes ${item.duration.toString()} '
                                        '• ${item.inclusions.toString().replaceAll(',', ' •')} ',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    (item.freePickup == 'yes') ?
                                    Text('• Free Pickup & Drop',
                                      style: TextStyle(fontSize: 12),
                                    ) :
                                    Text('',
                                      style: TextStyle(fontSize: 0),
                                    ),
                                  ],
                                ) :
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                                            margin: EdgeInsets.only(right: 8,top: 3),
                                            decoration: BoxDecoration(
                                                color: Colors.green.shade50,
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            child: Text('${item.category.toString()}',
                                              style: TextStyle(fontSize: 12,color: Colors.green,fontWeight: FontWeight.w900),)
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 6,right: 6,top: 2,bottom: 2),
                                          margin: EdgeInsets.only(right: 8,top: 3),
                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent.shade100,
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Text('${item.type.toString()}',
                                            style: TextStyle(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text('Brand: ${item.brand.toString()}', style: TextStyle(fontSize: 12),),
                                    Text('Model: ${item.model.toString()}', style: TextStyle(fontSize: 12),),
                                    Text('Color: ${item.color.toString()}', style: TextStyle(fontSize: 12),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
          
                  }),
          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}