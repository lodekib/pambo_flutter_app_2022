import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_pambo/constants/constant.dart';
import 'package:flutter/foundation.dart';

class MakeupDataProvider with ChangeNotifier{
  Map<String,dynamic> makeupData= {};


  fetchMakeup(context) async{
    makeupData = await getMakeups(context);
    notifyListeners();
  }

  Future<Map<String,dynamic>> getMakeups(context) async{
    String apiUrl = '/makeup/services';
    try{
      final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(response.statusCode == 200){
        makeupData = json.decode(response.body);
        return makeupData;
      }else{
        throw Exception('Not Sure of the issue');
      }
    }catch(e){
      throw Exception(e);
    }
  }

}