import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';

class JewellerylistScreen extends StatefulWidget {
  const JewellerylistScreen({Key? key}) : super(key: key);

  @override
  _JewellerylistScreenState createState() => _JewellerylistScreenState();
}

class _JewellerylistScreenState extends State<JewellerylistScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Constants.jewellerylist.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(Constants.jewellerylist[index]['subcategory'].toString()),
                subtitle: Text(Constants.jewellerylist[index]['ads'].toString(),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){

                },
              )
          );
        }
    );
  }
}
