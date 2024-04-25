import 'package:intl/intl.dart'; // Import intl package

class MoneyFormatter {
  static String formatStringToMoney(String amount) {
    // Assuming amount is in decimal format, e.g., "1234.56"
    double parsedAmount = double.tryParse(amount) ?? 0.0;

    // Create a NumberFormat instance to format currency
    NumberFormat formatter =
        NumberFormat.currency(locale: 'zh_CN', symbol: '¥');

    // Format the amount and return
    return formatter.format(parsedAmount);
  }

  static double calculateTotalFare(List<String> fareStrings) {
    double totalFare = 0.0;
    for (var fareString in fareStrings) {
      totalFare += double.parse(fareString);
    }
    return totalFare;
  }
}
