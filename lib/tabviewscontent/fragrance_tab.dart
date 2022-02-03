import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';


class FragrancelistScreen extends StatefulWidget {
  const FragrancelistScreen({Key? key}) : super(key: key);

  @override
  _FragrancelistScreenState createState() => _FragrancelistScreenState();
}

class _FragrancelistScreenState extends State<FragrancelistScreen> {
  @override
  Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: Constants.fragrancesubcategory.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                  color: (index % 2==0)?Colors.white:Colors.grey[100],
                  child:ListTile(
                    title: Text(Constants.fragrancesubcategory[index]['subcategory'].toString()),
                    subtitle:  Text(Constants.fragrancesubcategory[index]['ads'].toString(),style: const TextStyle(fontSize: 13),),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: (){
                    },
                  )
              );
            }
        );
  }

}
