import 'package:intl/intl.dart';

class UtilsFormatter {
  static decimalFormat(value) {
    return NumberFormat.decimalPattern('id_ID').format(value);
  }

  static currencyFormat(value) {
    return NumberFormat.currency(locale: 'id', symbol: 'Rp. ', decimalDigits: 0).format(value);
  }

  static String getCCNumber(String text) {
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static List<String> getCCMonthYear(String text) {
    return text.split('/');
  }
}
