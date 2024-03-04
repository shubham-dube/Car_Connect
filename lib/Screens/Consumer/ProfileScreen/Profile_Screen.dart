import 'package:flutter/material.dart';
import 'package:FixItParts/Screens/LoginScreen/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profileData.dart';

class Profile extends StatefulWidget {
  const Profile();
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Profile", style: TextStyle(fontSize: 20),),
            ],
          ),
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width*0.5,
                  height: MediaQuery.sizeOf(context).width*0.5,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepOrange.shade300,width: 4),
                      borderRadius: BorderRadius.circular(200)
                  ),
                  child: Icon(Icons.account_circle_rounded,size: 203,color: Colors.deepOrange.shade400,),
                ),
              ),
              ProfileForm(),
            ],
          ),
        ),

        bottomNavigationBar: Container(
          color: Colors.deepOrange.shade50,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: ()=>{},
                  child: Text("Edit Profile")
              ),
              ElevatedButton(
                onPressed: ()=> {
                  saveLoginState(false),
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      )
                  )
                },
                child: Text("LogOut"),
              ),

            ],
          ),
        )
    );
  }
}

void saveLoginState(bool state) async {
  var _prefs1 = await SharedPreferences.getInstance();
  _prefs1.setBool("loginState", state);
}
