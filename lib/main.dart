import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:regi_sim_v2/home_activity.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeActivity(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.amberAccent
        
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: const Color.fromARGB(255, 250, 249, 244)
      ),
      scaffoldBackgroundColor: const Color.fromARGB(255, 245, 243, 220)
    ),
    );
    
  }
}
