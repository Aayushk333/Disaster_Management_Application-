import 'package:firebase_integration/Pages/home.dart';
import 'package:firebase_integration/Pages/setup/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget{
  @override 
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
String _email,_password;   //underscore is used to mark the variables as private in dart language
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override 
  Widget build (BuildContext context ){
    return Scaffold(
      appBar: AppBar(
        title:Text("Sign In Page"),
        backgroundColor: Colors.black,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network('http://www.cdot.in/cdotweb/assets/img/cdot_logo.png',height: 100,width: 550,),
              TextFormField(
                validator:(input){
                  if(input.isEmpty)
                    return "Please type your email";
                  else
                    return null;
                } ,
                onSaved: (input){
                  _email=input;
                },
                decoration: InputDecoration(
                  labelText: "Email",

                )
                 ,),
                TextFormField(
                validator:(input){
                  if(input.length < 6)
                  return "Your password needs to be atleast 6 characters";
                  else if(input.isEmpty)
                  return "Please enter the password";
                  else 
                  return null;
                } ,
                onSaved: (input){
                  _password=input;
                  
                },
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                 ),
                 SizedBox(height: 0.0,),
                 Container(
                   alignment: Alignment(0.85, 0.0),
                   padding: EdgeInsets.only(top: 15.0,left: 15.0),
                   child: InkWell(
                     child: Text('Forgot Password',style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 15.0),),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPassword()));
                     },
                     
                   ),
                 ),
                 SizedBox(height: 12.0),
                 Container(
                   height: 40.0,
                   child: Material(
                     borderRadius: BorderRadius.circular(50.0),
                     shadowColor: Colors.blueAccent,
                     color: Colors.blue[900],
                     elevation: 7.0,
                     child: GestureDetector(
                       onTap: (){signIN();},
                       child: Center(
                         child: Text('SIGN IN',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                       ),
                     ),



                   ),
                   ),
                 
              

             

            ],
          ),
        ),
        );
  }



  Future <void> signIN() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
         await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password).then((signedInUser)
      {   emailVerification(signedInUser);  
       });
       }
      catch(e){
        dialogTrigger(context,e.message);
      }
    }


  }



    Future<void>emailVerification(signedInUser) async{
      var password,username;
      String message;
      password=signedInUser.uid;
      username=signedInUser.email;

     if(signedInUser.isEmailVerified){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> MyCustomForm(password:password, username:username)));
      }
      else{
        message =  "Your Email ID needs to be Verified !!";
        dialogTrigger(context,message);
      }

     }




  Future<bool> dialogTrigger(BuildContext context,message) async{
   return showDialog(
     context: context,
     barrierDismissible : false,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("$message", style: TextStyle(fontSize: 15.0,color: Colors.red)),
         actions: <Widget>[
           FlatButton(
             child: Text('Try Again',style: TextStyle(fontSize: 20.0,color: Colors.black),),
             onPressed: (){
               Navigator.of(context).pop();
             },

           ),
         ],
       );
     }
   );
  }




}