import 'package:flutter/material.dart';
import 'package:task_1/Pages/home_page.dart';
import 'package:task_1/Pages/login_page.dart';
import 'package:task_1/Pages/pop_up_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark
      ),

      initialRoute: 'login/',
      routes:{
        'login/':(context)=>const LoginPage(),
        'home/':(context)=>const HomePage(),
        'popup/':(context)=>const PopUpPage(),
      }


    );
  }
}