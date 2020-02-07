import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_integration/Pages/google_maps.dart';
import 'package:firebase_integration/services/crud.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';





class GetLocationPage extends StatefulWidget {
  final firstname,password,username,batteryLevel;
  GetLocationPage({this.firstname,this.password,this.username,this.batteryLevel});
  @override
  _GetLocationPageState createState() => _GetLocationPageState(firstname : firstname,password:password,username:username,batteryLevel : batteryLevel);
}


class _GetLocationPageState extends State<GetLocationPage> {
  final firstname,password,username,batteryLevel;

  _GetLocationPageState({this.firstname,this.password,this.username,this.batteryLevel});
  var location = new Location();
  
  QuerySnapshot details;
  var lat,long;
  String longitude ;
  String latitude;
  CrudMethods crudObj = new CrudMethods();
  String name,mobile;
  Map<String, double> userLocation;


 /* @override 
  void initState(){
    super.initState();
    crudObj.getData(password).then((results){
      setState((){

        details=results;
        
        name = details.documents[0].data['Name'];
        mobile = details.documents[0].data['Mobile'];
        print(name);
        print(mobile);
        
        
      });
    });
  }

  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Your Current Location"),
        backgroundColor: Colors.black87,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              FlatButton(
              color: Colors.white,
              child: Text("Message" , style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.normal,color: Colors.black)),
              onPressed: (){},
            ),
            Container(
              padding: EdgeInsets.all(3.0),
              width: 350,
              height:200,
              decoration: BoxDecoration(border: Border.all(width: 1.0)),
              child: Text(firstname,style: TextStyle(fontSize: 23.0,fontWeight: FontWeight.normal,color: Colors.pinkAccent),
              
              ),
              ),
         
             Text('\n\n'),
            userLocation == null
                ? CircularProgressIndicator()
                : Text("\t\t\t\tLatitude : " +
                    userLocation["latitude"].toString() +
                    "\n\n" + "\t\t\t\tLongitude : " +
                    userLocation["longitude"].toString() + "\n\n" + "\t\t\t\tYour Battery Percentage : $batteryLevel%",style: TextStyle(fontSize: 20.0),),
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                      longitude = userLocation["longitude"].toString();
                      latitude = userLocation["latitude"].toString();

                    });
                  });
                },

                color: Colors.blue,
                child: Text("Get Location", style: TextStyle(color: Colors.white),),
              ),
            ),

            RaisedButton(
              onPressed: (){

              },
              elevation: 8.0,
              color: Colors.green,
              child: IconButton(
                icon: Icon(Icons.map),
                iconSize: 35.0,
                onPressed: (){
                     Navigator.push(context,MaterialPageRoute(builder: (context) => GoogleMaps()));
                },
              ),
            ),
          ],
        ),
            RaisedButton(
              child: Text('Click to Save and Submit',style: TextStyle(fontSize: 15.0,color: Colors.white),),
              color: Colors.black,
              onPressed: (){ 
        
                Map <String,String> userData = {

                 
                 
                  
                  'Email':this.username,
                  'Latitude' : this.latitude,
                  'Longitude' : this.longitude,
                  'Message' : this.firstname,
                  'Battery Level': this.batteryLevel.toString(),
                };
                crudObj.addData(userData,password).then((result){
                  dialogTrigger(context); 
              }).catchError((e){
                print(e);
              });
              },  

            ),
         
          ],
        ),
      ),
      
    );
  }
  
  Future<Map<String, double>> _getLocation() async {
    var currentLocation = <String, double>{};
    try {
      currentLocation = await location.getLocation();
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }



  Future<bool> dialogTrigger(BuildContext context) async{
   return showDialog(
     context: context,
     barrierDismissible : false,
     builder: (BuildContext context){
       return AlertDialog(
         title: Text("Your Message and Image has been Submitted successfully to our Helpline Portal ", style: TextStyle(fontSize: 18.0)),
         actions: <Widget>[
           FlatButton(
             child: Text('Click to Continue'),
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