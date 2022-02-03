import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';

class MakeuplistScreen extends StatefulWidget {
  const MakeuplistScreen({Key? key}) : super(key: key);

  @override
  _MakeuplistScreenState createState() => _MakeuplistScreenState();
}

class _MakeuplistScreenState extends State<MakeuplistScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Constants.makeupList.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(Constants.makeupList[index]['subcategory'].toString()),
                subtitle: Text(Constants.makeupList[index]['ads'].toString(),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){

                },
              )
          );
        }
    );
  }
}
