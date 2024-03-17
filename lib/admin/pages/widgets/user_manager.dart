import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/custom_popup.dart';
import 'package:taxi_driver_app/core/models/user/user_model.dart';

class UserManager {
  final BuildContext context;

  UserManager(this.context);
  Widget buildTable(BuildContext context, List<UserModel> users) =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(label: Text('Full Name')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Phone Number')),
          ],
          rows: users
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

  void showUserDetails(UserModel user) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${user.fullName}'s Details"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text("Email"),
                  subtitle: Text(user.email),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text("Phone Number"),
                  subtitle: Text(user.phoneNumber),
                ),
                // Additional details can be added here
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => editUserDetails(user),
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
              child: const Text('Edit'),
            ),
            TextButton(
              onPressed: () => viewUserHistory(user),
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              child: const Text('History'),
            ),
            TextButton(
              onPressed: () => deactivateUser(user),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Deactivate'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void editUserDetails(UserModel user) {
    // Implementation to edit user details
  }

  void viewUserHistory(UserModel user) {
    // Implementation to view user's history
  }

  void deactivateUser(UserModel user) {
    // Show a confirmation dialog before deactivation
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Deactivate User"),
          content:
              Text("Are you sure you want to deactivate ${user.fullName}?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Deactivate"),
              onPressed: () {
                // Here you would usually update the user's status in your database
                // For demonstration, we'll just print to the console
                Navigator.of(dialogContext).pop();
                showCustomPopup(
                    context, "${user.fullName} has been deactivated");
              },
            ),
          ],
        );
      },
    );
  }
}
