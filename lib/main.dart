import 'package:flutter/material.dart';
import 'package:new_pambo/providers/categories/braidswigs_provider.dart';
import 'package:new_pambo/providers/categories/fragrance_provider.dart';
import 'package:new_pambo/providers/categories/hairdressing_provider.dart';
import 'package:new_pambo/providers/categories/jewelerry_provider.dart';
import 'package:new_pambo/providers/categories/makeup_provider.dart';
import 'package:new_pambo/providers/categories/massage_provider.dart';
import 'package:new_pambo/providers/categories/skincare_provider.dart';
import 'package:new_pambo/providers/uploads_provider.dart';
import 'package:new_pambo/screens/home_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UploadsDataProvider>(create: (_)=>UploadsDataProvider(),),
        ChangeNotifierProvider<FragranceDataProvider>(create: (_)=>FragranceDataProvider(),),
        ChangeNotifierProvider<JewelerryDataProvider>(create: (_)=>JewelerryDataProvider(),),
        ChangeNotifierProvider<MakeupDataProvider>(create: (_)=>MakeupDataProvider(),),
        ChangeNotifierProvider<SkincareDataProvider>(create: (_)=>SkincareDataProvider(),),
        ChangeNotifierProvider<MassageDataProvider>(create: (_)=>MassageDataProvider(),),
        ChangeNotifierProvider<HairdressingDataProvider>(create:(_)=>HairdressingDataProvider()),
        ChangeNotifierProvider<BraidswigsDataProvider>(create: (_)=>BraidswigsDataProvider(),),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomeScreen(),
    );

  }
}