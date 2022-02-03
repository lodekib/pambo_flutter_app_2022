import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';

class HairdressinglistScreen extends StatefulWidget {
  const HairdressinglistScreen({Key? key}) : super(key: key);

  @override
  _HairdressinglistScreenState createState() => _HairdressinglistScreenState();
}

class _HairdressinglistScreenState extends State<HairdressinglistScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Constants.hairdressingsubcategory.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(Constants.hairdressingsubcategory[index]['subcategory'].toString()),
                subtitle: Text(Constants.hairdressingsubcategory[index]['ads'].toString(),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                },
              )
          );
        }
    );
  }
}
