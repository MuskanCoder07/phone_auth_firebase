import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserShowLocation extends StatefulWidget {
  const UserShowLocation({Key? key}) : super(key: key);

  @override
  State<UserShowLocation> createState() => _UserShowLocationState();
}
class _UserShowLocationState extends State<UserShowLocation> {

  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.47,
  );

  final List<Marker> markarList = [];
  int _markerIdCounter = 1;
  LocationData? _currentLocation;
  late Location _location;

  @override
  void initState() {
    super.initState();
    _location = Location();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await _location.getLocation();

    _location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation;
      });
      _updateCameraPosition();
    });
  }

  Future<void> _updateCameraPosition() async {
    if (_currentLocation != null) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        zoom: 14.4746,
      )));
    }
  }

  void _addMarker(LatLng position) {
    final String markerIdVal = '$_markerIdCounter';
    _markerIdCounter++;
    final Marker marker = Marker(
      markerId: MarkerId(markerIdVal),
      position: position,
      infoWindow: const InfoWindow(
        title: 'My position',
      ),
      onTap: () {
        print('$markerIdVal clicked');
      },
    );
    setState(() {
      markarList.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool canDrawPolygon = markarList.length >= 1;
    final Set<Polygon> polygons = canDrawPolygon
        ? {
      Polygon(
        polygonId: PolygonId('polygon_1'),
        points: markarList.map((marker) => marker.position).toList(),
        strokeWidth: 2,
        strokeColor: Colors.red,
        fillColor: Colors.purple.withOpacity(0.15),
      ),
    } : {};

    return Scaffold(
      body: _currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(markarList),
        polygons: polygons,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _updateCameraPosition();
        },
        onTap: (LatLng position) {
          _addMarker(position);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
