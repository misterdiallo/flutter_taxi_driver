import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class VehicleSelection extends StatelessWidget {
  final String vehicleType;
  final String? farePrice;
  final String? argument;
  final String? duration;
  final Widget image;
  bool selected;
  final VoidCallback onTap;

  VehicleSelection({
    Key? key,
    required this.vehicleType,
    this.farePrice,
    this.argument,
    this.duration,
    required this.image,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: badges.Badge(
        showBadge: argument == null ? false : true,
        badgeAnimation: const badges.BadgeAnimation.fade(),
        badgeContent: argument != null ? Text(argument.toString()) : null,
        badgeStyle: badges.BadgeStyle(
            shape: badges.BadgeShape.square,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            badgeColor: theme.primaryColor),
        child: Container(
          height: 80.0,
          margin: const EdgeInsets.symmetric(
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.primaryColor,
              width: selected ? 2 : 0.5,
            ),
            borderRadius: BorderRadius.circular(
              6.0,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 10.0,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      vehicleType,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.monetization_on_outlined,
                                size: 17,
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                farePrice.toString(),
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: <Widget>[
                              const Icon(Icons.timer),
                              const SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                duration.toString(),
                                style: const TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 50.0,
                child: image,
              )
            ],
          ),
        ),
      ),
    );
  }
}
