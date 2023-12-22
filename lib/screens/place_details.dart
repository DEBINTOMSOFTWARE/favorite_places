import 'package:favorite_places/screens/map.dart';
import 'package:favorite_places/utils/locationImage.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(children: [
        Image.file(
          place.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MapScreen(
                        location: place.location,
                        isSelecting: false,
                      ))
                    );
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(
                        LocationImage(location: place.location).locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.blueAccent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Text(
                    place.location.address,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                )
              ],
            ))
      ]),
    );
  }
}
