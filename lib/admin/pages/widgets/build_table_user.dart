import 'package:flutter/material.dart';
import 'package:taxi_driver_app/admin/pages/widgets/ride_manager.dart';
import 'package:taxi_driver_app/admin/pages/widgets/user_manager.dart';
import 'package:taxi_driver_app/core/models/ride_model.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';
import 'package:taxi_driver_app/ui/utils/conversion_utils.dart';
import 'package:taxi_driver_app/ui/utils/date_utlis.dart';

class BuildTableUsers extends StatefulWidget {
  const BuildTableUsers({required this.users, super.key});
  final List<UserModel> users;

  @override
  State<BuildTableUsers> createState() => _BuildTableUsersState();
}

class _BuildTableUsersState extends State<BuildTableUsers> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        showCheckboxColumn: false,
        columns: const <DataColumn>[
          DataColumn(label: Text('Full Name')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Phone Number')),
        ],
        rows: widget.users
            .map<DataRow>((driver) => DataRow(
                  onSelectChanged: (bool? selected) {
                    if (selected != null && selected) {
                      UserManager(context).showUserDetails(driver);
                    }
                  },
                  cells: <DataCell>[
                    DataCell(Text(driver.fullName)),
                    DataCell(Text(driver.email)),
                    DataCell(Text(driver.phoneNumber)),
                  ],
                ))
            .toList(),
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
                      DataCell(Text(ride.rideId)),
                      DataCell(Text(ride
                          .user.fullName)), // Assuming UserModel has a fullName
                      DataCell(Text(ride.driver.fullName)),
                      DataCell(Text(ride.fare)),
                      DataCell(Text(formatDateUtilsNew(ride.startTime))),
                      DataCell(Text(ride.endTime != null
                          ? formatDateUtilsNew(ride.endTime!)
                          : 'N/A')),
                      DataCell(Text(ride.rideStatus.name
                          .toUpperCase())), // Assuming RideStatus is an enum
                    ]))
            .toList(),
      ),
    );
  }
}
