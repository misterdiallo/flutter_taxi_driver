import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  bool isLightTheme = true;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add New Payment'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CreditCardWidget(
                  enableFloatingCard: useFloatingAnimation,
                  glassmorphismConfig: _getGlassmorphismConfig(),
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  bankName: 'Bank Card',
                  frontCardBorder:
                      useGlassMorphism ? null : Border.all(color: Colors.grey),
                  backCardBorder:
                      useGlassMorphism ? null : Border.all(color: Colors.grey),
                  showBackView: isCvvFocused,
                  obscureCardNumber: false,
                  obscureCardCvv: false,
                  isHolderNameVisible: true,
                  backgroundImage:
                      useBackgroundImage ? 'assets/images/card_bg.png' : null,
                  isSwipeGestureEnabled: true,
                  onCreditCardWidgetChange:
                      (CreditCardBrand creditCardBrand) {},
                  customCardTypeIcons: <CustomCardTypeIcon>[
                    CustomCardTypeIcon(
                      cardType: CardType.mastercard,
                      cardImage: Image.asset(
                        'assets/images/mastercard.png',
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: false,
                          obscureNumber: false,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          inputConfiguration: const InputConfiguration(
                            cardNumberDecoration: InputDecoration(
                              labelText: 'Card Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                            ),
                            expiryDateDecoration: InputDecoration(
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: InputDecoration(
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              labelText: 'Card Holder Name',
                            ),
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                          ),
                          onPressed: _onValidate,
                          icon: const Icon(Icons.save_rounded),
                          label: const Text("SAVE NEW CARD"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onValidate() {
    if (formKey.currentState?.validate() ?? false) {
      print('valid!');
    } else {
      print('invalid!');
    }
  }

  Glassmorphism? _getGlassmorphismConfig() {
    if (!useGlassMorphism) {
      return null;
    }

    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
      stops: const <double>[0.3, 0],
    );

    return isLightTheme
        ? Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient)
        : Glassmorphism.defaultConfig();
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
