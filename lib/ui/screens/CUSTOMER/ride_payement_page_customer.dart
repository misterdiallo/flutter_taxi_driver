import 'package:flutter/material.dart';
import 'package:taxi_driver_app/core/controllers/controllers.dart';
import 'package:taxi_driver_app/core/models/payement_card.dart';
import 'package:taxi_driver_app/core/models/suggested_ride_model.dart';
import 'package:taxi_driver_app/core/services/payment_service.dart';

class RidePaymentPageCustomer extends StatefulWidget {
  final SuggestedRideModel rideDetails;
  final void Function(PaymentCardModel selectedPaymentMethod, bool success)
      onConfirmPayment;

  const RidePaymentPageCustomer({
    Key? key,
    required this.rideDetails,
    required this.onConfirmPayment,
  }) : super(key: key);

  @override
  State<RidePaymentPageCustomer> createState() =>
      _RidePaymentPageCustomerState();
}

class _RidePaymentPageCustomerState extends State<RidePaymentPageCustomer> {
  PaymentCardModel? _selectedPaymentMethod;
  bool _isProcessingPayment = false;

  Future<void> _confirmPayment() async {
    setState(() {
      _isProcessingPayment = true;
    });
    // Simulate a payment process (replace with actual logic)
    await Future.delayed(const Duration(seconds: 3));
    // Payment successful for demonstration purposes
    bool success = true;
    setState(() {
      _isProcessingPayment = false;
    });
    widget.onConfirmPayment(_selectedPaymentMethod!, success);
  }

  @override
  void initState() {
    super.initState();
    _selectedPaymentMethod = customerData.listOfMyDebit.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                'Select Payment Method',
                style: theme.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  color: theme.hintColor,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600
                        ? 3
                        : 2, // Adjust according to screen width
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 1, // Adjust aspect ratio as needed
                  ),
                  itemCount: customerData.listOfMyDebit.length,
                  itemBuilder: (context, index) {
                    final paymentMethod = customerData.listOfMyDebit[index];
                    return Card(
                      color: _selectedPaymentMethod == paymentMethod
                          ? theme.primaryColor.withOpacity(0.4)
                          : null,
                      child: ListTile(
                        title: Text(paymentMethod.cardNumber),
                        subtitle: Text(paymentMethod.type.name.toUpperCase()),
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = paymentMethod;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 15.0,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.15),
                    blurRadius: 2.0,
                    spreadRadius: 0.1,
                    offset: Offset(0, 2),
                  ),
                ],
                color: theme.primaryColor.withOpacity(0.4),
                // color: theme.scaffoldBackgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Total Ride Cost',
                          style: theme.textTheme.labelMedium!.copyWith(
                            fontSize: 13,
                            color: theme.hintColor,
                          ),
                        ),
                        Text(
                          '${widget.rideDetails.farePrice}',
                          style: theme.textTheme.bodyLarge!.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _confirmPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child: _isProcessingPayment
                            ? CircularProgressIndicator(
                                color: theme.scaffoldBackgroundColor,
                              )
                            : RichText(
                                text: TextSpan(
                                  text: "Confirm Payment\n",
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    fontSize: 18,
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'with ',
                                      children: [
                                        TextSpan(
                                          text:
                                              _selectedPaymentMethod!.type.name,
                                          style: theme.textTheme.labelMedium!
                                              .copyWith(
                                            fontSize: 13,
                                            color: theme.hintColor,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                      style:
                                          theme.textTheme.labelMedium!.copyWith(
                                        fontSize: 13,
                                        color: theme.hintColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
