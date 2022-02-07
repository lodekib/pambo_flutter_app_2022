import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
            children:[
              InkWell(
                onTap:(){
                  print("Hello");
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height:60,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Constants.pamboprimaryColor,
                              borderRadius: BorderRadius.circular(75),
                              border: Border.all(color:Constants.pamboprimaryColor,width:1.0)
                          ),
                          child:Image.asset('assets/images/icons8-marker-p-50.png'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left:18.0),
                        child: Text("PAMBO",style: TextStyle(fontWeight: FontWeight.bold,fontSize:23,color:Constants.pamboprimaryColor)),
                      ),
                    ]
                ),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Help and Support",style:TextStyle(fontWeight: FontWeight.bold,fontSize:15.0)),
              ),
              const ListTile(
                leading:Icon(Icons.support_agent,color:Constants.pamboprimaryColor,size: 30,),
                title: Text("Customer Service",style: TextStyle(fontWeight: FontWeight.w300),),
                trailing: Icon(Icons.arrow_forward_ios,size:10.0),
              ),
              const ListTile(
                leading:Icon(Icons.textsms_outlined,color:Constants.pamboprimaryColor,size: 30,),
                title: Text("Feedback",style: TextStyle(fontWeight: FontWeight.w300),),
                trailing: Icon(Icons.arrow_forward_ios,size: 10.0,),
              ),
              const ListTile(
                leading:Icon(Icons.gavel_outlined,color:Constants.pamboprimaryColor,size: 30,),
                title: Text("Dispute resolution guide",style: TextStyle(fontWeight: FontWeight.w300),),
                trailing: Icon(Icons.arrow_forward_ios,size: 10.0,),
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Settings and Legal issues",style: TextStyle(fontWeight: FontWeight.bold,fontSize:13)),
              ),
              const ListTile(
                leading:Icon(Icons.local_police_outlined,color:Constants.pamboprimaryColor,size: 30,),
                title: Text("Authority",style: TextStyle(fontWeight: FontWeight.w300),),
                trailing: Icon(Icons.arrow_forward_ios,size: 10.0,),
              ),
              const ListTile(
                leading:Icon(Icons.text_snippet_outlined,color:Constants.pamboprimaryColor,size: 30,),
                title: Text("Terms and Conditions",style: TextStyle(fontWeight: FontWeight.w300),),
                trailing: Icon(Icons.arrow_forward_ios,size: 10.0,),
              ),
              const ListTile(
                leading:Icon(Icons.settings_outlined,color:Constants.pamboprimaryColor,size: 30,),
                title: Text("Settings",style: TextStyle(fontWeight: FontWeight.w300),),
                trailing: Icon(Icons.arrow_forward_ios,size: 10.0,),
              ),
              const Divider(),
              const ListTile(
                leading:Icon(Icons.logout_outlined,color:Constants.pamboprimaryColor,size: 30,),
                title: Text("Log Out",),
                trailing: Icon(Icons.arrow_forward_ios,size: 10.0,),
              ),

            ]
        ),
      ),
    );

  }
}