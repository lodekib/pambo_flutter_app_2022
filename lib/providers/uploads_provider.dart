import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:http/http.dart' as http;
class UploadsDataProvider with ChangeNotifier{
    List<DataModel> dataModel= [];


fetchData(context) async{
dataModel = await getData(context);
notifyListeners();
}

Future<List<DataModel>> getData(context) async{
  String apiUrl = '/all/services';
  try{
     final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
     if(response.statusCode == 200){
       List<dynamic> data = json.decode(response.body);
       print(data);
        return data.map((datum) => DataModel.fromJson(datum)).toList();
     }else{
        throw Exception('Not Sure of the issue');
     }
  }catch(e){
    print(e.toString());
     throw Exception(e);
  }
}

}
