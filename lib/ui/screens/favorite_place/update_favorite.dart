import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../../widgets/custom_text_form_field.dart';

class UpdateFavorite extends StatelessWidget {
  const UpdateFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        centerTitle: true,
        title: const Text(
          "Update Profile",
          style: TextStyle(color: dbasicDarkColor),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildFlatButton("Home", Icons.home),
                _buildFlatButton("Work", Icons.work),
                _buildFlatButton("Other", Icons.pin_drop),
              ],
            ),
            const SizedBox(
              height: 70.0,
            ),
            const CustomTextFormField(
              hintText: "Place name",
              value: "McDonald's",
            ),
            const SizedBox(
              height: 25.0,
            ),
            const CustomTextFormField(
              hintText: "Place address",
              value: "13424 NE 20th St. Bellevue, WA, 98005",
            ),
            const SizedBox(
              height: 25.0,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.map,
                color: Colors.white,
              ),
              label: const Text(
                "PICK ON MAP",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Container(
              color: Colors.yellow,
              height: 40.0,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                child: const Text(
                  "SAVE LOCATION",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlatButton(String label, IconData icon) {
    return Container(
      height: 35.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: TextButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
