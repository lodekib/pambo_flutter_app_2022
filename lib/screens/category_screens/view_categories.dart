import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
class CategoricalViews extends StatelessWidget {
 final List<DataModel> data;
 const CategoricalViews({Key? key,required this.data}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor: Constants.pamboprimaryColor,
      ),
      body:ListView.builder(
        itemCount: data.length,
          itemBuilder: (context,index){
            return Text(data[index].sponsorship);
          })
    );

  }
}
