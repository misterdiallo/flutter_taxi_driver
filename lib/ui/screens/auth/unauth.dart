import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../router.dart';
import '../../styles/colors.dart';

class UnAuth extends StatelessWidget {
  const UnAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(),
                child: Image.asset("assets/images/bg.png"),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 250.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                          ),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(LoginRoute);
                          },
                        ),
                      ),
                      const SizedBox(width: 40.0),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: facebookColor,
                          ),
                          child: const Text(
                            "REGISTER",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(RegisterRoute);
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: theme.primaryColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: const Text(
                          "Or connect with social",
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: theme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    height: 45.0,
                    decoration: BoxDecoration(
                      color: weChatColor,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: const Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.webflow,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Text(
                            "Login with Wechat",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    height: 45.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.primaryColor),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.google,
                          color: theme.primaryColor,
                        ),
                        Expanded(
                          child: Text(
                            "Login with Google",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
