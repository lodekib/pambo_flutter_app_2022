import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:http/http.dart' as http;
import 'package:new_pambo/model/data_model.dart';
class FragranceDataProvider with ChangeNotifier{
  Map<String,dynamic> fragranceData= {};


  fetchFragrances(context) async{
    fragranceData = await getFrags(context);
    notifyListeners();
  }

  Future<Map<String,dynamic>> getFrags(context) async{
    String apiUrl = '/fragrance/services';
    try{
      final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(response.statusCode == 200){
       fragranceData = json.decode(response.body);
       return fragranceData;
      }else{
        throw Exception('Not Sure of the issue');
      }
    }catch(e){
      throw Exception(e);
    }
  }

}