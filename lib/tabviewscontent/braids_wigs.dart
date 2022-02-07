import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';

class BraidswigslistScreen extends StatefulWidget {
  const BraidswigslistScreen({Key? key}) : super(key: key);

  @override
  _BraidswigslistScreenState createState() => _BraidswigslistScreenState();
}

class _BraidswigslistScreenState extends State<BraidswigslistScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Constants.braidwigslist.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(Constants.braidwigslist[index]['subcategory'].toString()),
                subtitle: Text(Constants.braidwigslist[index]['ads'].toString(),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: (){
                },
              )
          );
        }
    );
  }
}
