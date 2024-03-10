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

class AddService extends StatefulWidget {
  const AddService();
  @override
  State<AddService> createState() => _AddService();
}

class _AddService extends State<AddService> with TickerProviderStateMixin{
  String searchQuery = '';
  late TabController _tabController;
  List<Categories> filteredCategories = [];
  List<Categories> allCategories = [];
  String selectedCategory = '';

  List<String> topVerticals = [
    "Car Wash",
    "AC Service",
    "Denting and Painting",
    "Car Inspections",
    "Repair",
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getCategory();
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

  Future<void> showWaiting() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            buttonPadding: EdgeInsets.all(8),
            backgroundColor: Colors.white,
            title: const Text('Adding your Service', style: TextStyle(fontSize: 15,),),
            content: SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator(color: Colors.black,)))
        );
      },
    );
  }

  String statusOfListing = 'Active';
  String pickupFlag = 'Yes';
  String freePickupFlag = 'Yes';
  List<String> _options = ['Active', 'Inactive'];
  List<String> pickupOptions = ['Yes', 'No'];
  List<String> freePickupOptions = ['Yes', 'No'];
  bool imageSelected = false;
  late File _image;

  // Text Controllers
  final TextEditingController titleController = TextEditingController();
  final TextEditingController skuIdController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController timeConfirmController = TextEditingController();
  final TextEditingController pickupChargesController = TextEditingController();
  final TextEditingController hsnController = TextEditingController();
  final TextEditingController inclusionsController = TextEditingController();
  final TextEditingController additionalInclusionsController = TextEditingController();
  final TextEditingController kilometerWarrantyController = TextEditingController();
  final TextEditingController timeWarrantyController = TextEditingController();
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
    final reference = storage.child('service_images/Service${DateTime.now().millisecondsSinceEpoch}.png');
    final uploadTask = reference.putFile(_image);

    uploadTask.snapshotEvents.listen((event) {
      final progress = event.bytesTransferred / event.totalBytes * 100;
      print('Upload progress: $progress%');
    });
    final imageUrl = await uploadTask.then((snapshot) => snapshot.ref.getDownloadURL());
    return imageUrl;
  }

  bool _isNotValidate = false;

  void SaveService()async{
    if(titleController.text.isNotEmpty && skuIdController.text.isNotEmpty && mrpController.text.isNotEmpty
        && sellingPriceController.text.isNotEmpty && durationController.text.isNotEmpty && timeConfirmController.text.isNotEmpty
        && hsnController.text.isNotEmpty
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
        "status": statusOfListing,
        "category": selectedCategory,
        "skuId": skuIdController.text,
        "mrp": mrpController.text,
        "sellingPrice": sellingPriceController.text,
        "duration": durationController.text,
        "confirmTime": timeConfirmController.text,
        "pickupCharges": pickupChargesController.text,
        "pickupFlag": pickupFlag,
        "freePickup": freePickupFlag,
        "hsn": hsnController.text,
        "inclusions": inclusionsController.text,
        "additionalInclusions": additionalInclusionsController.text,
        "kilometerWarranty": kilometerWarrantyController.text,
        "timeWarranty": timeWarrantyController.text,
        "compatibility": compatibilityDetailsController.text
      };
      var jsonResponse = await http.post(
        Uri.parse(addServiceReq),
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
              status: statusOfListing,
              category: selectedCategory,
              imageUrl: imageUrl,
              duration: durationController.text,
              price: sellingPriceController.text
            ),
          ),
        );
        print(response);
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
      appBar: AppBar(
        bottom: TabBar(
          unselectedLabelColor: Colors.black87,
          labelColor: Colors.white,
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
                        Text("Services Info", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Text("", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))
                  ],
                )
            ),
          ],
        ),
        title: Text("Add Service Listing", style: TextStyle(fontSize: 20),),
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
                              child: Text("Front Image", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Banner View", style: TextStyle(fontWeight: FontWeight.bold),),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 13,right: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Follow the Below Image Guidelines", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text("Image Resolution",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Use High Quality Banner image with minimum resolution of 500x500 px"),
                            SizedBox(height: 10,),
                            Text("Image Guidelines", style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Use Good Looking and Attractive Banner"),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20,),
                            Text("Service Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text("Listing Information", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            TextField(
                              controller: titleController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Title",
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
                            Text("It will shows to the consumer on the top "
                                "(Keep it smaller with proper definition of your service)",
                              style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            TextField(
                              controller: skuIdController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Merchant Unique ServiceID",
                                errorText: _isNotValidate
                                    ? "ServiceId is Required  !"
                                    : null,
                                errorStyle: TextStyle(color: Colors.red),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
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
                                        value: statusOfListing,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(left: 280),
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
                                            statusOfListing = newValue!;
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
                            Text("If Inactive then it will not shows to the consumer", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Charges Details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            TextField(
                              controller: mrpController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "MRC",
                                errorText: _isNotValidate
                                    ? "MRC is Required !"
                                    : null,
                                errorStyle: TextStyle(color: Colors.red),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("Maximum Retail Charges of the Service", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            TextField (
                              controller: sellingPriceController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Your Listing Charges",
                                errorText: _isNotValidate
                                    ? "Your Listing Charges is Required !"
                                    : null,
                                errorStyle: TextStyle(color: Colors.red),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("Price at which you want to charge for this Service", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Time Constraints", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            TextField(
                              controller: durationController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Duration (in Hour). e.g. 3 Hours",
                                errorText: _isNotValidate
                                    ? "Duration os Required !"
                                    : null,
                                errorStyle: TextStyle(color: Colors.red),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("Total Time Required to do this "
                                "Service (including Pickup and Drop Time)", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            TextField(
                              controller: timeConfirmController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Time required to Confirm Appointment/Pickup",
                                errorText: _isNotValidate
                                    ? "Required !"
                                    : null,
                                errorStyle: TextStyle(color: Colors.red),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("Total Time Required to confirm this appointment or "
                                "pickup booked by customer from your side", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Pickup and Drop details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            Text("Can you Provide Pickup and Drop Facility", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                        value: pickupFlag,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(left: 290),
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
                                            pickupFlag = newValue!;
                                          });
                                        },
                                        items: pickupOptions.map<DropdownMenuItem<String>>((String value) {
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
                            Text("It Provides you more benefit as it will "
                                "show on top if you can provide this facility", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            Text("Want to give this facility 'free'", style: TextStyle(fontWeight: FontWeight.bold),),
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
                                        value: freePickupFlag,
                                        icon: Padding(
                                          padding: const EdgeInsets.only(left: 290),
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
                                            freePickupFlag = newValue!;
                                          });
                                        },
                                        items: freePickupOptions.map<DropdownMenuItem<String>>((String value) {
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
                            Text("If you chosen this then you have give free Pickup and"
                                "Drop facility to the consumer", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            TextField(
                              controller: pickupChargesController,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Pickup and Drop Charges",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("Cost charged when consumer uses Pickup and Drop Facility", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Tax details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            TextField(
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
                            Text("Code of your product for determining applicable tax rates",
                              style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("What's Included", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            TextField(
                              controller: inclusionsController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Enter Inclusions (Add Multiple after ',')",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("What SubServices are included in this Service", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            TextField(
                              controller: additionalInclusionsController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Additional SubServices (Add Multiple)",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("You Can add additional SubServices that you want", style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Warranty", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            TextField(
                              controller: kilometerWarrantyController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "No. of Kilometers of warranty",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("It refers to the warranty based on how much car is being"
                                " travelled after servicing"
                              , style: TextStyle(fontSize: 10),),

                            SizedBox(height: 12,),
                            TextField(
                              controller: timeWarrantyController,
                              cursorColor: Colors.blue,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.grey),
                                labelText: "Tenure of Warranty (in Year or Months). e.g. 3 Months",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(),
                                ),
                              ),
                            ),
                            Text("It refers to the warranty for a particular time period"
                                " if the car is not travelled beyond the warranty limit"
                              , style: TextStyle(fontSize: 10),),

                            SizedBox(height: 15,),
                            Text("Compatibility Details", style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 12,),
                            TextField(
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
                            Text("Cars that are compatible with that Service", style: TextStyle(fontSize: 10),)
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
                SaveService()
              },
              child: Text("Add to Catalogue"),
            ),
          ],
        ),
      ),
    );
  }
}