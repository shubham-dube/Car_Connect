import 'dart:async';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../customTextField.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../productAddedDialog.dart';
import 'addCategory.dart';

class ProductForm extends StatefulWidget {
  const ProductForm();
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  var formState ;

  bool imageSelected=false;
  late File _image;
  var _title, _description,_colour, _price, _category;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
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

    final downloadUrl = await uploadTask.then((snapshot) => snapshot.ref.getDownloadURL());

    return downloadUrl;
  }

  void addProduct() async {
    showProductAddedDialog(context);
    final imageURL = await uploadImage();
    var prefs = await SharedPreferences.getInstance();
    final token = await prefs.getString("token");
    Map<String,dynamic> userData = await JwtDecoder.decode(token!);
    final mobile = userData['mobile'].toString();
    print('Image URL: $imageURL');

    var reqBody = {
      "merchantId": mobile,
      "productId": 'Product${DateTime.now()}',
      "imageUrl": imageURL,
      "title": _title,
      "description": _description,
      "color": _colour,
      "price": _price,
      "category": _category
    };

  print(reqBody);
    var jsonresponse = await http.post(
        Uri.parse(addProd),
        headers: {"content-Type": "application/json"},
        body: jsonEncode(reqBody)
    );
    var response = jsonDecode(jsonresponse.body);
    if(response['status']){
      formState.reset();
      print(response);
    }
    else {
      print("Ghanta Ukhada Tune !");
    }
  }

  @override
  Widget build(BuildContext context) {
    formState = _formKey.currentState;
    return Form(
      key: _formKey,

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: 16.0,),
                  if (imageSelected == true)
                    Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid,width: 2,color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(17),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: FileImage(_image ?? File('')),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  if(imageSelected== false)
                    Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid,width: 2,color: Colors.deepOrange),
                        borderRadius: BorderRadius.circular(17),
                        shape: BoxShape.rectangle,
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Product Image", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                            ),
                            Text("Upload an Image\n  (Square Ratio)", style: TextStyle(color: Colors.grey.shade400, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),

                  SizedBox(height: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _getImage(ImageSource.gallery);
                          imageSelected =true;
                        },
                        child: Text('Select from Gallery'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // _getImagre(ImageSource.camera);
                          // imageSelected =true;
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AddCategory())
                          );

                        },
                        child: Text('Take a Picture'),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                maxLines: 2,
                expands: false,
                label: 'Title',
                initialValue: "",
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _title = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty ) {
                    return 'Please enter a Valid Title';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                maxLines: 1,
                expands: false,
                label: 'Color',
                initialValue: "",
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _colour = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Valid Color';
                  }
                  return null;
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                maxLines: 4,
                expands: false,
                label: 'Description',
                initialValue: "",
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Valid Description';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                maxLines: 1,
                expands: false,
                label: 'Price',
                initialValue: "",
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _price = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Valid Price';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextField(
                maxLines: 1,
                expands: false,
                label: 'Category',
                initialValue: "",
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formState!.validate()) {
                    formState.save();
                    addProduct();
                    // formState.reset();
                  }
                  else {
                    print("Enter valid Details");
                  }
                },
                child: Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showProductAddedDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const ProductAddedDialog(),
  );
}