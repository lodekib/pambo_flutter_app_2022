import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(children: [
          InkWell(
            onTap: () async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              print(jsonDecode(localStorage.getString('user')!)['user']);
              print(jsonDecode(localStorage.getString('token')!)['token']);
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Constants.pamboprimaryColor,
                          borderRadius: BorderRadius.circular(75),
                          border: Border.all(
                              color: Constants.pamboprimaryColor, width: 1.0)),
                      child:
                          Image.asset('assets/images/icons8-marker-p-50.png'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 18.0),
                    child: Text("PAMBO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Constants.pamboprimaryColor)),
                  ),
                ]),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Help and Support",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
          ),
          const ListTile(
            leading: Icon(
              Icons.support_agent,
              color: Constants.pamboprimaryColor,
              size: 30,
            ),
            title: Text(
              "Customer Service",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            trailing: Icon(Icons.arrow_forward_ios, size: 10.0),
          ),
          const ListTile(
            leading: Icon(
              Icons.textsms_outlined,
              color: Constants.pamboprimaryColor,
              size: 30,
            ),
            title: Text(
              "Feedback",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 10.0,
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.gavel_outlined,
              color: Constants.pamboprimaryColor,
              size: 30,
            ),
            title: Text(
              "Dispute resolution guide",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 10.0,
            ),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Settings and Legal issues",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
          const ListTile(
            leading: Icon(
              Icons.local_police_outlined,
              color: Constants.pamboprimaryColor,
              size: 30,
            ),
            title: Text(
              "Authority",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 10.0,
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.text_snippet_outlined,
              color: Constants.pamboprimaryColor,
              size: 30,
            ),
            title: Text(
              "Terms and Conditions",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 10.0,
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: Constants.pamboprimaryColor,
              size: 30,
            ),
            title: Text(
              "Settings",
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 10.0,
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              if (localStorage.getString('token') != null) {
                print(localStorage.getString('token'));
                var res = await Network().getData('/logout');
                var body = json.decode(res.body);

                // if(body['success']){
                //   SharedPreferences localStorage = await SharedPreferences.getInstance();
                //   localStorage.remove('token');
                //   localStorage.remove('user');
                //   print(body);
                // }else {
                //   print(body);
                // }
              } else {
                print('You are not signed In yet');
              }
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout_outlined,
                color: Constants.pamboprimaryColor,
                size: 30,
              ),
              title: Text(
                "Log Out",
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 10.0,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
