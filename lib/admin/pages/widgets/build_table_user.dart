import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/admin/pages/widgets/place_manager.dart';
import 'package:taxi_driver_app/admin/pages/widgets/ride_manager.dart';
import 'package:taxi_driver_app/admin/pages/widgets/user_manager.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/Place_model.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/models/user/user_type_model.dart';
import 'package:taxi_driver_app/ui/utils/date_utlis.dart';

import 'package:taxi_driver_app/core/models/place_model.dart';

class BuildTableUsers extends StatefulWidget {
  const BuildTableUsers({required this.users, super.key});
  final UserType users;

  @override
  State<BuildTableUsers> createState() => _BuildTableUsersState();
}

class _BuildTableUsersState extends State<BuildTableUsers> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => DataTable(
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(label: Text('Full Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Phone Number')),
          ],
          rows: (widget.users == UserType.customer
                  ? userController.allCustomers
                  : userController.allDrivers)
              .map<DataRow>((userdata) => DataRow(
                    onSelectChanged: (bool? selected) {
                      if (selected != null && selected) {
                        UserManager(context).showUserDetails(userdata);
                      }
                    },
                    cells: <DataCell>[
                      DataCell(Text(userdata.full_name)),
                      DataCell(Text(userdata.email)),
                      DataCell(Text(userdata.phone_number)),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class RidesTable extends StatelessWidget {
  final List<RideModel> rides;

  const RidesTable({Key? key, required this.rides}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Customer')),
          DataColumn(label: Text('Driver')),
          DataColumn(label: Text('Fare')),
          DataColumn(label: Text('Start Time')),
          DataColumn(label: Text('End Time')),
          DataColumn(label: Text('Status')),
        ],
        rows: rides
            .map((ride) => DataRow(
                    onSelectChanged: (bool? selected) {
                      if (selected != null && selected) {
                        RideManager(context).showRideDetails(ride);
                      }
                    },
                    cells: [
                      DataCell(Text(ride.ride_id)),
                      DataCell(Text(ride.user
                          .full_name)), // Assuming UserModel has a fullName
                      DataCell(Text(ride.driver.full_name)),
                      DataCell(Text(ride.fare)),
                      DataCell(Text(formatDateUtilsNew(ride.start_time))),
                      DataCell(Text(ride.end_time != null
                          ? formatDateUtilsNew(ride.end_time!)
                          : 'N/A')),
                      DataCell(Text(ride.ride_status.name
                          .toUpperCase())), // Assuming RideStatus is an enum
                    ]))
            .toList(),
      ),
    );
  }
}

class PlacesTable extends StatelessWidget {
  const PlacesTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => DataTable(
          showCheckboxColumn: false,
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Address')),
            DataColumn(label: Text('Latitude')),
            DataColumn(label: Text('Longitude')),
            DataColumn(label: Text('Description')),
            DataColumn(label: Text('Photo URL')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Phone Number')),
            DataColumn(label: Text('Website')),
          ],
          rows: placesController.allPlaces.map((place) {
            return DataRow(
              onSelectChanged: (bool? selected) {
                if (selected != null && selected) {
                  PlaceManager(context).showPlaceDetails(place);
                }
              },
              cells: [
                DataCell(Text(place.name)),
                DataCell(Text(place.address)),
                DataCell(Text(place.latitude.toString())),
                DataCell(Text(place.longitude.toString())),
                DataCell(Text(place.description ?? '')),
                DataCell(Text(place.photo_url ?? '')),
                DataCell(Text(place.type_place ?? '')),
                DataCell(Text(place.phone_number ?? '')),
                DataCell(Text(place.website ?? '')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
