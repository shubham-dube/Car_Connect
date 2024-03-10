import 'package:flutter/material.dart';
import '../../ProfileScreen/Profile_Screen.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar();
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  State<SearchAppBar> createState() => _SearchAppBar();
}


class _SearchAppBar extends State<SearchAppBar>  {
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
        iconTheme: IconThemeData(
          color: Colors.black38
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 27,),
                Text('Cart', style: TextStyle(color: Colors.white, fontSize: 10),),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Container();
                        },
                      ),
                    );
                  },
                  child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile())
                        );

                      },
                      child: Icon(Icons.account_circle_rounded,color: Colors.white,size: 27,)
                  ),
                ),
                Text('Profile', style: TextStyle(color: Colors.white, fontSize: 10),),
              ],
            ),

          ],
        ),
        bottom: ,
      ),
    );
  }
}