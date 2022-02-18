import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:new_pambo/constants/constant.dart';
class MassageDataProvider {


  Future<Map<String,dynamic>> getMassages(context) async{
    String apiUrl = '/massage/services';
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