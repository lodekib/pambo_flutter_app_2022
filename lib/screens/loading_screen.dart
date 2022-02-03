import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pambo/constants/constant.dart';
import 'package:new_pambo/cubit/app_cubits.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState(){
    context.read<AppCubits>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      backgroundColor: Constants.pamboprimaryColor,
      body: Center(
           child: CircularProgressIndicator(
              color: Constants.pamboscaffoldColor,
              strokeWidth: 1.0,

        ),
      ),
    );
  }
}
