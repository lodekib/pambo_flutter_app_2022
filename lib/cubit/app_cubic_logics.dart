import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pambo/cubit/app_cubit_states.dart';
import 'package:new_pambo/screens/home_screen.dart';
import 'package:new_pambo/screens/loading_screen.dart';
import 'app_cubits.dart';

class AppCubitLogic extends StatefulWidget {
  const AppCubitLogic({Key? key}) : super(key: key);

  @override
  _AppCubitLogicState createState() => _AppCubitLogicState();
}

class _AppCubitLogicState extends State<AppCubitLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BlocBuilder<AppCubits,CubitStates>(
        builder: (context,state){
         if(state is LoadingState){
             return const LoadingScreen();
          }if(state is LoadedState){
            return  const HomeScreen();
         }else{
           return const Center(child:Text('No state encountered'));
         }
        },
      )
    );
  }
}
