import 'package:firebase_integration/Pages/setup/welcome.dart';
import 'package:flutter/material.dart';



void main(){
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override 
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title : "Firebase Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
    );
  }
}
