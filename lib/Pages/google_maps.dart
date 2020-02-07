import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

//void main() => runApp(GoogleMaps());

class GoogleMaps extends StatefulWidget {
   @override
  _GoogleMapsState createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {

  GoogleMapController mapController;
  var location = new Location();
  Map<String, double> userLocation;
  double longitude ;
  double latitude;

  static LatLng _center =  LatLng(28.6442343,77.06936046282387);



  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  MapType _currentMapType = MapType.normal;

final Set<Marker> _markers = {};

 /* void _onAddMarkerButtonPressed() {
  setState(() {
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_lastMapPosition.toString()),
      position: _lastMapPosition,
      infoWindow: InfoWindow(
        title: 'Really cool place',
        snippet: '5 Star Rating',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
  });
}
*/
@override
void initState(){
  super.initState();
   _getLocation().then((value) {
                    setState(() {
                      userLocation = value;
                      longitude = userLocation["longitude"];
                      latitude = userLocation["latitude"];
                      initMarker(latitude, longitude);

                    });
                  });

  

}


  initMarker(latitude,longitude) {
    print(longitude);
    _markers.add(Marker(
      // This marker id can be anything that uniquely identifies each marker.
      markerId: MarkerId(_lastMapPosition.toString()),
      position: LatLng(latitude,longitude),
      infoWindow: InfoWindow(
        title: 'Your Location',
        snippet: 'New Delhi,India',
      ),
      icon: BitmapDescriptor.defaultMarker,
    ));
   
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




  void _onMapTypeButtonPressed() {
  setState(() {
    _currentMapType = _currentMapType == MapType.normal
        ? MapType.satellite
        : MapType.normal;
  });
}

LatLng _lastMapPosition = _center;


  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        appBar: AppBar(
          title: Text('Google Maps'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
           GoogleMap(
             mapType: _currentMapType,
             onMapCreated: _onMapCreated,
             initialCameraPosition: CameraPosition(
                 target: _center,
                 zoom: 12.0,
                ),
              onCameraMove: _onCameraMove,
              markers: _markers,
           ),
           Align(
             alignment: Alignment.topRight,
             child :Column(
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: FloatingActionButton(
                   onPressed: _onMapTypeButtonPressed,
                   materialTapTargetSize: MaterialTapTargetSize.padded,
                   backgroundColor: Colors.green,
                   child: const Icon(Icons.map, size : 36.0),
                 ),
                ),
                /* FloatingActionButton(
                    onPressed: _onAddMarkerButtonPressed,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add_location, size: 36.0),
                ),
                */

          ],
             ),
           ),
        ],
      ),
    ),
  ); 
 }
}