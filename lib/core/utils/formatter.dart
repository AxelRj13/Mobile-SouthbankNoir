import 'package:intl/intl.dart';

class UtilsFormatter {
  static decimalFormat(value) {
    return NumberFormat.decimalPattern('id_ID').format(value);
  }

  static currencyFormat(value) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(value);
  }
}
