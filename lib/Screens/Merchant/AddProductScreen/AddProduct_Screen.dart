import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'successScreen.dart';

class Brands {
  final String id;
  final String name;
  final String grade ;

  Brands({
    this.grade = '1',
    required this.id,
    required this.name,
  });

  factory Brands.fromJson(Map<String, dynamic> json) {
    return Brands(
      id: json['_id'],
      name: json['name'],
      grade: json['grade'].toString(),
    );
  }
}

class Categories {
  final String id;
  final String name;

  Categories({
    required this.id,
    required this.name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class AddProduct extends StatefulWidget {
  const AddProduct();
  @override
  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> with TickerProviderStateMixin{
  String searchQuery = '';
  String searchQuery2 = '';
  late TabController _tabController;
  List<Categories> filteredCategories = [];
  List<Categories> allCategories = [];
  List<Brands> filteredBrands = [];
  List<Brands> allBrands = [];
  String selectedCategory = '';
  String selectedBrand = '';
  List<String> topVerticals = [
    "Spare Tires",
    "Licence Plate Frames",
    "Fluids (coolant, brake fluid, etc.)",
    "Car Vacuum Cleaners",
    "Floor Mats",
    "Speakers",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getCategory();
    getBrand();
  }

  void getCategory() async {
    var jsonResponse = await http.get(
      Uri.parse(getCategories),
      headers: {"content-Type": "application/json"},
    );
    allCategories = (jsonDecode(jsonResponse.body) as List<dynamic>).map((json) => Categories.fromJson(json)).toList();
    filteredCategories = allCategories;
    print(filteredCategories.length);
    setState(() {});
  }

  void getBrand() async {
    var jsonResponse = await http.get(
      Uri.parse(getBrands),
      headers: {"content-Type": "application/json"},
    );
    allBrands = (jsonDecode(jsonResponse.body) as List<dynamic>).map((json) => Brands.fromJson(json)).toList();
    filteredBrands = allBrands;
    print(filteredBrands.length);
    setState(() {});
  }

  Future<void> addBrandToDb(String brandName) async {
    var reqBody = {
      "name": brandName
    };
    var jsonResponse = await http.post(
      Uri.parse(addBrand),
      headers: {"content-Type": "application/json"},
      body: jsonEncode(reqBody),
    );
    var response = jsonDecode(jsonResponse.body);
    setState(() {
      getBrand();
    });
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: EdgeInsets.all(8),
          backgroundColor: Colors.white,
          title: const Text('Status', style: TextStyle(fontSize: 15,),),
          content: response['status'] ?
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Brand Added Successfully"),
          ) :
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Brand Addition Failed"),
          ),

          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> showWaiting() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            buttonPadding: EdgeInsets.all(8),
            backgroundColor: Colors.white,
            title: const Text('Adding your Product', style: TextStyle(fontSize: 15,),),
            content: SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator(color: Colors.black,)))
        );
      },
    );
  }

  final _brandNameController = TextEditingController();

  Future<void> _showAddBrandDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          buttonPadding: EdgeInsets.all(8),
          backgroundColor: Colors.white,
          title: const Text('Add New Brand', style: TextStyle(fontSize: 15,),),
          content: SizedBox(
            width: MediaQuery.sizeOf(context).width*0.8,
            child: TextField(
              controller: _brandNameController,
              decoration: InputDecoration(
                labelText: 'Brand Name',
                filled: true,
                fillColor: Colors.grey[100],
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.grey , width: 1.0),
                ),
                contentPadding: const EdgeInsets.all(8.0),
              ),

            ),
          ),

          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                String brandName = _brandNameController.text;
                addBrandToDb(brandName);
                Navigator.pop(context);
                setState(() {  });
              },
            ),
          ],
        );
      },
    );
  }

  String statusOfProduct = 'Active';
  String countryOfOrigin = 'India';
  List<String> _options = ['Active', 'Inactive'];
  List<String> countries = ['India', 'US', 'China', 'Israel'];
  bool imageSelected = false;
  late File _image;

  // Text Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController skuIdController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController breadthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController hsnController = TextEditingController();
  final TextEditingController manufacturerDetailsController = TextEditingController();
  final TextEditingController packerDetailsController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController importerDetailsController = TextEditingController();
  final TextEditingController domesticWarrantyController = TextEditingController();
  final TextEditingController compatibilityDetailsController = TextEditingController();

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if(pickedFile !=null){
      imageSelected = true;
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadImage() async {
    final storage = FirebaseStorage.instance.ref();
    final reference = storage.child('product_images/Product${DateTime.now().millisecondsSinceEpoch}.png');
    final uploadTask = reference.putFile(_image);

    uploadTask.snapshotEvents.listen((event) {
      final progress = event.bytesTransferred / event.totalBytes * 100;
      print('Upload progress: $progress%');
    });
    final imageUrl = await uploadTask.then((snapshot) => snapshot.ref.getDownloadURL());
    return imageUrl;
  }

  String showError(String flag){
    return '${flag} is required';
  }
  bool _isNotValidate = false;

  void SaveProduct()async{
    if(titleController.text.isNotEmpty && skuIdController.text.isNotEmpty && mrpController.text.isNotEmpty
        && sellingPriceController.text.isNotEmpty && stockController.text.isNotEmpty && hsnController.text.isNotEmpty
        && modelController.text.isNotEmpty
    )
    {
      showWaiting();
      var prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      Map<String,dynamic> tokenData = JwtDecoder.decode(token!);
      final mobile = tokenData['mobile'];
      final imageUrl = await uploadImage();
      var reqBody = {
        "merchantId": mobile.toString(),
        "title": titleController.text,
        "imageUrl": imageUrl,
        "category": selectedCategory,
        "brand": selectedBrand,
        "skuId": skuIdController.text,
        "mrp": mrpController.text,
        "sellingPrice": sellingPriceController.text,
        "stock": stockController.text,
        "length": lengthController.text,
        "breadth": breadthController.text,
        "height": heightController.text,
        "weight": weightController.text,
        "color": colorController.text,
        "hsn": hsnController.text,
        "manufacturer": manufacturerDetailsController.text,
        "packer": packerDetailsController.text,
        "importer": importerDetailsController.text,
        "status": statusOfProduct,
        "countryOfOrigin": countryOfOrigin,
        "model": modelController.text,
        "warranty": domesticWarrantyController.text,
        "compatibility": compatibilityDetailsController.text
      };
      var jsonResponse = await http.post(
        Uri.parse(addProd),
        headers: {"content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      final response = jsonDecode(jsonResponse.body);
      if(response['status']){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessScreen(
              title: titleController.text,
              color: colorController.text,
              brand: selectedBrand,
              category: selectedCategory,
              model: modelController.text,
              imageUrl: imageUrl,
            ),
          ),
        );
      }
      else {
        print("NOT ADDED");
      }

    }
    else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(70, 100),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.deepOrange.shade100,Colors.blue.shade100], begin: Alignment.topLeft,end: Alignment.bottomRight)
          ),
          child: AppBar(
            bottom: TabBar(
              unselectedLabelColor: Colors.black87,
              labelColor: Colors.deepOrange,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(Icons.check_circle_outline_outlined, size: 15,),
                            ),
                            Text("Select Category", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Text(selectedCategory, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(Icons.check_circle_outline_outlined, size: 15,),
                            ),
                            Text("Select Brand", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                          ],
                        ),
                        Text(selectedBrand, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
                      ],
                    )
                ),
                Tab(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Icon(Icons.check_circle_outline_outlined, size: 15,),
                            ),
                            Text("Product Info", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                          ],
                        ),
                        Text("", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                      ],
                    )
                ),
              ],
            ),
            title: Text("Add Listings", style: TextStyle(fontSize: 20),),
          ),
        ),
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
                              onChanged: (value) {
                                setState(() {
                                  searchQuery = value.toLowerCase();
                                  filteredCategories = allCategories.where((Categories category) =>
                                      category.name.toLowerCase().contains(searchQuery)
                                  ).toList();
                                });

                                if (filteredCategories.isEmpty) {
                                  filteredCategories = [Categories(name: "No Category Found", id: "")];
                                }
                              },
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
                                selectedCategory = vertical;
                                _tabController.animateTo(
                                  _tabController.index + 1,
                                  duration: Duration(milliseconds: 300),
                                );
                                setState(() {});
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
                        itemCount: filteredCategories.length,
                        itemBuilder: (context,index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8,left: 8),
                            child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade100,width: 1))
                              ),
                              child: ListTile(
                                title: Text(filteredCategories[index].name, style: TextStyle(fontSize: 12),),
                                onTap: () {
                                  selectedCategory = filteredCategories[index].name;
                                  _tabController.animateTo(
                                    _tabController.index + 1,
                                    duration: Duration(milliseconds: 300),
                                  );
                                  setState(() {});
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  SizedBox(
                    height: 65,
                    width: MediaQuery.sizeOf(context).width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value.toLowerCase();
                                    filteredBrands = allBrands.where((Brands brand) =>
                                        brand.name.toLowerCase().contains(searchQuery)
                                    ).toList();
                                  });

                                  if (filteredBrands.isEmpty) {
                                    filteredBrands = [Brands(name: "Brand not Found", id: "")];
                                  }
                                },
                                style: TextStyle(fontSize: 16),
                                decoration: InputDecoration(
                                  floatingLabelStyle: TextStyle(color: Colors.black),
                                  labelText: "Search Brand",
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

                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(right: 10,left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("All Brands", style: TextStyle(fontWeight: FontWeight.bold),),
                        TextButton(
                            onPressed: ()=>_showAddBrandDialog(),
                            child: Text("Add New Brand", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),)
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: filteredBrands.length,
                          itemBuilder: (context,index) {
                            return Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey.shade100,width: 1))
                              ),
                              child: ListTile(
                                title: Text(filteredBrands[index].name, style: TextStyle(fontSize: 12),),
                                onTap: () {
                                  selectedBrand = filteredBrands[index].name;
                                  _tabController.animateTo(
                                    _tabController.index + 1,
                                    duration: Duration(milliseconds: 300),
                                  );
                                  setState(() {});
                                },
                              ),
                            );
                          }
                      )
                  )
                ],
              )
          ),

          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text("Product Image", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Product View", style: TextStyle(fontWeight: FontWeight.bold),),
                                  SizedBox(width: 8,),
                                  Icon(Icons.info_outline_rounded, size: 16,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Stack(
                        children: [
                          Container(
                            width: 330,
                            height: 190,
                          ),
                          Positioned.fill(
                            child: DottedBorder(
                              color: Colors.grey,
                              dashPattern: [4, 4],
                              strokeWidth: 1.0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: imageSelected != false
                                      ? DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.contain,
                                  )
                                      : DecorationImage(
                                    image: AssetImage('assets/images/NoImage.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 300, top: 160),
                              child: IconButton(
                                  onPressed: (){
                                    imageSelected = false;
                                    setState(() {
                                    });
                                  },
                                  icon: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.delete_outlined, color: Colors.black,),
                                      )
                                  )
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 140,
                            child: ElevatedButton(
                                onPressed: (){
                                  getImage(ImageSource.gallery);
                                },
                                child: Text("Gallery")
                            ),
                          ),
                          SizedBox(width: 10,),
                          SizedBox(
                            width: 140,
                            child: ElevatedButton(
                                onPressed: (){
                                  getImage(ImageSource.camera);
                                },
                                child: Text("Take a Picture")
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Follow the Below Image Guidelines", style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text("Image Resolution",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Use clear color image with minimum resolution of 500x500 px"),
                          SizedBox(height: 10,),
                          Text("Image Guidelines", style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Upload authentic product photos taken in bright lighting"),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text("Product Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text("Listing Information", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: titleController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Product Title",
                                  errorText: _isNotValidate
                                      ? "Title is Required !"
                                      : null,
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("It will shows to the buyer on the top "
                                "(Keep it smaller with proper definition of your product)",
                              style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: skuIdController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Seller SKU ID",
                                  errorText: _isNotValidate
                                      ? "Enter the Required Fields !"
                                      : null,
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Unique Identifier for the Listings", style: TextStyle(fontSize: 10),),


                            SizedBox(height: 15,),
                            Text("Status Details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            Text("Status", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 7,),
                            SizedBox(
                              height: 47,
                              child: Stack (
                                children: [
                                  Positioned(
                                      child: Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                            border: Border.all(style: BorderStyle.solid,color: Colors.black54),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.transparent
                                        ),
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 21),
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width*0.88,
                                      child: DropdownButton<String>(
                                        value: statusOfProduct,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(left: 250),
                                          child: const Icon(Icons.arrow_drop_down),
                                        ),
                                        iconSize: 24.0,
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.black, fontSize: 16.0),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.transparent,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            statusOfProduct = newValue!;
                                          });
                                        },
                                        items: _options.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text("If Inactive then it will not shows to the buyer", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Price Details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: mrpController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "MRP",
                                  errorText: _isNotValidate
                                      ? "MRP is Required !"
                                      : null,
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Maximum Retail Price of the Product", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: sellingPriceController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Your selling price",
                                  errorText: _isNotValidate
                                      ? "Selling Price is Required !"
                                      : null,
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Price at which you want to sell this listing", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Inventory Details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: stockController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Stock",
                                  errorText: _isNotValidate
                                      ? "Stock os Required !"
                                      : null,
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Number of Items you have in Stock", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Package details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: lengthController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Length",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Length of the Package in cms", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: breadthController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Breadth",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Breadth of the Package in cms", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: heightController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Height",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Height of the Package in cms", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: weightController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Weight",
                                  errorText: _isNotValidate
                                      ? "Weight is Required !"
                                      : null,
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Weight of the final package in kgs", style: TextStyle(fontSize: 10),),
                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: colorController,
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Color",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Defines the color of the product (if applicable)", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Tax details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: hsnController,
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "HSN",
                                  errorText: _isNotValidate
                                      ? "HSN Code is Required !"
                                      : null,
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Code of your product for determining applicable tax rates",
                              style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Manufacturing Details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            Text("Country of Origin", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 7,),
                            SizedBox(
                              height: 47,
                              child: Stack (
                                children: [
                                  Positioned(
                                      child: Container(
                                        width: MediaQuery.sizeOf(context).width,
                                        decoration: BoxDecoration(
                                            border: Border.all(style: BorderStyle.solid,color: Colors.black54),
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.transparent
                                        ),
                                      )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 21),
                                    child: SizedBox(
                                      width: MediaQuery.sizeOf(context).width*0.88,
                                      child: DropdownButton<String>(
                                        value: countryOfOrigin,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(left: 250),
                                          child: const Icon(Icons.arrow_drop_down),
                                        ),
                                        iconSize: 24.0,
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.black, fontSize: 16.0),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.transparent,
                                        ),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            countryOfOrigin = newValue!;
                                          });
                                        },
                                        items: countries.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text("Country of origin at manufacturing or country of assembly in case of imported products", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: manufacturerDetailsController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Manufacturer Details",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Name and address of the Manufacturer", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: packerDetailsController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Packer Details",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Where Manufacturer is not the Packer, name and address of the packer", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: importerDetailsController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Importer Details",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Name and address of the importer "
                                "if the product is being imported", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: modelController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Model Number",
                                  errorText: _isNotValidate
                                      ? "Model Number is Required !"
                                      : null,
                                  errorStyle: TextStyle(color: Colors.red),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("It Will help finding this product uniquely. "
                                "It is unique for every product in a brand", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Warranty", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: domesticWarrantyController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Domestic Warranty (e.g. 1 Year, 6 Months)",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Domestic Warranty refers to the number of years that"
                                " the brand supports the domestic warranty of the product"
                              , style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Compatibility Details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            SizedBox(
                              height: 47,
                              child: TextField(
                                controller: compatibilityDetailsController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.grey),
                                  labelText: "Car Names (Write Car Names after comma ',')",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(),
                                  ),
                                ),
                              ),
                            ),
                            Text("Cars that are compatible with that Product", style: TextStyle(fontSize: 10),)

                          ],
                        ),
                      ),
                    ],
                  ),

                ),
              ),

            ],
          )

        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.deepOrange.shade50,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: ()=>{},
                child: Text("Save as Draft")
            ),
            ElevatedButton(
              onPressed: ()=> {
                SaveProduct()

              },
              child: Text("Add to Catalogue"),
            ),
          ],
        ),
      ),
    );
  }
}