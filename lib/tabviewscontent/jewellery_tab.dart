import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/jewelerry_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';
import 'package:provider/provider.dart';

class JewellerylistScreen extends StatefulWidget {
  const JewellerylistScreen({Key? key}) : super(key: key);

  @override
  _JewellerylistScreenState createState() => _JewellerylistScreenState();
}

class _JewellerylistScreenState extends State<JewellerylistScreen> {

  @override
  void initState(){
    final jewels = Provider.of<JewelerryDataProvider>(context,listen:false);
    jewels.getJewels(context);
    super.initState();
  }

  String countJewels(dynamic vals ,int index){
    if(vals.elementAt(index).length > 1){
      return vals.elementAt(index).length.toString()+' services';
    }else if(vals.elementAt(index).length == 1){
      return vals.elementAt(index).length.toString()+' service';
    }else{
      return 'No services available';
    }
  }

  List<DataModel> jewelsToModel(List<dynamic> jewelsToConvert){
    return jewelsToConvert.map((jewelerry) => DataModel.fromJson(jewelerry)).toList();
  }



  @override
  Widget build(BuildContext context) {
    final jewels = Provider.of<JewelerryDataProvider>(context,listen: false);
    return  ListView.builder(
        itemCount: jewels.jewelerryData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(jewels.jewelerryData.keys.elementAt(index)),
                subtitle:  Text(countJewels(jewels.jewelerryData.values, index),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async{
                  jewels.jewelerryData.values.elementAt(index).length >0 ?
                  await Navigator.push(context,
                      MaterialPageRoute(
                          builder:(_)=>
                              CategoricalViews(
                                  data: jewelsToModel(jewels.jewelerryData.values.elementAt(index)))))
                      :ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          duration: Duration(seconds: 1),
                          backgroundColor: Constants.pamboprimaryColor,
                          content: Text('No services')));
                },
              )
          );
        }
    );
  }
}
