import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onSelectedLocation,
  });

  final void Function(PlaceLocation location) onSelectedLocation;

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }
    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:green%7Clabel:G%7C$lat,$lng&key=AIzaSyAmdjx5uAJ66Y43vNt1b1l2FgmCIGQ5dws';
  }

  void _savePlace(double lat, double lng) async {
    final url = Uri.parse(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyAmdjx5uAJ66Y43vNt1b1l2FgmCIGQ5dws');
        final response = await http.get(url);
        final resData = json.decode(response.body);
        final address = resData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation =
          PlaceLocation(latitude: lat, longitude: lng, address: address);
      _isGettingLocation = false;
    });

    widget.onSelectedLocation(_pickedLocation!);
  }

  void _selectOnMap() async {
    final pickedLocation = await Navigator.of(context)
        .push<LatLng>(MaterialPageRoute(builder: (context) => const MapScreen()));

        if(pickedLocation == null) {
          return;
        }
        _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;
    if (lat == null || lng == null) {
      return;
    }

    _savePlace(lat, lng);
    
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location Selected',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(
        locationImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: Theme.of(context)
                      .colorScheme
                      .onBackground
                      .withOpacity(0.3))),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Get current Location')),
            TextButton.icon(
                onPressed: _selectOnMap,
                icon: const Icon(Icons.map),
                label: const Text('Select on Map')),
          ],
        )
      ],
    );
  }
}
