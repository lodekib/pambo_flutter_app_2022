import 'package:flutter/material.dart';
import 'package:new_pambo/providers/uploads_provider.dart';
import 'package:new_pambo/screens/home_screen.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UploadsDataProvider>(create: (_)=>UploadsDataProvider(),),

      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );

  }
}