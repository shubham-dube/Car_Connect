import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:FixItParts/config.dart';
import 'package:FixItParts/Screens/LoginScreen/Login_Screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPage();
}

class _RegistrationPage extends State<RegistrationPage> {
  bool _isNotValidate = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  void registerUser() async {
    if (nameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        mobileController.text.isNotEmpty)
    {
      var reqBody = {
        "name": nameController.text,
        "email": emailController.text,
        "mobile": mobileController.text,
        "password": passwordController.text
      };

      var jsonresponse = await http.post(
          Uri.parse(registration),
          headers: {"content-Type": "application/json"},
          body: jsonEncode(reqBody)
      );
      var response = jsonDecode(jsonresponse.body);

      if (response["status"]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => showDialog1()),
        );
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
                  Text("Registration",
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
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: TextField(
                      cursorColor: Colors.blue,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Enter Full Name",
                          border: OutlineInputBorder(),
                          errorText: _isNotValidate
                              ? "Enter the Required Fields !"
                              : null,
                          errorStyle: TextStyle(color: Colors.red))),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
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
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: TextField(
                      cursorColor: Colors.blue,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Enter Email ID",
                          border: OutlineInputBorder(),
                          errorText: _isNotValidate
                              ? "Enter the Required Fields !"
                              : null,
                          errorStyle: TextStyle(color: Colors.red))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
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

                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: ElevatedButton(
                      onPressed: () => {
                        registerUser(),
                      },
                      child: Text("Register")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class showDialog1 extends StatelessWidget {
  const showDialog1();
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Message"),
      content: Text("Registration Successful"),
    );
  }
}

class showDialog2 extends StatelessWidget {
  const showDialog2();
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Message"),
      content: Text("Registration Not Successful"),
    );
  }
}
