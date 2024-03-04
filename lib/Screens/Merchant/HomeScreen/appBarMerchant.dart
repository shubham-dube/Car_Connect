import 'package:flutter/material.dart';
import '../ProfileScreen/Profile_Screen.dart';

class AppBarMerchant extends StatefulWidget implements PreferredSizeWidget {
  const AppBarMerchant();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  State<AppBarMerchant> createState() => _AppBarMerchant();
}

class _AppBarMerchant extends State<AppBarMerchant> {
  @override

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlue],
        ),
      ),

      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Padding(
              padding: const EdgeInsets.only(right: 90),
              child: Text("Merchant Dashboard", style: TextStyle(color: Colors.white, fontSize: 20),),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: ()=>{
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile())
                      )
                    },
                    child: Icon(Icons.account_circle_rounded,color: Colors.white,size: 27,)
                ),

                Text('Profile', style: TextStyle(color: Colors.white, fontSize: 10),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}