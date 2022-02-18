import 'dart:convert';
import 'package:new_pambo/constants/constant.dart';
import 'package:http/http.dart' as http;

class FragranceDataProvider{
  Map<String,dynamic> fragranceData= {};


  Future<Map<String,dynamic>> fetchFrags(context) async{
    String apiUrl = '/fragrance/services';
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