import 'package:flutter/material.dart';

class SmallUserProfileCard extends StatelessWidget {
  final Color? cardColor;
  final double? cardRadius;
  final VoidCallback? onTap;
  final String? userName;
  final Widget? userMoreInfo;
  final Widget? userTraillingButton;
  final ImageProvider userProfilePic;
  final ThemeData theme;

  const SmallUserProfileCard({
    super.key,
    required this.cardColor,
    this.cardRadius = 30,
    required this.userName,
    this.userMoreInfo,
    this.userTraillingButton,
    required this.userProfilePic,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueryHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius:
              BorderRadius.circular(double.parse(cardRadius!.toString())),
        ),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: userProfilePic,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userName!,
                            style: theme.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          if (userMoreInfo != null) ...[
                            const SizedBox(
                              height: 5,
                            ),
                            userMoreInfo!,
                          ]
                        ],
                      ),
                    ),
                  ),
                  if (userTraillingButton != null) ...[
                    userTraillingButton!,
                    const SizedBox(
                      width: 10,
                    )
                  ]
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
