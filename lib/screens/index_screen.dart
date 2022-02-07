import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/screens/home_screen.dart';
import 'package:new_pambo/screens/login_screen.dart';
import 'package:new_pambo/screens/upload_screen.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int currentIndex=0;

  List  <Widget>pages = <Widget>[
    const HomeScreen(),
    const UploadScreen(),
    const LoginScreen()
  ];

  void onItemTap(int index){
    setState(() {
      currentIndex = index;
    });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTap,
          currentIndex:currentIndex,
          selectedItemColor: Constants.pamboprimaryColor,
          unselectedItemColor:Colors.grey.withOpacity(0.5),
          showUnselectedLabels: true,
          backgroundColor: Constants.pamboscaffoldColor,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 30,),
                label:'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.upload_outlined,size: 30,),
                label:'Upload Service'),
            BottomNavigationBarItem(
                icon:Icon(Icons.person_outline,size: 30,),
                label:'Profile'
            )
          ]
      ),
    );

  }


}
