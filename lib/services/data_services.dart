import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/model/data_model.dart';
class DataServices{


  Future<List<DataModel>>getInfo()async{
    String apiUrl = '/all/services';
    try{
      http.Response res = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(res.statusCode == 200){
        List<dynamic> list = json.decode(res.body);
        return list.map((e)=>DataModel.fromJson(e)).toList();
      }else{
        return <DataModel>[];
      }

    }catch(e){
    print(e);
    return  <DataModel>[];
    }
  }

   Future<List<dynamic>>getFragrance() async{
    String apiUrl = '/fragrance/services';
    try{
      http.Response res = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      var fragList = json.decode(res.body);
      if(kDebugMode){
        print(fragList);
      }
      return fragList;
    }catch(e){
      if(kDebugMode){
        print(e);
      }
      return [];

    }
  }

}