import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/custom_popup.dart';
import 'package:taxi_driver_app/core/models/Place_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/ui/utils/date_utlis.dart';
import 'package:taxi_driver_app/ui/utils/input_formatters.dart';

class PlaceManager {
  final BuildContext context;
  PlaceManager(this.context);

  void showPlaceDetails(content) {
    PlaceModel place = PlaceModel(
      place_id: content.place_id,
      name: content.name,
      address: content.address,
      latitude: content.latitude,
      longitude: content.longitude,
      description: content.description,
      photo_url: content.photo_url,
      phone_number: content.phone_number,
      type_place: content.type_place,
      website: content.website,
    );
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            place.place_id,
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: const Text("Name"),
                  subtitle: Text(place.name),
                ),
                ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: const Text("Address"),
                  subtitle: Text(place.address),
                ),
                ListTile(
                  leading: const Icon(Icons.location_pin),
                  title: const Text("Latitude"),
                  subtitle: Text("${place.latitude}"),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_sharp),
                  title: const Text("Longitude"),
                  subtitle: Text("${place.longitude}"),
                ),
                ListTile(
                  leading: const Icon(Icons.insert_drive_file_outlined),
                  title: const Text("Description"),
                  subtitle: InputFormatters.isTextEmptyOrNull(place.description)
                      ? Text(
                          "-- none --",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w100,
                                  ),
                        )
                      : Text(place.description.toString()),
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Picture"),
                  subtitle: InputFormatters.urlRegex
                          .hasMatch(place.photo_url.toString())
                      ? FadeInImage.assetNetwork(
                          placeholder: "assets/images/bg.png",
                          image: place.photo_url.toString(),
                        )
                      : Text(
                          "-- none --",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w100,
                                  ),
                        ),
                ),
                ListTile(
                  leading: const Icon(Icons.call),
                  title: const Text("Phone Number"),
                  subtitle:
                      InputFormatters.isTextEmptyOrNull(place.phone_number)
                          ? Text(
                              "-- none --",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w100,
                                  ),
                            )
                          : Text(place.phone_number.toString()),
                ),
                ListTile(
                  leading: const Icon(Icons.wb_cloudy_outlined),
                  title: const Text("Website"),
                  subtitle: InputFormatters.isTextEmptyOrNull(place.website)
                      ? Text(
                          "-- none --",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w100,
                                  ),
                        )
                      : Text(place.website.toString()),
                ),
                ListTile(
                  leading: const Icon(Icons.playlist_add_check_circle),
                  title: const Text("Type"),
                  subtitle: InputFormatters.isTextEmptyOrNull(place.type_place)
                      ? Text(
                          "-- none --",
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    fontWeight: FontWeight.w100,
                                  ),
                        )
                      : Text(place.type_place.toString()),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
