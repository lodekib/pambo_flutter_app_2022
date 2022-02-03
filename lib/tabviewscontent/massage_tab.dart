import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';

class MassagelistScreen extends StatefulWidget {
  const MassagelistScreen({Key? key}) : super(key: key);

  @override
  _MassagelistScreenState createState() => _MassagelistScreenState();
}

class _MassagelistScreenState extends State<MassagelistScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Constants.massagelist.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(Constants.massagelist[index]['subcategory'].toString()),
                subtitle: Text(Constants.massagelist[index]['ads'].toString(),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                },
              )
          );
        }
    );
  }
}
