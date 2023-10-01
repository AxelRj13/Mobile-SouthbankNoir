import 'package:intl/intl.dart';

class UtilsFormatter {
  static decimalFormat(value) {
    return NumberFormat.decimalPattern('id_ID').format(value);
  }
}
