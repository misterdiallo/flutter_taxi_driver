import 'package:flutter/material.dart';

import '../../core/models/place_model.dart';

class LocationCard extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback? onTap;

  const LocationCard(this.place, {Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          leading: Icon(
            Icons.location_on,
            color: theme.primaryColor,
          ),
          title: Text(
            place.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            place.address,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
