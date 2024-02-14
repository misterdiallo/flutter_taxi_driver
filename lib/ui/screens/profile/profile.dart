import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import '../../styles/colors.dart';
import '../../widgets/custom_text_form_field.dart';

class Profile extends StatelessWidget {
  const Profile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.times),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Profile",
                    style: theme.textTheme.headlineSmall!
                        .merge(const TextStyle(fontSize: 26.0)),
                  ),
                  const CircleAvatar(
                    radius: 25.0,
                    child: Icon(Icons.sick),
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              CustomTextFormField(
                hintText: "Name",
                value: authController.fullName,
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: "Email",
                value: authController.email,
                suffixIcon: Icon(
                  Icons.check_circle,
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: "Phone Number",
                value: authController.phoneNumber,
              ),
              const SizedBox(
                height: 15.0,
              ),

              // Container(
              //   decoration: BoxDecoration(
              //     color: const Color(0xffFBFBFD),
              //     border: Border.all(
              //       color: const Color(0xffD6D6D6),
              //     ),
              //   ),
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 10.0,
              //     vertical: 20.0,
              //   ),
              //   child: Column(
              //     children: <Widget>[
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: <Widget>[
              //           const Expanded(
              //             child: Text(
              //               "RECEIVE RECEIPT MAILS",
              //               style: TextStyle(
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //           Switch(
              //             value: true,
              //             activeColor: theme.primaryColor,
              //             onChanged: (bool state) {},
              //           )
              //         ],
              //       ),
              //       const Text(
              //         "The switch is the widget used to achieve the popular.",
              //         style: TextStyle(color: Colors.grey),
              //       )
              //     ],
              //   ),
              // ),
              // Container(
              //   decoration: const BoxDecoration(
              //     color: Color(0xffFBFBFD),
              //   ),
              //   padding: const EdgeInsets.symmetric(
              //     vertical: 20.0,
              //   ),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       const Text(
              //         "SOCIAL NETWORK",
              //         style: TextStyle(
              //           fontWeight: FontWeight.w700,
              //           fontSize: 14.0,
              //           color: Color(0xFF9CA4AA),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 10.0,
              //       ),
              //       SizedBox(
              //         height: 45.0,
              //         child: ElevatedButton.icon(
              //           onPressed: () {},
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: facebookColor,
              //           ),
              //           icon: const Icon(
              //             FontAwesomeIcons.facebookSquare,
              //             color: Colors.white,
              //           ),
              //           label: Expanded(
              //             child: Text(
              //               "Connect with Facebook",
              //               textAlign: TextAlign.center,
              //               style: theme.textTheme.bodyMedium!.merge(
              //                 const TextStyle(
              //                   fontWeight: FontWeight.w500,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         decoration: BoxDecoration(
              //             border: Border.all(
              //               color: theme.primaryColor,
              //             ),
              //             borderRadius: BorderRadius.circular(3.0)),
              //         margin: const EdgeInsets.only(top: 10.0),
              //         height: 45.0,
              //         child: ElevatedButton.icon(
              //           onPressed: () {},
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: theme.scaffoldBackgroundColor,
              //           ),
              //           icon: Icon(
              //             FontAwesomeIcons.google,
              //             size: 18.0,
              //             color: theme.primaryColor,
              //           ),
              //           label: Expanded(
              //             child: Text(
              //               "Connect with Google",
              //               textAlign: TextAlign.center,
              //               style: theme.textTheme.bodyMedium!.merge(
              //                 TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: theme.primaryColor,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
