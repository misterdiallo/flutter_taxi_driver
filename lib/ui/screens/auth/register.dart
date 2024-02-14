import 'package:flutter/material.dart';
import 'package:taxi_driver_app/router.dart';

import '../../styles/colors.dart';
import '../../widgets/custom_text_form_field.dart';

class Register extends StatelessWidget {
  const Register({
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
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(LoginRoute);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Log In",
                style: TextStyle(
                  color: theme.primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Sign Up",
                  style: theme.textTheme.headlineSmall!.merge(
                    const TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              _signupForm(),
              const SizedBox(
                height: 30.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(bottom: 30.0),
                height: 45.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(OtpVerificationRoute);
                  },
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupForm() {
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
        Row(
          children: <Widget>[
            SizedBox(
              width: 80.0,
              child: CustomTextFormField(
                hintText: "Country",
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: CustomTextFormField(
                hintText: "Phone number",
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        CustomTextFormField(
          hintText: "Password",
        ),
        SizedBox(
          height: 25.0,
        ),
        Text(
          "By clicking \"Sign Up\" you agree to our terms and conditions as well as our privacy policy",
          style: TextStyle(fontWeight: FontWeight.bold, color: dbasicDarkColor),
        )
      ],
    );
  }
}
