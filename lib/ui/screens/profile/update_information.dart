import 'package:flutter/material.dart';

import '../../widgets/custom_text_form_field.dart';

class UpdateInformation extends StatelessWidget {
  const UpdateInformation({
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Update Information",
                      style: theme.textTheme.titleLarge!.merge(
                        const TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  _updateProfileForm(),
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
                child: const Text(
                  "SAVE INFORMATION",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _updateProfileForm() {
    return const Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: CustomTextFormField(
                hintText: "First name",
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: CustomTextFormField(
                hintText: "Last name",
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        CustomTextFormField(
          hintText: "Email",
        ),
        SizedBox(
          height: 20.0,
        ),
        CustomTextFormField(
          hintText: "Password",
        ),
      ],
    );
  }
}
