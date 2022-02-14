import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_pambo/components/bezier_container.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/network_utils/api.dart';
import 'package:new_pambo/screens/home_screen.dart';
import 'package:new_pambo/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key ?key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
 bool _isLoading = false;
  var first_name,last_name,phone,id_number,email,password;
  final _formKey = GlobalKey<FormState>();

 _showMessage(message){
   final snackBar=SnackBar(
     content: Text(message),
     action: SnackBarAction(
       label: 'Close',
       onPressed: (){

       },
     ),
   );
   ScaffoldMessenger.of(context).showSnackBar(snackBar);
 }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Constants.pamboprimaryColor),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Constants.pamboprimaryColor))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title,{bool isPassword = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: (){
   if(_formKey.currentState!.validate()){
     _register();
   }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFDB228E),
                  Color(0xFFDB228E)])),
        child: const Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const LoginScreen()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'Pa',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Constants.pamboprimaryColor
          ),

          children: [
            TextSpan(
              text: 'mbo',
              style: TextStyle(color: Constants.pamboprimaryColor, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
      Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  <Widget>[
          const Text(
            'First Name',
            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
           const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (firstname){
              if(firstname!.isEmpty){
                return 'Please provide your first name';
              }
              first_name = firstname;
              return null;
            },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                const Text(
                  'Last Name',
                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator: (lastname){
                      if(lastname!.isEmpty){
                        return 'Please provide your last name';
                      }
                      last_name = lastname;
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                const Text(
                  'Email Address',
                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator: (this_email){
                      if(this_email!.isEmpty){
                        return 'Please provide your email address';
                      }
                      email = this_email;
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                const Text(
                  'ID Number',
                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator: (idnumber){
                      if(idnumber!.isEmpty){
                        return 'Please provide your ID number';
                      }
                      id_number = idnumber;
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                const Text(
                  'Phone Number',
                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    validator: (phonenumber){
                      if(phonenumber!.isEmpty){
                        return 'Please provide your phone number';
                      }
                      phone = phonenumber;
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                const Text(
                  'Password',
                  style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  obscureText: true,
                    validator: (userpassword){
                      if(userpassword!.isEmpty){
                        return 'Please provide your password';
                      }
                      password = userpassword;
                      return null;
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
                child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    const SizedBox(
                      height: 20,
                    ),
                    _emailPasswordWidget(),
                   const  SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .001),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );

  }
  _register() async{
    setState(() {
      _isLoading = true;
    });

    var res = await Network().authData(<String,String>{
      'first_name':first_name,
      'last_name':last_name,
      'phone':phone,
      'id_number':id_number,
      'email':email,
      'password':password
    }, '/register');
    var resbody = json.decode(res.body);
    if(resbody['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', json.encode(resbody['token']));
      localStorage.setString('user', json.encode(resbody['user']));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration successful'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Constants.pamboprimaryColor,
      ));
      print(resbody['user']);
      Navigator.push(context, MaterialPageRoute(builder:(context)=>const HomeScreen()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Unable to register'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Constants.pamboprimaryColor,
      ));
      print(resbody['message']);
    }

    setState(() {
      _isLoading= false;
    });
  }

  validateFirstname(firstname){
    if(firstname.isEmpty){
      return 'Please provide your first name';
    }
    first_name = firstname;
    return null;
  }

}