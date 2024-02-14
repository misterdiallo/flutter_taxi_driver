import 'package:flutter/material.dart';

import '../../widgets/custom_text_form_field.dart';

class PhoneRegistration extends StatelessWidget {
  const PhoneRegistration({
    super.key,
  });

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
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "What is your phone number?",
                      style: theme.textTheme.titleLarge!.merge(
                        const TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  const Text(
                    "Tap \"Get Started\" to get an SMS confirmation to help you use UBERR. We would like to get your phone number.",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: CustomTextFormField(
                          hintText: "+234",
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomTextFormField(
                          hintText: "Country Code",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 45.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                onPressed: () {},
                child: Text(
                  "GET STARTED",
                  style: theme.textTheme.bodyMedium!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
