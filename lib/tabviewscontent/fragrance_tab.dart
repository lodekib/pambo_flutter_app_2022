import 'package:flutter/material.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/providers/categories/fragrance_provider.dart';
import 'package:new_pambo/screens/category_screens/view_categories.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';


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

  List<DataModel> fragsToModel(List<dynamic> fragsToConvert){
    return fragsToConvert.map((frag) => DataModel.fromJson(frag)).toList();
  }



  @override
  Widget build(BuildContext context) {
    final frags = Provider.of<FragranceDataProvider>(context,listen: false);
        return  frags.fragranceData.isNotEmpty ? ListView.builder(
            itemCount: frags.fragranceData.length,
            itemBuilder: (BuildContext context, int index){
              return Card(
                  color: (index % 2==0)?Colors.white:Colors.grey[100],
                  child:ListTile(
                     title: Text(frags.fragranceData.keys.elementAt(index)),
                    subtitle:  Text(countFrags(frags.fragranceData.values, index),style: const TextStyle(fontSize: 13),),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async{
                       frags.fragranceData.values.elementAt(index).length >0 ?
                        await Navigator.push(context,
                            MaterialPageRoute(
                                builder:(_)=>
                                    CategoricalViews(
                                        data: fragsToModel(frags.fragranceData.values.elementAt(index)))))
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
        ): Shimmer.fromColors(
          baseColor: Colors.white60,
          highlightColor: Colors.white54,
          enabled: true,
          child: ListView.builder(
            itemBuilder: (_, __) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 15.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                        Container(
                          width: double.infinity,
                          height: 8.0,
                          color: Colors.white,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.0),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            itemCount: 10,
          ),
        );
  }

}
