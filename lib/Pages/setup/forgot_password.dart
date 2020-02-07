import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/Pages/setup/signup.dart' as prefix0;
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}




class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false
      ,
      appBar: AppBar(
        title: Text("Account Recovery"),
        backgroundColor: Colors.blue[900],

      ),
      body: Form(
        key: _formKey,
     child :  Column(
       
        children: <Widget>[
          SizedBox(height: 20,),
      
          Text("Enter your registered email id to reset your password",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black),textAlign: TextAlign.center,),
          SizedBox(height: 40,),
          Container(
            height: 100,
            width: 320,
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(border: Border.all(width: 0.0)),
            child: TextFormField(
               validator:(input){
                  if(input.isEmpty)
                  return "Please enter your registered email id";
                  else 
                  return null;
                } ,
                onSaved: (input){
                  email=input;
                },
                decoration: InputDecoration(
                  labelText: "Email Id",

                )
            ),
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                child: Text("Create a new Account",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Colors.blue[900]),),
                onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=> prefix0.SignUpPage()));
                },

              ),
              RaisedButton(
                color: Colors.blue[900],
                child:Text("Send Link",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.white),) ,
                onPressed: (){
                  resetPassword();

                },
                
              ),
              
            ],
          ),
          Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9iccrsX8YyGB41qF6gEcmgehiqv3ZkIGGDvd3psXOQ14Nkdb-Gw"),

        ],
      ),
      ),
    );
    
  }


Future<void> resetPassword() async {
  if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    forgotPasswordTrigger(context, "We have sent a password recovery link on your email address");
      }
      catch(e){
        forgotPasswordTrigger(context,e.message);

        
        

      }
}
}




  Future<bool> forgotPasswordTrigger(BuildContext context,message) async{
   return showDialog(
     context: context,
     barrierDismissible : false,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("$message", style: TextStyle(fontSize: 15.0,color: Colors.red)),
         actions: <Widget>[
           RaisedButton(
            color: Colors.black,
             child: Text("Ok",style: TextStyle(fontSize: 25.0,color: Colors.blue[300]),),
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