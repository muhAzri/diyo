import 'package:intl/intl.dart';

String formatCurrency(num number) {
  return NumberFormat.currency(
    decimalDigits: 0,
    symbol: '',
  ).format(number);
}
