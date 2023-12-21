import 'package:favorite_places/models/place.dart';

class LocationImage {

const LocationImage({required this.location});

final PlaceLocation location;

 String get locationImage {
    final lat = location.latitude;
    final lng = location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:green%7Clabel:G%7C$lat,$lng&key=AIzaSyB0W_UtIxoT0KNfSXIHj7G6HqQbzF98Ezw';
  }

}