import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/models/payement_card.dart';
import 'package:taxi_driver_app/core/services/payment_service.dart';

import 'add_new_card.dart';
import 'payment_card_widget.dart';

class PaymentListCardPage extends StatefulWidget {
  const PaymentListCardPage({Key? key}) : super(key: key);

  @override
  State<PaymentListCardPage> createState() => _PaymentListCardPageState();
}

class _PaymentListCardPageState extends State<PaymentListCardPage> {
  bool isSelectionModeEnabled = false;
  List<bool> isSelected =
      List.generate(listPaymentCards.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    int selectedCount = isSelected.where((isSelected) => isSelected).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(isSelectionModeEnabled
            ? '$selectedCount Selected'
            : 'Payment Cards'),
        actions: [
          if (!isSelectionModeEnabled) // Show only when not in selection mode
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // Navigate to the "Add New Card" page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNewCard()),
                );
              },
            ),
          IconButton(
            icon: isSelectionModeEnabled
                ? const Icon(Icons.close)
                : const Icon(Icons.select_all_outlined),
            onPressed: () {
              setState(() {
                isSelectionModeEnabled = !isSelectionModeEnabled;

                // If exiting selection mode, clear the selected items
                if (!isSelectionModeEnabled) {
                  isSelected =
                      List.generate(listPaymentCards.length, (index) => false);
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 550.0, // Adjust this value as needed
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            mainAxisExtent: 205,
          ),
          itemCount: listPaymentCards.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (isSelectionModeEnabled) {
                  setState(() {
                    isSelected[index] = !isSelected[index];
                  });
                }
              },
              child: Row(
                children: [
                  isSelectionModeEnabled
                      ? PaymentCardWidget(
                          isSelected: isSelected[index],
                          cardInfo: listPaymentCards[index])
                      : GestureDetector(
                          onTap: () {
                            print(
                                'open card ${listPaymentCards[index].cardNumber}');
                          },
                          child: PaymentCardWidget(
                            isSelected: isSelected[index],
                            cardInfo: listPaymentCards[index],
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: isSelectionModeEnabled && selectedCount > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                _showDeleteConfirmationDialog();
              },
              icon: const Icon(Icons.delete),
              label: Text('Delete $selectedCount'),
            )
          : null,
    );
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Selected Cards'),
          content:
              const Text('Are you sure you want to delete the selected cards?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteSelectedCards();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSelectedCards() {
    List<PaymentCardModel> updatedList = [];

    for (int i = 0; i < isSelected.length; i++) {
      if (!isSelected[i]) {
        updatedList.add(listPaymentCards[i]);
      }
    }

    setState(() {
      listPaymentCards = updatedList;
      isSelected = List.generate(listPaymentCards.length, (index) => false);
      isSelectionModeEnabled = false;
    });
  }
}
