import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:new_pambo/constants/constant.dart';
class BraidswigsDataProvider with ChangeNotifier{
  Map<String,dynamic> braidswigsData= {};


  fetchBraidsWigs(context) async{
    braidswigsData = await getBraidsWigs(context);
    notifyListeners();
  }

  Future<Map<String,dynamic>> getBraidsWigs(context) async{
    String apiUrl = '/braids&wigs/services';
    try{
      final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(response.statusCode == 200){
        braidswigsData = json.decode(response.body);
        return braidswigsData;
      }else{
        throw Exception('Not Sure of the issue');
      }
    }catch(e){
      throw Exception(e);
    }
  }

}