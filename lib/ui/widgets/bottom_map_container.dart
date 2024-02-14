import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_driver_app/router.dart';

class HomeMapBottom extends StatelessWidget {
  final ThemeData theme;
  const HomeMapBottom({required this.theme, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(
                0,
                0,
                0,
                0.15,
              ),
              blurRadius: 25.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Where are you going to?",
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            const Text(
              "Book on demand or pre-scheduled rides",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            InkWell(
              onTap: () {
                Get.toNamed(DestinationRoute);
              },
              child: Hero(
                tag: "search",
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: const Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Enter Destination",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.search,
                      )
                    ],
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
