import 'dart:async';
import 'dart:math' as math;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;

class Screen extends StatefulWidget {
  @override
  _ScreenPageState createState() => _ScreenPageState();
}

//Kelas untuk kontrol, marker, posisi, polylines ada disini
class _ScreenPageState extends State<Screen> {
  final data = FirebaseDatabase.instance;
  GoogleMapController googleMapController;
  Marker _marker;
  double _placeDistance;
  double distance;
  String jarakLine;
  int langkah;
  String datafirebase = "";
  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  StreamSubscription<Position> _positionLokasi;
  Map<MarkerId, Marker> _markers = Map();
  Map<PolylineId, Polyline> _polilynes = Map();
  List<LatLng> _myRoutes = List();
  Position _lastPosition;

  jarak() {
    double _placeDistance;
    double totalDistance = 0.0;
    for (int i = 0; i < _myRoutes.length - 1; i++) {
      totalDistance += _coordinateDistance(
        _myRoutes[i].latitude,
        _myRoutes[i].longitude,
        _myRoutes[i + 1].latitude,
        _myRoutes[i + 1].longitude,
      );
    }
    _placeDistance = totalDistance;
    print('DISTANCE: $_placeDistance km');
  }

  //inisialisasi pemanggilan start track
  @override
  void initState() {
    super.initState();
    _startTrack();
  }

  //memulai pemanggilan google maps
  _startTrack() {
    final geolocator = Geolocator();
    final locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 5);
    _positionLokasi =
        geolocator.getPositionStream(locationOptions).listen(_posisi);
  }

  //memulai mengambil posisi user
  _posisi(Position position) {
    if (position != null) {
      final myPosition = LatLng(position.latitude, position.longitude);
      _myRoutes.add(myPosition);
      final myPolilyne = Polyline(
          polylineId: PolylineId("me"),
          points: _myRoutes,
          color: Colors.cyanAccent,
          width: 6);
      if (_marker == null) {
        final markerId = MarkerId("me");
        _marker = Marker(
            markerId: markerId,
            position: myPosition,
            rotation: 0,
            anchor: Offset(0.5, 0.5));
      } else {
        final rotation = _getMyBearing(_lastPosition, position);
        _marker = _marker.copyWith(
            positionParam: myPosition, rotationParam: rotation);
      }
      setState(() {
        _markers[_marker.markerId] = _marker;
        _polilynes[myPolilyne.polylineId] = myPolilyne;
      });
      _lastPosition = position;
      _pindahposisi(position);
    }
    double totalDistance = 0;
    for (int i = 0; i < _myRoutes.length - 1; i++) {
      totalDistance += _coordinateDistance(
        _myRoutes[i].latitude,
        _myRoutes[i].longitude,
        _myRoutes[i + 1].latitude,
        _myRoutes[i + 1].longitude,
      );
      setState(() {
        _placeDistance = totalDistance;
        print('DISTANCE: $_placeDistance m');
      });
    }
    distance = _placeDistance * 3;
    jarakLine = _placeDistance.toStringAsFixed(0);
    langkah = distance.round();
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)) * 1000;
  }

  //fungsi untuk mengubah icon user
  double _getMyBearing(Position lastPosition, Position currentPosition) {
    final x = math.cos(math.pi / 100 * lastPosition.latitude) *
        (currentPosition.longitude - lastPosition.longitude);
    final y = currentPosition.latitude - lastPosition.latitude;
    final angle = math.atan2(x, y);
    return 90 - angle + 180 / math.pi;
  }

  @override
  void dispose() {
    if (_positionLokasi != null) {
      _positionLokasi.cancel();
      _positionLokasi = null;
    }
    super.dispose();
  }

  //melakukan update kamera jika posisi user berpindah
  _pindahposisi(Position position) {
    final cameraUpdate =
        CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude));
    googleMapController.animateCamera(cameraUpdate);
  }

  //sistem untuk menampilkan class diatas dan fungsi diatas
  //penambahan tombol dan perbaikan ui disini
  @override
  Widget build(BuildContext context) {
    final ref = data.reference().child("Maps2E");
    final jarak = ref.reference().child("JarakTempuh");
    final langkahkaki = ref.reference().child("JumlahLangkah");
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
                width: 500,
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  polylines: Set.of(_polilynes.values),
                  onMapCreated: (GoogleMapController controller) {
                    googleMapController = controller;
                  },
                ),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 20, 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Jarak yang ditempuh: $jarakLine m',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 20, 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Jumlah Langkah: $langkah',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: RaisedButton(
              color: Colors.green,
              onPressed: () =>
                  {jarak.set(jarakLine + " km"), langkahkaki.set(langkah)},
              child: new Text("Simpan"),
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
