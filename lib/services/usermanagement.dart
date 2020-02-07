import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_integration/Pages/setup/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class UserManagement {
  var password;
  storeNewUser(user,context,name,phone){
    password=user.uid;
     Firestore.instance.collection('users').document("$password").setData({
      'Name' : name,
      'Mobile' : phone,
      'Email': user.email,
      'Uid': user.uid,
      
      
    }).then((value){
    
      Navigator.of(context).pop();
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));

    }).catchError((e){
      print(e);
    });
    

    
  }
  }