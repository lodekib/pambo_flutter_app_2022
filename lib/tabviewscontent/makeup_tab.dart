import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/makeup_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';
import 'package:provider/provider.dart';

class MakeuplistScreen extends StatefulWidget {
  const MakeuplistScreen({Key? key}) : super(key: key);

  @override
  _MakeuplistScreenState createState() => _MakeuplistScreenState();
}

class _MakeuplistScreenState extends State<MakeuplistScreen> {

  @override
  void initState(){
    final makeups = Provider.of<MakeupDataProvider>(context,listen:false);
    makeups.getMakeups(context);
    super.initState();
  }

  String countMakeups(dynamic vals ,int index){
    if(vals.elementAt(index).length > 1){
      return vals.elementAt(index).length.toString()+' services';
    }else if(vals.elementAt(index).length == 1){
      return vals.elementAt(index).length.toString()+' service';
    }else{
      return 'No services available';
    }
  }

  List<DataModel> makeupsToModel(List<dynamic> makeupsToConvert){
    return makeupsToConvert.map((makeup) => DataModel.fromJson(makeup)).toList();
  }



  @override
  Widget build(BuildContext context) {
    final makeups = Provider.of<MakeupDataProvider>(context,listen: false);
    return  ListView.builder(
        itemCount: makeups.makeupData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(makeups.makeupData.keys.elementAt(index)),
                subtitle:  Text(countMakeups(makeups.makeupData.values, index),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async{
                  makeups.makeupData.values.elementAt(index).length >0 ?
                  await Navigator.push(context,
                      MaterialPageRoute(
                          builder:(_)=>
                              CategoricalViews(
                                  data: makeupsToModel(makeups.makeupData.values.elementAt(index)))))
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
