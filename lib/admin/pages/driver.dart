import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/admin/pages/widgets/build_table_user.dart';
import 'package:taxi_driver_app/core/controllers/app/app_constant.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/car_model.dart';
import 'package:taxi_driver_app/core/models/place_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/ui/utils/date_utlis.dart';
import 'package:taxi_driver_app/ui/utils/input_formatters.dart';
import 'package:taxi_driver_app/ui/widgets/custom_text_form_field.dart';

import '../responsive.dart';
import 'widgets/header_widget.dart';

class AdminDriverPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AdminDriverPage({super.key, required this.scaffoldKey});

  @override
  State<AdminDriverPage> createState() => _AdminDriverPageState();
}

class _AdminDriverPageState extends State<AdminDriverPage> {
  var isSavingNewPlace = false;
  @override
  void initState() {
    super.initState();
    userController.getAllTypeUsersData(UserType.driver);
  }

  // Define a method to add a new place
  void addNewDriver() async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController fullname = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController phoneNumber = TextEditingController();
    TextEditingController address = TextEditingController();
    TextEditingController datebirth = TextEditingController();
    TextEditingController licenceNumber = TextEditingController();
    TextEditingController plateNumber = TextEditingController();
    TextEditingController modelCar = TextEditingController();
    TextEditingController color = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Add New Driver'),
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
                              hintText: 'Full Name',
                              controller: fullname,
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
                              hintText: 'Email',
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the Email';
                                }
                                if (!InputFormatters.emailRegex
                                    .hasMatch(value)) {
                                  return "Email is incorrect.";
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Phone Number',
                              controller: phoneNumber,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone is required';
                                }
                                if (!InputFormatters.phoneNumberRegex
                                    .hasMatch(value)) {
                                  return "Phone is incorrect.";
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Full Address',
                              controller: address,
                              keyboardType: TextInputType.streetAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Adress is required';
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Date of birth(YYYY/MM/DD)',
                              showLabel: true,
                              controller: datebirth,
                              keyboardType: TextInputType.datetime,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Date of birth is required';
                                }
                                if (!InputFormatters.dateOfBirthRegex
                                    .hasMatch(value)) {
                                  return "Incorrect date of birth";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Car Licence Number',
                              controller: licenceNumber,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Car Licence number is required';
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Car Plate Number',
                              controller: plateNumber,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Car Plate number is required';
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Car model',
                              controller: modelCar,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Car model is required';
                                }
                                return null;
                              },
                              showLabel: false,
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            CustomTextFormField(
                              hintText: 'Car color',
                              controller: color,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Car color is required';
                                }
                                return null;
                              },
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
                                      String fullNameValue = fullname.text;
                                      String emailValue = email.text;
                                      String phoneNumberValue =
                                          phoneNumber.text;
                                      String addressValue = address.text;
                                      DateTime dateOfBirthValue =
                                          stringToDate(datebirth.text);
                                      String licenseNumberValue =
                                          licenceNumber.text;
                                      String plateNumberValue =
                                          plateNumber.text;
                                      String modelCarValue = modelCar.text;
                                      String colorValue = color.text;

                                      UserModel driver = UserModel(
                                        user_id: "user_id",
                                        full_name: fullNameValue,
                                        email: emailValue,
                                        phone_number: phoneNumberValue,
                                        user_type: UserType.driver,
                                        address: addressValue,
                                        date_of_birth: dateOfBirthValue,
                                        is_active: true,
                                      );
                                      CarModel car = CarModel(
                                        car_id: "car_id",
                                        license_number: licenseNumberValue,
                                        model: modelCarValue,
                                        plate_number: plateNumberValue,
                                        color: colorValue,
                                        user: driver,
                                      );
                                      await driverData
                                          .newDriverWithCar(driver, car)
                                          .then((value) {
                                        setState(() {
                                          isSavingNewPlace = false;
                                        });
                                        if (value) {
                                          Get.back();
                                          Get.snackbar(
                                            'Saving Success',
                                            "The new Driver with his Car have been saved.",
                                            backgroundColor: Colors.green[900],
                                            colorText: Colors.white,
                                          );
                                        } else {
                                          Get.snackbar(
                                            'Saving Error',
                                            "Error occured while saving the new Driver.",
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
                title: "Drivers",
                button: ElevatedButton(
                  onPressed:
                      addNewDriver, // Replace 'Button' with your button text
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
                  child: const Text('New Driver'),
                ),
              ),
              height(context),
              LayoutBuilder(
                builder: (context, constraints) {
                  return const BuildTableUsers(users: UserType.driver);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
