import 'package:firebase_integration/services/usermanagement.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpPage extends StatefulWidget {
  
  @override
  _SignUpPageState createState() => _SignUpPageState();
}
String email,password,name,phone,message;  
class _SignUpPageState extends State<SignUpPage> {
  //underscore is used to mark the variables as private in dart language
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override 
  Widget build (BuildContext context ){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:Text("Sign Up Page",style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal),),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               
              TextFormField(
                validator:(input){
                  if(input.isEmpty)
                  return "Please Enter your Name";
                  else 
                  return null;
                } ,
                onSaved: (input){
                  name=input;
                },
                decoration: InputDecoration(
                  labelText: "Full Name",

                )
                 ,),
                 TextFormField(
                validator:(input){
                  if(input.isEmpty)
                  return "Please Enter your Mobile No.";
                  else 
                  return null;
                } ,
                onSaved: (input){
                  phone=input;
                },
                decoration: InputDecoration(
                  labelText: "10-digit Mobile Number",

                )
                 ,),

              TextFormField(
                validator:(input){
                  if(input.isEmpty)
                  return "Please type an email";
                  else 
                  return null;
                } ,
                onSaved: (input){
                  email=input;
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
                  password=input;
                },
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                obscureText: true,
                 ),
                 SizedBox(height: 30.0),
                 Container(
                   height: 40.0,
                   child: Material(
                     borderRadius: BorderRadius.circular(50.0),
                     shadowColor: Colors.blueAccent,
                     color: Colors.blue[900],
                     elevation: 7.0,
                     child: GestureDetector(
                       onTap: (){
                         if(_formKey.currentState.validate()){
                             message = "A verification link has been sent to your E-mail Address !\nPlease Verify it to Sign into your account !!";
                             dialogTrigger(context, message);
                             signIN();
                        }
                  },
                       child: Center(
                         child: Text('SIGN UP',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                       ),
                     ),
                   ),
                 ),

            ],
          ),
        ),
        );
  }


  Future <void>signIN() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      
   FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((signedInUser){
        emailVerification(signedInUser);
      }).catchError((e){
        dialogTrigger(context,e.message);
      });
    }
     }

    Future<void>emailVerification(signedInUser) async{

      await signedInUser.sendEmailVerification();
      UserManagement().storeNewUser(signedInUser, context,name,phone);
      
    }



  
  Future<bool> dialogTrigger(BuildContext context, message) async{
   return showDialog(
     context: context,
     barrierDismissible : false,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("$message", style: TextStyle(fontSize: 17.0,color: Colors.red)),
         actions: <Widget>[
           FlatButton(
             child: Text('Click to Continue',style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold),),
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
