import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/hairdressing_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';
import 'package:provider/provider.dart';

class HairdressinglistScreen extends StatefulWidget {
  const HairdressinglistScreen({Key? key}) : super(key: key);

  @override
  _HairdressinglistScreenState createState() => _HairdressinglistScreenState();
}

class _HairdressinglistScreenState extends State<HairdressinglistScreen> {
  @override
  void initState(){
    final hairdressings = Provider.of<HairdressingDataProvider>(context,listen:false);
    hairdressings.getHairdressings(context);
    super.initState();
  }

  String countHairdressings(dynamic vals ,int index){
    if(vals.elementAt(index).length > 1){
      return vals.elementAt(index).length.toString()+' services';
    }else if(vals.elementAt(index).length == 1){
      return vals.elementAt(index).length.toString()+' service';
    }else{
      return 'No services available';
    }
  }

  List<DataModel> hairdressingsToModel(List<dynamic> hairdressingsToConvert){
    return hairdressingsToConvert.map((frag) => DataModel.fromJson(frag)).toList();
  }



  @override
  Widget build(BuildContext context) {
    final hairdressings = Provider.of<HairdressingDataProvider>(context,listen:false);
    return  ListView.builder(
        itemCount: hairdressings.hairdressingData.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
              color: (index % 2==0)?Colors.white:Colors.grey[100],
              child:ListTile(
                title: Text(hairdressings.hairdressingData.keys.elementAt(index)),
                subtitle:  Text(countHairdressings(hairdressings.hairdressingData.values, index),style: const TextStyle(fontSize: 13),),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async{
                  hairdressings.hairdressingData.values.elementAt(index).length >0 ?
                  await Navigator.push(context,
                      MaterialPageRoute(
                          builder:(_)=>
                              CategoricalViews(
                                  data: hairdressingsToModel(hairdressings.hairdressingData.values.elementAt(index)))))
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
