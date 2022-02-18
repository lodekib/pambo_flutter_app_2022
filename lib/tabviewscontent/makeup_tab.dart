import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/makeup_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';
import 'package:provider/provider.dart';


class MakeuplistScreen extends StatelessWidget {


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
    return FutureBuilder(
      future: MakeupDataProvider().getMakeups(context),
        builder: (context,snapshot){
         switch(snapshot.connectionState){
           case ConnectionState.active:
             return const Text('Connection is active');
           case ConnectionState.none:
             return const Text('No connection');
           case ConnectionState.waiting:
             return const SpinKitThreeBounce(
               size: 30,
               color: Constants.pamboprimaryColor,
             );
           case ConnectionState.done:
             Map<String,dynamic> makeups = snapshot.data as Map<String,dynamic> ;
             return  ListView.builder(
                 itemCount: makeups.length,
                 itemBuilder: (BuildContext context, int index){
                   return Card(
                       color: (index % 2==0)?Colors.white:Colors.grey[100],
                       child:ListTile(
                         title: Text(makeups.keys.elementAt(index)),
                         subtitle:  Text(countMakeups(makeups.values, index),style: const TextStyle(fontSize: 13),),
                         trailing: const Icon(Icons.chevron_right),
                         onTap: () async{
                           makeups.values.elementAt(index).length >0 ?
                           await Navigator.push(context,
                               MaterialPageRoute(
                                   builder:(_)=>
                                       CategoricalViews(
                                           subcategory: makeups.keys.elementAt(index),
                                           data: makeupsToModel(makeups.values.elementAt(index)))))
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
    });
  }
}
