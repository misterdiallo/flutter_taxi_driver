import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/services/place_service.dart';
import 'package:taxi_driver_app/router.dart';
import 'package:taxi_driver_app/ui/styles/colors.dart';
import 'package:taxi_driver_app/ui/widgets/location_card.dart';

class DestinationViewCustomer extends StatefulWidget {
  const DestinationViewCustomer({super.key});

  @override
  _DestinationViewCustomerState createState() =>
      _DestinationViewCustomerState();
}

class _DestinationViewCustomerState extends State<DestinationViewCustomer> {
  List<PlaceModel>? shortedList;
  String searchQuery = '';
  searchPlaces(String query) {
    if (query.isNotEmpty) {
      setState(() {
        shortedList = listPlaces
            .where((place) =>
                place.name.toLowerCase().contains(query.toLowerCase()) ||
                place.address.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        shortedList = null;
      });
    }
  }

  final List<PlaceModel> _destinations = [
    PlaceModel(
        placeId: "0000000",
        name: "",
        address: "",
        latitude: 0000,
        longitude: 000)
  ];
  TextEditingController sourceTextController = TextEditingController();
  TextEditingController destinationTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.map,
                size: 30.0,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 0.0,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    blurRadius: 2.0,
                    spreadRadius: 0.1,
                    offset: Offset(0, 2),
                  ),
                ],
                color: theme.scaffoldBackgroundColor,
                // color: theme.scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            width: 15.0,
                            height: 15.0,
                            decoration: const BoxDecoration(
                              color: dbasicDarkColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Column(
                            children: _destinations
                                .map(
                                  (destination) => Column(
                                    children: <Widget>[
                                      const Text(
                                        ".\n.\n.\n.\n.\n.",
                                        style: TextStyle(
                                            height: 0.4,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          top: 3.0,
                                        ),
                                        width: 15.0,
                                        height: 15.0,
                                        decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                top: 10.0,
                              ),
                              child: TextFormField(
                                controller: sourceTextController,
                                onChanged: (value) {
                                  searchPlaces(value);
                                },
                                decoration: InputDecoration(
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.focusColor,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: dbasicDarkColor,
                                      ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    hintText: "Enter Source"),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                top: 20.0,
                              ),
                              child: TextFormField(
                                controller: destinationTextController,
                                onChanged: (value) {
                                  searchPlaces(value);
                                },
                                decoration: InputDecoration(
                                    isDense: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: theme.focusColor,
                                      ),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: dbasicDarkColor,
                                      ),
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    hintText: "Enter Destination"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            String? disposableData;
                            setState(() {
                              disposableData = sourceTextController.text;
                              sourceTextController.text =
                                  destinationTextController.text;
                              destinationTextController.text =
                                  disposableData.toString();
                              disposableData = null;
                            });
                          },
                          child: const Center(
                            child: Icon(
                              FontAwesomeIcons.arrowsUpDown,
                              size: 20.0,
                              color: dbasicDarkColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (sourceTextController.text.isNotEmpty &&
                      destinationTextController.text.isNotEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 20.0),
                        Center(
                            child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 40.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                            ),
                            onPressed: () {
                              if (sourceTextController.text.isNotEmpty &&
                                  destinationTextController.text.isNotEmpty) {
                                Get.toNamed(SearchingCarRoute, arguments: {
                                  "source": sourceTextController.text,
                                  "destination": destinationTextController.text,
                                });
                              }
                            },
                            child: const Text(
                              "FIND RIDES",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        )),
                      ],
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[_recentPlaces(shortedList)],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void tapToAddInTextFormField(PlaceModel tappedPlace) {
    String tappedAddress = tappedPlace.address;

    if (sourceTextController.text == tappedAddress ||
        destinationTextController.text == tappedAddress) {
      return;
    }

    bool isSourceEmpty = sourceTextController.text.isEmpty;
    bool isDestinationEmpty = destinationTextController.text.isEmpty;

    if (isSourceEmpty && isDestinationEmpty) {
      // Handle the case where both source and destination are empty
      setState(() {
        sourceTextController.text = tappedAddress;
      });
    } else if (isSourceEmpty || (isDestinationEmpty && !isSourceEmpty)) {
      setState(() {
        destinationTextController.text = tappedAddress;
      });
    } else {
      setState(() {
        sourceTextController.text = tappedAddress;
      });
    }
  }

  Widget _recentPlaces(List<PlaceModel>? suggestionPlacesList) {
    return SingleChildScrollView(
      child: Column(
        children: suggestionPlacesList == null || suggestionPlacesList.isEmpty
            ? listPlaces.map((place) {
                var column = linePlaceData(place);
                return column;
              }).toList()
            : suggestionPlacesList.map((place) {
                var column = linePlaceData(place);
                return column;
              }).toList(),
      ),
    );
  }

  Column linePlaceData(PlaceModel place) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LocationCard(
          place,
          onTap: () {
            tapToAddInTextFormField(place);
          },
        ),
        Divider(
          height: 0.0,
          color: Theme.of(context).hoverColor.withOpacity(0.1),
        )
      ],
    );
  }
}
