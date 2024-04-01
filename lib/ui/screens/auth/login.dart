import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import '../../../core/controllers/auth/login_controller.dart';
import '../../../router.dart';
import '../../styles/colors.dart';
import '../../widgets/custom_text_form_field.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(RegisterRoute);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Sign Up",
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                "Log In",
                style: theme.textTheme.titleLarge!.merge(
                  const TextStyle(fontSize: 30.0),
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            _loginForm(context),
            // const SizedBox(height: 30.0),
            // _socialLoginButtons(theme),
          ],
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextFormField(
          controller: _loginController.emailController,
          hintText: "Email",
        ),
        const SizedBox(height: 20.0),
        CustomTextFormField(
          controller: _loginController.passwordController,
          hintText: "Password",
        ),
        // const SizedBox(height: 20.0),
        // GestureDetector(
        //   onTap: () {
        //     // Handle forgot password action
        //   },
        //   child: Text(
        //     "Forgot password?",
        //     style: TextStyle(
        //       color: theme.primaryColor,
        //       fontSize: 16.0,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        const SizedBox(height: 25.0),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
            ),
            onPressed: () =>
                loginController.isLoading.value ? {} : loginController.login(),
            child: Obx(() {
              if (loginController.isLoading.value) {
                return CircularProgressIndicator(
                  color: theme.scaffoldBackgroundColor,
                );
              } else {
                return const Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                );
              }
            }),
          ),
        ),
      ],
    );
  }

  Widget _socialLoginButtons(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          "Or connect using",
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10.0),
        ElevatedButton(
          onPressed: () {
            // Handle Facebook login
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: weChatColor,
          ),
          child: Row(
            children: <Widget>[
              const Icon(
                FontAwesomeIcons.webflow,
                color: Colors.white,
              ),
              Expanded(
                child: Text(
                  "Wechat",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge!.merge(
                    const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Container(
        //   //
        //   margin: const EdgeInsets.only(top: 10.0),
        //   height: 45.0,
        //   child: ElevatedButton(
        //     onPressed: () {
        //       // Handle phone number login
        //     },
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: theme.primaryColor,
        //     ),
        //     child: Row(
        //       children: <Widget>[
        //         Icon(
        //           FontAwesomeIcons.google,
        //           color: theme.scaffoldBackgroundColor,
        //         ),
        //         Expanded(
        //           child: Text(
        //             "Google",
        //             textAlign: TextAlign.center,
        //             style: theme.textTheme.bodyLarge!.merge(
        //               TextStyle(
        //                 fontWeight: FontWeight.bold,
        //                 color: theme.scaffoldBackgroundColor,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          // decoration: BoxDecoration(
          //   border: Border.all(
          //     color: theme.primaryColor,
          //   ),
          //   borderRadius: BorderRadius.circular(3.0),
          // ),
          margin: const EdgeInsets.only(top: 10.0),
          height: 45.0,
          child: ElevatedButton(
            onPressed: () {
              // Handle phone number login
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColorDark,
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: theme.scaffoldBackgroundColor,
                ),
                Expanded(
                  child: Text(
                    "Phone Number",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge!.merge(
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
