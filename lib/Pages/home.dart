import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/Pages/location.dart';
import 'package:firebase_integration/Pages/setup/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:battery/battery.dart';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart' ;
import 'dart:math' as Math;


class MyCustomForm extends StatefulWidget{
  final password,username;
  MyCustomForm({this.password,this.username});
  

  _MyCustomFormState createState()=>_MyCustomFormState(password:password,username:username);
}
String firstname,message;

class _MyCustomFormState extends State<MyCustomForm>{
  
 final password,username;
 _MyCustomFormState({this.password,this.username});
bool _autoValidate = false;
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

var _batteryLevel,_batteryState;



File sampleImage ; 
Future getImage(bool isCamera) async {
    File image;
    message = 'Your image is being compressed!\  Please don"t close the application';
    if(isCamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);

      compressionTrigger(context,message);
    }

    else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
      compressionTrigger(context,message );
    }
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(10000);
    Im.Image decodeImage = Im.decodeImage(image.readAsBytesSync());
    Im.Image smallerImage = Im.copyResize(decodeImage, width: 1024);
    var compressedImage = new File('$path/img_$rand.jpg')..writeAsBytesSync(Im.encodeJpg(smallerImage,quality: 95));
    setState(() {
      //Navigator.of(context).pop();
      sampleImage = compressedImage;
    });
   
}
 

final Battery _battery =  Battery();

