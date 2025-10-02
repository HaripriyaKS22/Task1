import 'dart:math';

import 'package:flutter/material.dart';

class PopUpPage extends StatefulWidget {
  const PopUpPage({super.key});

  @override
  State<PopUpPage> createState() => _PopUpPageState();
}
List<String> projects=['Project1','Project2','Project3'];
String? Selectedproject;

List<String> Gates=['Gate1','Gate2'];
String? Selectedgate;
String? workType; 
class _PopUpPageState extends State<PopUpPage> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text(
                  "Check-in",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const Text(
                      "Select Check-in Type",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
            AlertDialog(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: const Color.fromARGB(255, 203, 203, 203), width: .5),
              ),  
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    const SizedBox(height: 10),
                    Container(
                      width: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color.fromARGB(203, 255, 255, 255)),
                ),
                child: Column(
                  children: const [
                    Text("👷‍♂️", style: TextStyle(fontSize: 36)),
                    SizedBox(height: 8),
                    Text("Worker",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
                const SizedBox(height: 10),
        
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: .5), 
                    borderRadius: BorderRadius.circular(12), 
                  ),
                  child: DropdownButton<String>(
                    value: Selectedproject,
                    hint: const Text("Project"),
                    isExpanded: true, 
                    underline: const SizedBox(), 
                    onChanged: (val) => setState(() => Selectedproject = val),
                    items: projects
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 10),
                  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 255, 255, 255),width: .5),
                    borderRadius: BorderRadius.circular(12)
                  ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: const SizedBox(),
                      value: Selectedgate,
                      hint: const Text("Gate"),
                      onChanged: (value) => setState(() {
                        Selectedgate=value;  
                      }),
                      items: Gates.map((e)=>DropdownMenuItem(value: e ,child: Text(e))).toList()
                      
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text("Select Work Type",style: TextStyle(color: Colors.white70, fontSize: 14),),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(child:
                      RadioListTile(value: "Budget",groupValue: workType,
                      onChanged: (value) {
                        setState(() {
                          workType=value;
                        });
                      },
                      title: Text("Budget",style: TextStyle(color:Colors.white),),
                      activeColor: Color(0xFFD2815E),
                      contentPadding: EdgeInsets.zero,
                      
                
                      )
                      ),
                      Expanded(child: RadioListTile(value: "Issue",groupValue: workType,
                      onChanged: (value) {
                        setState(() {
                          workType=value;
                        });
                      },
                      title: Text("Issue",style: TextStyle(color:Colors.white),),
                      activeColor: Color(0xFFD2815E),
                      contentPadding: EdgeInsets.zero,
                      ))
        
        
                    ],
        
                  ),
        
        
        
                  
        
                   ElevatedButton(
                     onPressed: () {
                     
                   
                             },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Color(0xFFD2815E),
                       minimumSize: const Size(double.infinity, 50),
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),
                     ),
                     child: const Text(
                       "Check-in",
                       style: TextStyle(fontSize: 15, color: Colors.white),
                     ),
                   ),
                  ],
            
            
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}