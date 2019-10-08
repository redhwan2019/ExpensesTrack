import 'package:date_format/date_format.dart';
import 'package:image_picker/image_picker.dart';

class HelperService {
  String defaultDate(DateTime date) {
    return formatDate(date, ['dd', ' ', 'M', ' ', 'yyyy']);
  }

  double countTotal(List listTransaction) {
    double total = 0;
    listTransaction.forEach((item) {
      total += double.parse(item['amount']);
    });
    return total;
  }
}
