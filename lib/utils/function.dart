import 'package:easy_localization/easy_localization.dart';

bool isEmailValid(String email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isPhoneValid(String phone, String isoCode) {
  switch (isoCode.toUpperCase()) {
    case 'EG': // مصر
      return RegExp(r'^(01)[0-9]{9}$').hasMatch(phone);
    case 'SA': // السعودية
      return RegExp(r'^(05)[0-9]{8}$').hasMatch(phone);
    case 'AE': // الإمارات
      return RegExp(r'^(05)[0-9]{8}$').hasMatch(phone);
    case 'JO': // الأردن
      return RegExp(r'^(07)[789][0-9]{7}$').hasMatch(phone);
    case 'KW': // الكويت
      return RegExp(r'^(5|6|9)[0-9]{7}$').hasMatch(phone);
    case 'QA': // قطر
      return RegExp(r'^(3|5|6|7)[0-9]{7}$').hasMatch(phone);
    case 'OM': // عمان
      return RegExp(r'^(9)[0-9]{7}$').hasMatch(phone);
    case 'BH': // البحرين
      return RegExp(r'^(3)[0-9]{7}$').hasMatch(phone);
    case 'LB': // لبنان
      return RegExp(r'^(03|70|71|76|78|79|81)[0-9]{6}$').hasMatch(phone);
    case 'IQ': // العراق
      return RegExp(r'^(07)[0-9]{9}$').hasMatch(phone);
    case 'MA': // المغرب
      return RegExp(r'^(06|07)[0-9]{8}$').hasMatch(phone);
    case 'TN': // تونس
      return RegExp(r'^[2459][0-9]{7}$').hasMatch(phone);
    case 'DZ': // الجزائر
      return RegExp(r'^(05|06|07)[0-9]{8}$').hasMatch(phone);
    case 'YE': // اليمن
      return RegExp(r'^(7)[0-9]{8}$').hasMatch(phone);
    default:
      return phone.length >= 8;
  }
}

extension DateTimeFormat on DateTime {
  String toFormattedDate() {
    return DateFormat("d MMMM yyyy").format(this); // For "16 March 2025"
  }

  String toFormattedTime() {
    return DateFormat("hh:mm a").format(this); // For "08:00 AM" or "08:00 PM"
  }
}