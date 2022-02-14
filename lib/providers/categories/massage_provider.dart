import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:new_pambo/constants/constant.dart';
class MassageDataProvider with ChangeNotifier{
  Map<String,dynamic> massageData= {};


  fetchMassages(context) async{
    massageData = await getMassages(context);
    notifyListeners();
  }

  Future<Map<String,dynamic>> getMassages(context) async{
    String apiUrl = '/massage/services';
    try{
      final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(response.statusCode == 200){
        massageData = json.decode(response.body);
        return massageData;
      }else{
        throw Exception('Not Sure of the issue');
      }
    }catch(e){
      throw Exception(e);
    }
  }

}