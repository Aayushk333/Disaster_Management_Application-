import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class CrudMethods{

  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser() != null ){

      return true;
    }
    else{
      return false;
    }
  }

  Future<void> addData(userData,password)async {
    if(isLoggedIn()){
      Firestore.instance.collection('users').document("$password").updateData(userData).catchError((e){
        print(e);
        });
      }
    else{
      print('You need to be Logged In !');
    }
    }


   // getData (String password) async {
   //   return await Firestore.instance.collection('users').where('Uid',isEqualTo: password).getDocuments();


    //}



}


