import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/router.dart';
import 'package:taxi_driver_app/ui/widgets/custom_text_form_field.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});

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
                      "Verify Phone Number",
                      style: theme.textTheme.titleLarge!.merge(
                        const TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                  const Text(
                    "Check your SMS messages, We've sent an OTP to your email and phone number",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: List.generate(
                      4,
                      (index) => const Expanded(
                        child: CustomTextFormField(
                          hintText: "",
                          verticalPadding: 25.0,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Wrap(
                    children: <Widget>[
                      const Text(
                        "Didn't receive SMS?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Resend Code",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.primaryColor,
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
                onPressed: () {
                  Get.offAllNamed(InitialRoute);
                },
                child: Text(
                  "VERIFY",
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
