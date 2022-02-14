import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_pambo/constants/constant.dart';
class HairdressingDataProvider with ChangeNotifier{
  Map<String,dynamic> hairdressingData= {};

  fetchHairdressing(context) async{
    hairdressingData = await getHairdressings(context);
    notifyListeners();
  }

  Future<Map<String,dynamic>> getHairdressings(context) async{
    String apiUrl = '/hairdressing/services';
    try{
      final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(response.statusCode == 200){
        hairdressingData = json.decode(response.body);
        return hairdressingData;
      }else{
        throw Exception('Not Sure of the issue');
      }
    }catch(e){
      throw Exception(e);
    }
  }

}