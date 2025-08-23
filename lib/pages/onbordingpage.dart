import 'package:flutter/material.dart';

class Onbordingpage extends StatefulWidget {
  const Onbordingpage({super.key});

  @override
  State<Onbordingpage> createState() => _OnbordingpageState();
}

class _OnbordingpageState extends State<Onbordingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(top: 120.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
        
            colors: [Color.fromARGB(255, 11, 39, 161), Color.fromARGB(255, 16, 10, 112), Color.fromARGB(255, 6, 1, 37)
            ],
            begin: Alignment.topLeft, end: Alignment.topRight
          ),
          

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
          

          Text('DAILY TASK', style: TextStyle(fontSize: 30.0, color: Colors.white),),
          SizedBox(height: 50.0,),
              Text('Welcome Back', style: TextStyle(fontSize: 38.0, color: Colors.white, fontWeight: FontWeight.bold)),
        SizedBox(height: 40.0),
        GestureDetector(
           onTap: () {
            Navigator.pushNamed(context, '/login_page');
            },
          child: Container(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0 ),
            margin: EdgeInsets.only(left: 36.0, right: 36.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white54,
                
              )
              
            ),
            child: Center(child: Text('SIGN IN', style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.w500),)),
          ),
        ),
        SizedBox(height: 40.0,),
        GestureDetector(
           onTap: () {
            Navigator.pushNamed(context, '/signup_page');
            },
          child: Container(
            
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0 ),
            margin: EdgeInsets.only(left: 36.0, right: 36.0),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(30),
             color: Colors.white
              
            ),
            
            child: Center(child: 
            Text('SIGN UP', style: 
            TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w500),)),
          
          ),
        )
        ]),
      ),
      
      
    );
  }
}
