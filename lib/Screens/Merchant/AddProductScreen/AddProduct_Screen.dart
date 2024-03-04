import 'package:flutter/material.dart';
import '../CommonWidgets/bottomNavBarMerchant.dart';
import 'addProductForm.dart';

class AddProduct extends StatefulWidget {
  const AddProduct();

  State<AddProduct> createState() => _AddProduct();
}

class _AddProduct extends State<AddProduct> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text("Add Product", style: TextStyle(fontSize: 20),),
        )),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child:
          ProductForm(),
        ),
      ),
      bottomNavigationBar: BottomNavBarMerchant(),
    );
  }
}