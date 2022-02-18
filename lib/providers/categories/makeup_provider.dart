import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_pambo/constants/constant.dart';
import 'package:flutter/foundation.dart';

class MakeupDataProvider{

  Future<Map<String,dynamic>> getMakeups(context) async{
    String apiUrl = '/makeup/services';
    try{
      final response = await http.get(Uri.parse(Constants.baseUrl+apiUrl));
      if(response.statusCode == 200){
        return json.decode(response.body);
      }else{
        throw Exception('Not Sure of the issue');
      }
    }catch(e){
      throw Exception(e);
    }
  }

}