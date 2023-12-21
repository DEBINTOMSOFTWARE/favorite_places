import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          'No Places Added Yet.',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }
    return ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 32,
                  backgroundImage: FileImage(places[index].image),
                ),
                title: Text(
                  places[index].title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  places[index].location.address,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PlaceDetailScreen(place: places[index]),
                  ));
                },
              ),
            ));
  }
}
