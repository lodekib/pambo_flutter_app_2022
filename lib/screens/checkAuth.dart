import 'package:flutter/cupertino.dart';
import 'package:new_pambo/screens/login_screen.dart';
import 'package:new_pambo/screens/upload_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckAuthentication extends StatefulWidget {
  const CheckAuthentication({Key? key}) : super(key: key);

  @override
  _CheckAuthenticationState createState() => _CheckAuthenticationState();
}

class _CheckAuthenticationState extends State<CheckAuthentication> {
  bool isAuth =  false;
  @override
  void initState(){
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn()async{
    SharedPreferences localStorage =await SharedPreferences.getInstance();
    var token  = localStorage.getString('token');
    if(token != null){
      setState(() {
        isAuth =  true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if(isAuth){
      return const UploadScreen();
    }else{
      return const LoginScreen();
    }
  }
}
