import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/auth/login_controller.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/custom_popup.dart';
import 'package:taxi_driver_app/router.dart';

import '../../styles/colors.dart';
import '../../widgets/custom_text_form_field.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final LoginController signInController = Get.put(LoginController());

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
                  onPressed: () => signInController.isLoading.value
                      ? {}
                      : signInController.register(),
                  child: Obx(() {
                    if (signInController.isLoading.value) {
                      return CircularProgressIndicator(
                        color: theme.scaffoldBackgroundColor,
                      );
                    } else {
                      return const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      );
                    }
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signupForm() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: CustomTextFormField(
                hintText: "Full Name",
                controller: signInController.fullNameController,
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: CustomTextFormField(
                hintText: "Email",
                controller: signInController.emailController,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: CustomTextFormField(
                hintText: "Password",
                controller: signInController.passwordController,
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: CustomTextFormField(
                hintText: "Phone number",
                keyboardType: TextInputType.phone,
                controller: signInController.phoneController,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
