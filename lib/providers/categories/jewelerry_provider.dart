import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:http/http.dart' as http;
class JewelerryDataProvider with ChangeNotifier{
  Map<String,dynamic> jewelerryData= {};


  fetchJewelerry(context) async{
    jewelerryData = await getJewels(context);
    notifyListeners();
  }

  Future<Map<String,dynamic>> getJewels(context) async{
    String apiUrl = '/jewelerry/services';
    try{
      final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(response.statusCode == 200){
        jewelerryData = json.decode(response.body);
        print(jewelerryData);
        return jewelerryData;
      }else{
        throw Exception('Not Sure of the issue');
      }
    }catch(e){
      throw Exception(e);
    }
  }

}