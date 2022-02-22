import 'package:flutter/material.dart';
import 'package:new_pambo/providers/uploads_provider.dart';
import 'package:new_pambo/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<UploadsDataProvider>(
      create: (_) => UploadsDataProvider(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
