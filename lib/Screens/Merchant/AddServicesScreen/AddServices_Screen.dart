import 'package:flutter/material.dart';
import '../CommonWidgets/bottomNavBarMerchant.dart';
import 'addServiceForm.dart';

class AddService extends StatefulWidget {
  const AddService();
  @override
  State<AddService> createState() => _AddService();
}

class _AddService extends State<AddService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text("Add Service", style: TextStyle(fontSize: 20),),
        )),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child:
          ServiceForm(),
        ),
      ),
      bottomNavigationBar: BottomNavBarMerchant(),
    );
  }
}