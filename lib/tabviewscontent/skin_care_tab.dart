import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/skincare_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';
import 'package:provider/provider.dart';

class SkincarelistScreen extends StatefulWidget {
  const SkincarelistScreen({Key? key}) : super(key: key);

  @override
  _SkincarelistScreenState createState() => _SkincarelistScreenState();
}

class _SkincarelistScreenState extends State<SkincarelistScreen> {
  @override
  void initState(){
    final skincare = Provider.of<SkincareDataProvider>(context,listen:false);
    skincare.getSkincare(context);
    super.initState();
  }

  String countSkincares(dynamic vals ,int index){
    if(vals.elementAt(index).length > 1){
      return vals.elementAt(index).length.toString()+' services';
    }else if(vals.elementAt(index).length == 1){
      return vals.elementAt(index).length.toString()+' service';
    }else{
      return 'No services available';
    }
  }

  List<DataModel> skincareToModel(List<dynamic> skincareToConvert){
    return skincareToConvert.map((skincare) => DataModel.fromJson(skincare)).toList();
  }



  @override
  Widget build(BuildContext context) {
    final skincare = Provider.of<SkincareDataProvider>(context,listen: false);
    return  ListView.builder(
        itemCount: skincare.skincareData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(skincare.skincareData.keys.elementAt(index)),
                subtitle:  Text(countSkincares(skincare.skincareData.values, index),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async{
                  skincare.skincareData.values.elementAt(index).length >0 ?
                  await Navigator.push(context,
                      MaterialPageRoute(
                          builder:(_)=>
                              CategoricalViews(
                                  data: skincareToModel(skincare.skincareData.values.elementAt(index)))))
                      :ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                          backgroundColor: Constants.pamboprimaryColor,
                          content: Text('No services')
                      )
                  );
                },
              )
          );
        }
    );
  }
}
