import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';

class SkincarelistScreen extends StatefulWidget {
  const SkincarelistScreen({Key? key}) : super(key: key);

  @override
  _SkincarelistScreenState createState() => _SkincarelistScreenState();
}

class _SkincarelistScreenState extends State<SkincarelistScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Constants.skincareList.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(Constants.skincareList[index]['subcategory'].toString()),
                subtitle: Text(Constants.skincareList[index]['ads'].toString(),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){

                },
              )
          );
        }
    );
  }
}
