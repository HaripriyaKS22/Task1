import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/Pages/pop_up_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
Timer? _timer;
bool isRunning = false;
Duration _duration = const Duration(seconds: 1);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

String _timerString = "00:00:00";
  @override
  void initState() {
    super.initState();
    initdata();
    print('HomePage initState called$_duration');
   

  }

  void initdata() async {
   await fetchuserData();

    if(isChecked){
      print('isChecked found true in SharedPreferences');
      print('isChecked is true, starting timer');
          await startTimer();
     setState(() {
      isRunning = isChecked;
      });
    }
    else{
      print('isChecked is false, not starting timer');}
     
  }
 

 Future<void> startTimer() async {
    _timer = Timer.periodic(_duration, (timer) {
      setState(() {
        final hours = timer.tick ~/ 3600;
        final minutes = (timer.tick % 3600) ~/ 60;
        final seconds = timer.tick % 60;
        _timerString =
            '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      });
    });
  }


 String? firstName;
  String? lastName;
  late bool isChecked;
   String? button;
  Future<void> fetchuserData() async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
     firstName = prefs.getString('firstName');
     lastName = prefs.getString('lastName');
      isChecked = prefs.getBool('isChecked') ?? false;

    print('Fetched username: $username');
    print('Fetched firstName: $firstName');
    print('Fetched lastName: $lastName');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
  appBar: PreferredSize(
  preferredSize: const Size.fromHeight(450),
  child: AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color.fromARGB(255, 251, 221, 214)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.black),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.download, color: Colors.black),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                
                 Row(
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 13,right: 13),
                       child: AnimatedTextKit(
                        animatedTexts: [
                          if (firstName != null && lastName != null)
                          TypewriterAnimatedText(
                            '$firstName $lastName',
                            speed: Duration(milliseconds: 140),
                            cursor: '|',textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ],
                        totalRepeatCount: 1, 
                        pause: Duration(milliseconds: 800),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                                     ),
                     ),
                     Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('lib/assets/profile.png'),
                                          ),
                      ),
                    
                   ],
                 ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    DateFormat('EEEE, d MMM').format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(121, 18, 18, 18),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height:10),
                        Text("Working Hours",style: TextStyle(fontSize: 14,color: Colors.white),),
                        const SizedBox(height:5),
                        Text("$_timerString Hrs",style: TextStyle(fontSize: 25,color: Colors.white),),
                      ],
                    )
                  ),
                ),
               

                Padding(

                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    onPressed: () {

                    if (isChecked) {
                      setState(() {
                        isRunning = false;
                        isChecked = false;
                        _timerString = "00:00:00";
                        _timer?.cancel();

                      });
                      null;
                    }
                    else{
                      Navigator.pushNamed(context, 'popup/');}
            
                            },
                    style: ElevatedButton.styleFrom(
                      
                      backgroundColor: Color(0xFFD2815E),
                      disabledBackgroundColor: Colors.grey,

                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:  Text(
                      isRunning ? "Checked-Out" :
                      "Manul Check-in",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    ),
  ),
),
     
   
bottomNavigationBar: Container(
  decoration: const BoxDecoration(
    color: Colors.black,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    border: Border(
      top: BorderSide(
        color: Colors.grey, 
        width: .5,
      ),
    ),
  ),
  child: ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black,
      selectedItemColor: Color(0xFFD2815E),
      unselectedItemColor: Colors.white,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.edit_document), // notebook style icon
          label: 'Activites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.work_outline),
          label: 'Jobs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_outlined),
          label: 'Notification',
        ),
      ],
    ),
  ),
),



);

  }
}