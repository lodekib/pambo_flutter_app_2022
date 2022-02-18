import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/jewelerry_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';
import 'package:provider/provider.dart';

class JewellerylistScreen extends StatelessWidget {

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
    return FutureBuilder(
      future: JewelerryDataProvider().getJewels(context),
        builder: (context,snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return const Icon(Icons.hourglass_empty);
            case ConnectionState.active:
              return const Text('Connection active');
            case ConnectionState.waiting:
              return  const SpinKitThreeBounce(
                color: Constants.pamboprimaryColor,
                size: 30,
              );
            case ConnectionState.done:
              Map<String,dynamic> jewels = snapshot.data  as Map<String,dynamic>;
              return  ListView.builder(
                      itemCount: jewels.length,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                            color: (index % 2==0)?Colors.white:Colors.grey[100],
                            child:ListTile(
                              title: Text(jewels.keys.elementAt(index)),
                              subtitle:  Text(countJewels(jewels.values, index),style: const TextStyle(fontSize: 13),),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () async{
                                jewels.values.elementAt(index).length >0 ?
                                await Navigator.push(context,
                                    MaterialPageRoute(
                                        builder:(_)=>
                                            CategoricalViews(
                                              subcategory: jewels.keys.elementAt(index),
                                                data: jewelsToModel(jewels.values.elementAt(index)))))
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
