import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:FixItParts/Screens/RegistrationScreen/Registration_Screen.dart';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Consumer/HomeScreen/Home_Screen.dart';
import '../Merchant/HomeScreen/Home_Screen.dart';

bool LOGINSTATE = false;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool _isNotValidate = false;
  bool isMerchant = false;
  var prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (passwordController.text.isNotEmpty &&
        mobileController.text.isNotEmpty)
    {
      var reqBody = {
        "mobile": mobileController.text,
        "password": passwordController.text
      };

      var jsonresponse = await http.post(
          Uri.parse(login),
          headers: {"content-Type": "application/json"},
          body: jsonEncode(reqBody)
      );
      var response = jsonDecode(jsonresponse.body);

      if (response["status"]) {
        var myToken = response['token'];
        prefs.setString('token', myToken);

        saveLoginState(true, isMerchant);

        if(isMerchant == false){

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(token: myToken),
            ),
          );
        }
        else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MerchantHomePage(token: myToken),
            ),
          );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => showDialog2()),
        );
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 190,
        title: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "FixItParts",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Log in to your Account",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: TextField(
                            cursorColor: Colors.blue,
                            controller: mobileController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: "Enter Mobile Number",
                                border: OutlineInputBorder(),
                                errorText: _isNotValidate
                                    ? "Enter the Required Fields !"
                                    : null,
                                errorStyle: TextStyle(color: Colors.red))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 20),
                        child: TextField(
                            cursorColor: Colors.blue,
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                labelText: "Enter Password",
                                border: OutlineInputBorder(),
                                errorText: _isNotValidate
                                    ? "Enter the Required Fields !"
                                    : null,
                                errorStyle: TextStyle(color: Colors.red))),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 20,right: 30),
                            child: ElevatedButton(
                                onPressed: () => {
                                  loginUser(),
                                  isMerchant = true,
                                },
                                child: Text("Merchant Login")),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 20,left: 30),
                            child: ElevatedButton(
                                onPressed: () => {
                                  loginUser(),
                                },
                                child: Text("Login")),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    child: Column(
                      children: [
                        Text("New to FixItParts? Create an Account"),
                        ElevatedButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegistrationPage()),
                              )
                            },
                            child: Text("Register Now"))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void saveLoginState(bool state, bool isMerchant) async {
  var _prefs1 = await SharedPreferences.getInstance();
  _prefs1.setBool("loginState", state);
  _prefs1.setBool("userType", isMerchant);
}
