import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final TextEditingController _username = TextEditingController();
  final TextEditingController _passcode = TextEditingController();
     bool rememberMe = false; 

var url = 'https://dummyjson.com/auth/login'; 

Future login(String username, String password, BuildContext context) async {
  print('Login function called with username: $username and password: $password');
  try {
    var response = await http.post(
      Uri.parse(url),
      body: {
        "username": username, "password": password
        },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Login successful');
      var responseData = jsonDecode(response.body);
       String accessToken = responseData['accessToken'];
       String username = responseData['username'];
       String firstname =responseData['firstName'];
       String lastname =responseData['lastName'];
         final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accessToken', accessToken);
        await prefs.setString('username', username);  
        await prefs.setString('firstName', firstname);
        await prefs.setString('lastName', lastname);
       Navigator.pushNamed(context, 'home/');
      print('Login successful. Access Token: $accessToken');
     
    } else {
      print('Login failed with status: ${response.statusCode}');
      String errorMessage = 'An error occurred. Please try againnnnnnn.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(errorMessage)),
      );
    }
  } catch (e) {
    print('An exception occurred: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.red, content: Text('An error occurred. Please try again.')),
    );
  }
}



  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
    icon: const Icon(Icons.keyboard_arrow_left),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 35,right: 35,top: 80),
          child: Column(
            children: [
              const Text("Login",style: TextStyle(fontSize: 30,color: Color(0xFFD2815E)),),
              const SizedBox(height: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome back to your account",style: TextStyle(fontSize: 15),),
              ],
            ),
              const SizedBox(height: 20,
            ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("username",style: TextStyle(fontSize: 12),),
                ],
              ),
              const SizedBox(height: 10,),
              TextField(
                decoration:InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.orange,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10), 
                  )
                ),
                controller: _username,
        
              ),
              const SizedBox(height: 10,),
              const Row(
                children: [
                  Text(
                    "Passcode",style: TextStyle(fontSize: 12),
                  )
                ],
              ),
              const SizedBox(height: 10,),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // OtpTextField(
                  //   numberOfFields: 4,
                  //   borderColor: Color(0xFFD2815E),
                  //   showFieldAsBox: true,
                  //   borderWidth: 1.0,
                  //   fieldHeight: 45,
                  //   fieldWidth: 45,
                  //   textStyle: const TextStyle(fontSize: 10),
                  //   onCodeChanged: (String code) {
                  //   },
                    
                  // ),
                  Expanded(
                    child: TextField(
                      controller: _passcode,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10), 
                        )
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
               mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(value: rememberMe,onChanged: (bool? value) {

                  setState(() {

                    rememberMe = value ?? false;
                  });
                  },),
                  Text("Remember me",style: TextStyle(color: Colors.white),),
                  Spacer(),
                  Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFD2815E),
                            width: 1, 
                          ),
                        ),
                      ),
                      child: const Text(
                        "Forgot Passcode?",
                        style: TextStyle(color: Color(0xFFD2815E)),
                      ),
                    )

                ],
              ),
              const SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                login(_username.text, _passcode.text, context);
                // Navigator.pushNamed(context, 'home/');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFD2815E),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              )
              , child: const Text("Login",style: TextStyle(fontSize: 15,color: Colors.white),)),

              const SizedBox(height: 20,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(fontSize: 12),),
                  SizedBox(width: 5,),
                  Text("Register",style: TextStyle(fontSize: 12,color: Color(0xFFD2815E)),)
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}