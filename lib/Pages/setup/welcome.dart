import 'package:firebase_integration/Pages/setup/signIn.dart';
import 'package:firebase_integration/Pages/setup/signup.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
@override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to the Helpline Portal",style: TextStyle(color: Colors.blue[200],fontSize: 25.0,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
        

        Image.network('http://www.cdot.in/cdotweb/assets/img/cdot_logo.png',height: 300,width: 350,),

        Padding(
          padding: EdgeInsets.all(20.0),

        ),


         
        RaisedButton(
          onPressed: navigateToSignIn ,
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: const EdgeInsets.only(left: 70.0,top: 8.0,bottom: 8.0,right: 70.0),
            child: Text("Sign In",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),),
          ),
       ),
           
            FlatButton(
              color: Colors.white,
              child: Text("Don't Have an Account ? ",style:TextStyle(color: Colors.black,fontSize: 25.0,fontWeight: FontWeight.bold)),
              onPressed: (){},
            ),

            RaisedButton(
          onPressed: navigateToSignUp ,
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: const EdgeInsets.only(left: 60.0,top: 8.0,bottom: 8.0,right: 60.0),
            child: Text("Sign Up",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,color: Colors.white),),
          ),
       ),






            
         
        ],
      ),
      ),
      
    );
  }


  void navigateToSignIn(){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage(),fullscreenDialog: true));



  }

  void navigateToSignUp(){
  
  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage(),fullscreenDialog: true));

    
  }
}