import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utils/configuration.dart';

class LocationProvider with ChangeNotifier {
  static final LocationProvider _instance = LocationProvider._();
  factory LocationProvider() => _instance;

  static LocationProvider get instance => _instance;

  LocationProvider._() {
    getCurrentLocation();
  }

  late Position _currentPosition;
  late String _currentAddress;
  late String _currentCity;

  Position get currentPosition => _currentPosition;
  String get currentAddress => _currentAddress;
  String get currentCity => _currentCity;

  void updateCurrentLocation(Position newPosition) async {
    _currentPosition = newPosition;
    var origin = LatLng(
      _currentPosition.latitude,
      _currentPosition.longitude,
    );
    var destination = const LatLng(
      37.43296265331129,
      -122.08832357078792,
    );
    _currentAddress = await getAddress(newPosition);
    _currentCity = await getCityName(newPosition);
    notifyListeners();
  }

  Future<String> getCityName(Position position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final results = decodedData['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final addressComponents =
            results[0]['address_components'] as List<dynamic>;
        final cityComponent = addressComponents.firstWhere(
            (component) => component['types'].contains('locality'),
            orElse: () => null);
        if (cityComponent != null) {
          return cityComponent['long_name'] as String;
        }
      }
    }
    return Future.error('Location not available');
  }

  Future<String> getAddress(Position position) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleApiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final results = decodedData['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final addressComponents =
            results[0]['address_components'] as List<dynamic>;
        String address = '';
        for (var component in addressComponents) {
          final longName = component['long_name'];
          address += '$longName, ';
        }
        // Elimină virgula și spațiul de la sfârșitul adresei
        address = address.trim().replaceAll(RegExp(r', $'), '');
        return address;
      }
    }
    return Future.error('Location not available');
  }

  Future<void> getCurrentLocation() async {
    try {
      Position newPosition = await Geolocator.getCurrentPosition();
      updateCurrentLocation(newPosition);
    } catch (error) {
      print('Error getting current location: $error');
    }
  }
}
