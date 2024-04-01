import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/services/place_service.dart';
import 'package:taxi_driver_app/core/services/ride_service.dart';
import 'package:taxi_driver_app/ui/utils/input_formatters.dart';
import 'package:taxi_driver_app/ui/widgets/custom_text_form_field.dart';

import '../responsive.dart';
import 'widgets/activity_details_card.dart';
import 'widgets/bar_graph_card.dart';
import 'widgets/build_table_user.dart';
import 'widgets/header_widget.dart';
import 'widgets/line_chart_card.dart';

class AdminPlacesPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AdminPlacesPage({super.key, required this.scaffoldKey});

  @override
  State<AdminPlacesPage> createState() => _AdminPlacesPageState();
}

class _AdminPlacesPageState extends State<AdminPlacesPage> {
  var isSavingNewPlace = false;
  @override
  void initState() {
    super.initState();
    placesController.getAllPlaces();
  }

  // Define a method to add a new place
  void addNewPlace() async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController latitudeController = TextEditingController();
    TextEditingController longitudeController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController photoUrlController = TextEditingController();
    TextEditingController typeController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController websiteController = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Add New Place'),
            content: StatefulBuilder(builder: (context, setState) {
              return isSavingNewPlace
                  ? SingleChildScrollView(
                      child: Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextFormField(
                              hintText: 'Location Name',
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Name';
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Address',
                              controller: addressController,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the Adress';
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Latitude',
                              controller: latitudeController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Latitude is required';
                                }
                                if (!InputFormatters.latlgRegex
                                    .hasMatch(value)) {
                                  return "Latitude is incorrect.";
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Longitude',
                              controller: longitudeController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Longiture is required';
                                }
                                if (!InputFormatters.latlgRegex
                                    .hasMatch(value)) {
                                  return "Longitude is incorrect.";
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Description',
                              controller: descriptionController,
                              keyboardType: TextInputType.text,
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Photo URL',
                              controller: photoUrlController,
                              keyboardType: TextInputType.url,
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Type of Place',
                              controller: typeController,
                              keyboardType: TextInputType.name,
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Phone Number',
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Website',
                              controller: websiteController,
                              keyboardType: TextInputType.url,
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        isSavingNewPlace = true;
                                      });
                                      // Validate the form
                                      String name = nameController.text;
                                      String address = addressController.text;
                                      double latitude = double.tryParse(
                                              latitudeController.text) ??
                                          0.0;
                                      double longitude = double.tryParse(
                                              longitudeController.text) ??
                                          0.0;
                                      String description =
                                          descriptionController.text;
                                      String photoUrl = photoUrlController.text;
                                      String type = typeController.text;
                                      String phoneNumber =
                                          phoneNumberController.text;
                                      String website = websiteController.text;
                                      PlaceModel newPlace = PlaceModel(
                                        place_id: UniqueKey().toString(),
                                        name: name,
                                        address: address,
                                        latitude: latitude,
                                        longitude: longitude,
                                        description: description,
                                        photo_url: photoUrl,
                                        type_place: type,
                                        phone_number: phoneNumber,
                                        website: website,
                                      );
                                      await placesController
                                          .addNewPlace(newPlace)
                                          .then((value) {
                                        setState(() {
                                          isSavingNewPlace = false;
                                        });
                                        if (value) {
                                          Get.back();
                                          Get.snackbar(
                                            'Saving Success',
                                            "The new place have been saved.",
                                            backgroundColor: Colors.green[900],
                                            colorText: Colors.white,
                                          );
                                        } else {
                                          Get.snackbar(
                                            'Saving Error',
                                            "Error occured while save the new place.",
                                            backgroundColor: Colors.red[900],
                                            colorText: Colors.white,
                                          );
                                        }
                                      });
                                    }
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
            }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizedBox height(BuildContext context) => SizedBox(
          height: Responsive.isDesktop(context) ? 30 : 20,
        );

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.isMobile(context) ? 15 : 18),
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 5 : 18,
              ),
              Header(
                scaffoldKey: widget.scaffoldKey,
                title: "List of Locations",
                button: ElevatedButton(
                  onPressed:
                      addNewPlace, // Replace 'Button' with your button text
                  style: ElevatedButton.styleFrom(
                    // Style your button here
                    foregroundColor: Theme.of(context).scaffoldBackgroundColor,
                    backgroundColor: Theme.of(context)
                        .primaryColor, // Text color of the button
                    elevation: 3, // Elevation of the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16), // Padding
                  ), // Replace Icons.add with your desired icon
                  child: const Text('New Place'),
                ),
              ),
              height(context),
              LayoutBuilder(
                builder: (context, constraints) {
                  return const PlacesTable();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
