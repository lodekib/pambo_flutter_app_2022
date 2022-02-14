import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:new_pambo/constants/constant.dart';

class SkincareDataProvider with ChangeNotifier{
  Map<String,dynamic> skincareData= {};


  fetchFragrances(context) async{
    skincareData = await getSkincare(context);
    notifyListeners();
  }

  Future<Map<String,dynamic>> getSkincare(context) async{
    String apiUrl = '/skincare/services';
    try{
      final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(response.statusCode == 200){
        skincareData = json.decode(response.body);
        return skincareData;
      }else{
        throw Exception('Not Sure of the issue');
      }
    }catch(e){
      throw Exception(e);
    }
  }

}