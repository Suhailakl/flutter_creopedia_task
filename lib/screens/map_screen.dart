import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  GoogleMapController controller;

  List<LatLng> latlngSegment1 = List();
  List<LatLng> latlngSegment2 = List();
  static LatLng _lat1 = LatLng(9.9816, 76.2999);
  static LatLng _lat2 = LatLng(10.2277,  76.1971);
  static LatLng _lat3 = LatLng(10.3070, 76.3341);
  static LatLng _lat4 = LatLng(9.9894,   76.5790);
  static LatLng _lat5 = LatLng(10.1004,  76.3570);
  static LatLng _lat6 = LatLng(10.0159,   76.3419);
  LatLng _lastMapPosition = _lat1;

  @override
  void initState() {
    super.initState();

    latlngSegment1.add(_lat1);
    latlngSegment1.add(_lat2);
    latlngSegment1.add(_lat3);
    latlngSegment1.add(_lat4);


    latlngSegment2.add(_lat4);
    latlngSegment2.add(_lat5);
    latlngSegment2.add(_lat6);
    latlngSegment2.add(_lat1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        polylines: _polyline,
        markers: _markers,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _lastMapPosition,
          zoom: 11.0,
        ),
        mapType: MapType.normal,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
          title: 'Flutter Task place',
          snippet: 'Creopedia task',
        ),
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: latlngSegment1,
        width: 2,
        color: Colors.blue,
      ));

      _polyline.add(Polyline(
        polylineId: PolylineId('line2'),
        visible: true,
        points: latlngSegment2,
        width: 2,
        color: Colors.red,
      ));
    });
  }
}