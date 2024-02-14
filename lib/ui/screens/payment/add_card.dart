import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/custom_text_form_field.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Add Credit Card",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 50.0),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
              ),
              icon: const Icon(
                FontAwesomeIcons.expand,
                size: 18.0,
              ),
              label: const Text(
                "SCAN CARD",
                style: TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30.0),
            const CustomTextFormField(
              hintText: "NAME",
              value: "Olayemii Garuba",
            ),
            const SizedBox(height: 25.0),
            const CustomTextFormField(
              hintText: "CREDIT CARD NUMBER",
              value: "**** **** **** **85",
            ),
            const SizedBox(height: 25.0),
            const Row(
              children: <Widget>[
                Expanded(
                  child: CustomTextFormField(
                    hintText: "EXPIRY",
                    value: "09/25",
                  ),
                ),
                SizedBox(width: 30.0),
                Expanded(
                  child: CustomTextFormField(
                    hintText: "CVV",
                    value: "***",
                  ),
                ),
              ],
            ),
            const Text(
              "Debit cards are accepted at some locations and for some categories",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset("assets/images/mastercard.png"),
                Image.asset("assets/images/visa.png"),
              ],
            ),
            const SizedBox(height: 25.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor),
                child: const Text(
                  "SAVE",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
