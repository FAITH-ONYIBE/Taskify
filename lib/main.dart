import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:to_do_app/pages/login_page.dart';
import 'package:to_do_app/theme/themeprovider.dart';
import 'package:to_do_app/to_do_app.dart';
import 'pages/registerpage.dart';
import 'pages/onbordingpage.dart';
import 'pages/signup_page.dart';

void main() {

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

   runApp(
    ChangeNotifierProvider(
      create: (_) => Themeprovider(),
      child: const TodoList(),
    ),);
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});
  @override
  Widget build(BuildContext context) {
     final themeProvider = Provider.of<Themeprovider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
         theme: themeProvider.themeData,
      // theme: ThemeData(primaryColor: Colors.lightBlue,
      //   fontFamily: 'Roboto',
      //   scaffoldBackgroundColor: Color(0xFFF3F5FF), 
      // ),

      home: Onbordingpage(),
      routes: {
        '/login_page': (context) => LoginPage(),
        '/signup_page': (context) => SignupPage(),
        // '/to_do_app':(context) => ToDoApp(user: 'user'),
        '/registerpage': (context) => Registerpage()
      },
    );
  }
}
