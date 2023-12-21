import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceItem extends StatelessWidget {
  const PlaceItem({super.key, required this.placeName});

  final String placeName;

  @override
  Widget build(BuildContext context) {
    return Text(
      placeName,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );
  }
}
