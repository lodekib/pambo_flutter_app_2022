import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:new_pambo/cubit/app_cubit_states.dart';
import 'package:new_pambo/model/data_model.dart';
import 'package:new_pambo/services/data_services.dart';

class AppCubits extends Cubit<CubitStates>{
  AppCubits({required this.data}) : super(InitialState()) {
    emit(LoadingState());
  }

  final DataServices data;
  late final uploads;
  late final fragrances;

  void getData()async{
    try{
       uploads = await data.getInfo();
       emit(LoadedState(uploads));
       print('LoadedState emitted.....');
    }catch(e){
       if (kDebugMode) {
         print(e);
       }
    }
  }

  detailPage(DataModel data){
    emit(DetailState(data));
  }

  goHome(){
    emit(LoadedState(uploads));
  }

  void getFragrance(){
    try{
      fragrances = data.getFragrance();
      emit(FragranceState(fragrances));
      print('FragranceState emitted....');
    }catch(e){
      if(kDebugMode){
        print(e);
      }
    }
  }


}