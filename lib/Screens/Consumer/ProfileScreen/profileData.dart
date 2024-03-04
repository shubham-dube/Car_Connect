import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm();
  @override
  State<ProfileForm> createState() => _ProfileForm();
}

class _ProfileForm extends State<ProfileForm> {
  var mobile;
  var userData;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    var prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Map<String,dynamic> tokenData = JwtDecoder.decode(token!);
    mobile = tokenData['mobile'];

    var reqBody = {
      "mobile": mobile
    };

    var jsonresponse = await http.post(
        Uri.parse(getData),
        headers: {"content-Type": "application/json"},
        body: jsonEncode(reqBody)
    );
    userData = jsonDecode(jsonresponse.body);
    print('Tension Na le Bhai - ${userData}');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height*0.42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.deepOrange),
            color: Colors.deepOrange.shade300,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  width: MediaQuery.sizeOf(context).width*0.9,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.deepOrange.shade50),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person, color: Colors.white,),
                            Text("Name", style: TextStyle(color: Colors.white,fontSize: 15),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(userData['name'], style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width*0.9,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.deepOrange.shade50),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.cake, color: Colors.white,),
                            Text("Date of Birth", style: TextStyle(color: Colors.white,fontSize: 15),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text("Not Updated", style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width*0.9,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.deepOrange.shade50),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.email, color: Colors.white,),
                            Text("Email ID", style: TextStyle(color: Colors.white,fontSize: 15),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(userData['email'], style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width*0.9,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.deepOrange.shade50),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.male, color: Colors.white,),
                            Text("Gender", style: TextStyle(color: Colors.white,fontSize: 15),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text("Not Updated", style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ],
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width*0.9,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.deepOrange.shade50),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.mobile_friendly, color: Colors.white,),
                            Text("Mobile Number", style: TextStyle(color: Colors.white,fontSize: 15),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(mobile.toString(), style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class UserData {
  final String name;
  final String email;
  final int mobile;

  UserData({
    required this.name,
    required this.email,
    required this.mobile,
  });
}