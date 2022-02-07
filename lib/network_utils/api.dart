import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:new_pambo/constants/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Network{
  var token;

  _getToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token')!)['token'];
  }

  authData(data,apiUrl) async{
    return await http.post(
        Uri.parse(Constants.baseUrl+apiUrl),
        body: jsonDecode(data),
      headers: _setHeaders()
    );
  }

  getData(apiUrl) async{
    await _getToken();
    return await http.get(
        Uri.parse(Constants.baseUrl+apiUrl),
      headers: _setHeaders()
    );
  }

  _setHeaders()=>{
    'Content-Type':'application/json',
    'Accept':'application/json',
    'Authorization':'Bearer $token'
  };
}