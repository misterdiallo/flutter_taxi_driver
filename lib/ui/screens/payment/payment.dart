import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';

import '../../../core/models/debit_card_model.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/card_container.dart';

class Payment extends StatelessWidget {
  const Payment({
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
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(
          "Payment methods",
          style: theme.textTheme.titleLarge,
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            children: [
              Builder(builder: (context) {
                if (customerData.listOfMyRides.isNotEmpty) {
                  return ListView.builder(
                      itemCount: customerData.listOfMyDebit.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 5.0,
                          ),
                          child: CardContainer(
                              cardDetail: customerData.listOfMyDebit[index]),
                        );
                      });
                } else {
                  return const Center(
                    child: Text("-- Empty --"),
                  );
                }
              }),

              // const SizedBox(
              //   height: 15.0,
              // ),
              // Card(
              //   margin: const EdgeInsets.all(0.0),
              //   child: ListTile(
              //     contentPadding: const EdgeInsets.symmetric(
              //         horizontal: 15.0, vertical: 20.0),
              //     leading: Icon(
              //       Icons.credit_card,
              //       size: 50.0,
              //       color: theme.colorScheme.secondary,
              //     ),
              //     title: const Text(
              //       "Cash payment",
              //       style: TextStyle(
              //         fontSize: 19.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     subtitle: const Text(
              //       "Default method",
              //       style: TextStyle(
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     trailing: Transform.scale(
              //       scale: 1.5,
              //       child: Checkbox(
              //         value: true,
              //         activeColor: theme.primaryColor,
              //         onChanged: (value) {},
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 15.0,
              // ),
              // Text(
              //   "Choose a different payment method from a list of already set up payment methods.",
              //   style: theme.textTheme.bodyLarge!.merge(
              //     const TextStyle(fontSize: 14.0),
              //   ),
              // ),
              // const SizedBox(
              //   height: 15.0,
              // ),
              // Expanded(
              //   child: Column(
              //     children: cards.map(
              //       (card) {
              //         return Container(
              //           margin: const EdgeInsets.symmetric(
              //             vertical: 5.0,
              //           ),
              //           child: CardContainer(cardDetail: card),
              //         );
              //       },
              //     ).toList(),
              //   ),
              // ),
              Positioned(
                bottom: 15,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 45.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    onPressed: () {},
                    child: Text(
                      "ADD PAYMENT METHOD",
                      style: TextStyle(
                          color: theme.scaffoldBackgroundColor, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
