import 'package:intl/intl.dart';

extension StringExtensions on String {
  String formatPrice() {
    try {
      return NumberFormat('###,###,###,##0').format(int.parse(this));
    } on Exception catch (e) {
      return this;
    }
  }
}
