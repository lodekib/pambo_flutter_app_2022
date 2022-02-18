import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/skincare_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';


class SkincarelistScreen extends StatelessWidget {

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
    return FutureBuilder(
        future: SkincareDataProvider().getSkincare(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              return const Text('Connection active');
            case ConnectionState.none:
              return const Text('No connection made');
            case ConnectionState.waiting:
              return const SpinKitThreeBounce(
                size: 30,
                color: Constants.pamboprimaryColor,
              );
            case ConnectionState.done:
              Map<String, dynamic> skincare = snapshot.data as Map<
                  String,
                  dynamic>;
               return  ListView.builder(
              itemCount: skincare.length,
              itemBuilder: (BuildContext context, int index){
                return Card(
                    color: (index % 2==0)?Colors.white:Colors.grey[100],
                    child:ListTile(
                      title: Text(skincare.keys.elementAt(index)),
                      subtitle:  Text(countSkincares(skincare.values, index),style: const TextStyle(fontSize: 13),),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async{
                        skincare.values.elementAt(index).length >0 ?
                        await Navigator.push(context,
                            MaterialPageRoute(
                                builder:(_)=>
                                    CategoricalViews(
                                        subcategory: skincare.keys.elementAt(index),
                                        data: skincareToModel(skincare.values.elementAt(index)))))
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
    );
  }
}
