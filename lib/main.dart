import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  void initState() {
  super.initState();
  cleanup();

}
  Future<void> cleanup() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('username');
    await prefs.remove('firstName');
    await prefs.remove('lastName');
    await prefs.remove('isChecked');
    print('Cleaned up stored user data.');
  }


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