import 'package:flutter/cupertino.dart';
import 'package:new_pambo/services/data_services.dart';
class UploadsDataProvider with ChangeNotifier{
var uploads;
bool loading = false;

DataServices dataServices= DataServices();


getUploads(context) async{
  loading =  true;
  uploads = await dataServices.getInfo();
  print("INSIDE PROVIDER");
  print(uploads);
  print('INSIDE PROVIDER');
  loading =  false;
  notifyListeners();
}



}
