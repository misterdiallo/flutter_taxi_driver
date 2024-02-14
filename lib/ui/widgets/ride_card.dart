import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  const RideCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      child: Card(
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Today, 10:30 AM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                height: 170.0,
                color: Colors.red,
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(
                  left: 0.0,
                ),
                title: const Text(
                  "TOYOTA CAMRY",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.pin_drop,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    const Text(
                      "Home - Awolowo Rd.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    const Text(
                      "Price",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "\$45.00",
                      style: TextStyle(
                        fontSize: 24.0,
                        color: theme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
