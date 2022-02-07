import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_pambo/providers/categories/fragrance_provider.dart';
import 'package:provider/provider.dart';


class FragrancelistScreen extends StatefulWidget {
  const FragrancelistScreen({Key? key}) : super(key: key);

  @override
  _FragrancelistScreenState createState() => _FragrancelistScreenState();
}

class _FragrancelistScreenState extends State<FragrancelistScreen> {

  @override
  void initState(){
    final frags = Provider.of<FragranceDataProvider>(context,listen:false);
    frags.getFrags(context);
    super.initState();
  }
  
  String countFrags(dynamic vals ,int index){
    if(vals.elementAt(index).length > 1){
       return vals.elementAt(index).length.toString()+' services';
    }else if(vals.elementAt(index).length == 1){
      return vals.elementAt(index).length.toString()+' service';
    }else{
      return 'No services available';
    }
  }



  @override
  Widget build(BuildContext context) {
    final frags = Provider.of<FragranceDataProvider>(context);
        return  ListView.builder(
            itemCount: frags.fragranceData.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                  color: (index % 2==0)?Colors.white:Colors.grey[100],
                  child:ListTile(
                     title: Text(frags.fragranceData.keys.elementAt(index)),
                    subtitle:  Text(countFrags(frags.fragranceData.values, index),style: const TextStyle(fontSize: 13),),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: (){

                    },
                  )
              );
            }
        );
  }

}