@override 
void initState(){
  super.initState();
  _battery.batteryLevel.then((level) {
      this.setState(() {
        _batteryLevel = level;
      });
    });

    _battery.onBatteryStateChanged.listen((BatteryState state) {
      _battery.batteryLevel.then((level) {
        this.setState(() {
          _batteryLevel = level;
          _batteryState = state;
        });
      });
    });
}



  @override 
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Help Message"),
        backgroundColor: Colors.black,
        ),
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Column(
         
          children: <Widget>[
                Row(
               // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                         icon: Icon(Icons.insert_drive_file) ,
                         iconSize: 50.0,
                         tooltip: "Select an image from the gallery",
                         onPressed: (){
                                 getImage(false);
                         }
                  ),
                 SizedBox(height: 10.0,width: 10.0,),
                 IconButton(
                     icon: Icon(Icons.camera_alt),
                     iconSize: 50.0,
                     tooltip: "Click an Image",
                     onPressed: (){
                     getImage(true);
                     },
                ),
                Padding(
                  padding: EdgeInsets.only(left: 135.0),
                ),
                OutlineButton(
                borderSide: BorderSide(color: Colors.black,style: BorderStyle.solid,width: 1.5),
                child: Text("Logout"),
                onPressed: (){
                  FirebaseAuth.instance.signOut()
                  .then((value){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
                  }).catchError((e){
                    print(e);});
                },

              ),
            ],
           ),
           Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[   
           sampleImage == null ? Container () : Image.file(sampleImage,height: 200.0,width:150.0,),

            RaisedButton(
              elevation: 20.0,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.file_upload),
                    iconSize: 25.0,
                    onPressed: (){},
                  ),
                  Text('Upload Image',style: TextStyle(fontSize: 18.0),),

                ],
                
                
              ),
              
              textColor: Colors.white,
              color: Colors.black,
              onPressed: ()  {
                if(sampleImage==null)
                {
                  message= "Please select an Image to Upload !!!";
                  uploadErrorTrigger(context, message);
                }
                else{
                      uploadPic(context);
                      message = "Your Image is being Uploaded ! \nPlease wait, It may take upto a few mins ! ";
                      uploadTrigger(context, message);
                }
              },
           ),
           ],
           ),
           
            Text("\nBattery Level : "+ "$_batteryLevel%\n" , style: TextStyle(color: Colors.deepPurple,fontSize: 35.0,fontWeight: FontWeight.bold),),
            Container(
              width: 350.0,
              height: 100.0,
              decoration: BoxDecoration(border: Border.all(width:2.0)),
              child: new Form( 
                 key: _formKey,
                 autovalidate: _autoValidate,
              child: TextFormField(
                  decoration: InputDecoration(
                  labelText: "Type your Message here",
                  icon: Icon(Icons.text_fields),
                ),
                keyboardType: TextInputType.text,
                validator: (String value){
                  firstname = value;
                  if(value.isEmpty)
                    return "Please type your help message !";
                  else 
                    return null;
                },
              ),
            ),
            ),
            RaisedButton(
              color: Colors.green,
              child: Text('Submit',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold),),
              onPressed:(){ _validateInputs();},
              ),
              

          ],
        ), 
        
    
      ),
    );
  }


  void _validateInputs(){
   
   if(_formKey.currentState.validate())
      {  
        if(_batteryLevel < 60) {
              message = "Battery Level Low !! \n Please charge your Device";
              dialogTrigger(context,message);
              }

        else {
          message = "We will Reach out to you as soon as Possible...\nPlease Finish by Submitting your Details !";
          dialogTrigger(context, message);
        }
          
        }

      else {
        setState(() {
          _autoValidate = true;
        });
            }
 }


 Future uploadPic(BuildContext context)async{
   
   final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('$password.jpg');
   final StorageUploadTask task = firebaseStorageRef.putFile(sampleImage);
   StorageTaskSnapshot tasksnapshot = await task.onComplete;
   
   setState((){
    message = "Your Image has been uploaded";
    uploadCompleteTrigger(context,message);
   });
 }







  Future<bool> dialogTrigger(BuildContext context, message) async{
   return showDialog(
     context: context,
     barrierDismissible : true,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("$message", style: TextStyle(fontSize: 20.0,color: Colors.red)),
         actions: <Widget>[
           FlatButton(
             child: 
             Column(
               children: <Widget>[
                         Text('Click to Continue',style: TextStyle(fontSize: 25.0,color: Colors.black,fontWeight: FontWeight.bold),),
                
              ],
             ),
             onPressed: (){
               Navigator.push(context,MaterialPageRoute(builder: (context) => GetLocationPage(firstname : firstname,password:password,username:username, batteryLevel : _batteryLevel)));
              
             },

           ),
         ],
       );
     }
   );
  }

    Future<bool> compressionTrigger(BuildContext context, message) async{
   return showDialog(
     context: context,
     barrierDismissible : true,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("$message", style: TextStyle(fontSize: 20.0,color: Colors.red)),
         actions: <Widget>[
           FlatButton(
             child: 
             Column(
               children: <Widget>[
                         Text('Click to Continue',style: TextStyle(fontSize: 25.0,color: Colors.black,fontWeight: FontWeight.bold),),
                
              ],
             ),
             onPressed: (){
             },

           ),
         ],
       );
     }
   );
  }





    Future<bool> uploadErrorTrigger(BuildContext context, message) async{
   return showDialog(
     context: context,
     barrierDismissible : true,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("$message", style: TextStyle(fontSize: 20.0,color: Colors.red)),
         actions: <Widget>[
           IconButton(
             icon: Icon(Icons.file_upload),
             onPressed: (){},
             
           ),
           FlatButton(
             child: 
             Column(
               children: <Widget>[
                         Text('Click to Continue',style: TextStyle(fontSize: 25.0,color: Colors.black,fontWeight: FontWeight.bold),),
                
              ],
             ),
             onPressed: (){
               Navigator.of(context).pop();
              
             },

           ),
         ],
       );
     }
   );
  }






  Future<bool> uploadTrigger(BuildContext context, message) async{
   return showDialog(
     context: context,
     barrierDismissible : false ,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("$message", style: TextStyle(fontSize: 15.0,color: Colors.red)),
         actions: <Widget>[
           FlatButton(
             child: 
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                        CircularProgressIndicator(backgroundColor: Colors.black,),
                         Text('\nDo not close the Application',style: TextStyle(fontSize: 18.0,color: Colors.black),),
                         
                                     ],
             ),
             onPressed: (){
              
             },

           ),
         ],
       );
     }
   );
  }  





  Future<bool> uploadCompleteTrigger(BuildContext context, message) async{
   return showDialog(
     context: context,
     barrierDismissible : false ,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("$message", style: TextStyle(fontSize: 15.0,color: Colors.red)),
         actions: <Widget>[
           FlatButton(
             child: 
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                        
                         Text('Tap here to Continue',style: TextStyle(fontSize: 20.0,color: Colors.black),),
                         
                                     ],
             ),
             onPressed: (){
               Navigator.of(context).pop();
               Navigator.of(context).pop();
             },

           ),
         ],
       );
     }
   );
  } 

 
 
}