import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/services/place_service.dart';

import '../../../router.dart';
import '../../widgets/location_card.dart';

class Favorites extends StatelessWidget {
  final List<PlaceModel> _places = listPlaces
      .where(
          (place) => place.type_place == "Home" || place.type_place == "Work")
      .toList();

  Favorites({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RegisterRoute);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 25.0),
              child: Wrap(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 25.0,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Add",
                    style: TextStyle(
                      color: theme.primaryColor,
                      fontSize: 18.0,
                      height: 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "My favorites",
              style: theme.textTheme.titleLarge!
                  .merge(const TextStyle(fontSize: 26.0)),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0.0,
              ),
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Icon(Icons.chevron_right),
            ),
            const Divider(),
            const ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0.0,
              ),
              leading: Icon(Icons.work),
              title: Text(
                "Work",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Icon(Icons.chevron_right),
            ),
            const Divider(),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "OTHER PLACES",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14.0,
                color: Color(0xFF9CA4AA),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              children: _places
                  .map(
                    (place) => LocationCard(place),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
