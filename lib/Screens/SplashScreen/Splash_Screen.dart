import 'package:FixItParts/Screens/Consumer/HomeScreen/HandleFile.dart';
import 'package:FixItParts/Screens/Merchant/HomeScreen/HandleFile.dart';
import 'package:flutter/material.dart';
import '../LoginScreen/Login_Screen.dart';
import '../Consumer/HomeScreen/Home_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../Merchant/HomeScreen/Home_Screen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage();

  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      whereToGo(this.context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlue.shade200 ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("FixItParts",style: TextStyle(color: Colors.white, fontSize: 50,fontWeight: FontWeight.bold),),
                Text("A Complete Car Services App",style: TextStyle(color: Colors.white, fontSize: 15),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(color: Colors.white,strokeWidth: 4,),
                ),
              ],
            )
        )
    );
  }
}

void whereToGo(context) async {
  var pref = await SharedPreferences.getInstance();
  var isLoggedIn = pref.getBool("loginState");
  var isMerchant = pref.getBool("userType");

  if(isLoggedIn!=null){
    if(isLoggedIn==true){
      if(isMerchant == true){
        var token = pref.getString("token");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HandleFile2(),
          ),
        );
      }

      else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HandleFile(),
          ),
        );
      }
    }
    if(isLoggedIn==false){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginPage(),
        ),
      );
    }
  }
  else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LoginPage(),
      ),
    );
  }
}