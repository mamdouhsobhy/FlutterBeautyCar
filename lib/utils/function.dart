import 'package:easy_localization/easy_localization.dart';

bool isEmailValid(String email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isPhoneValid(String phone, String countryCode) {
  switch (countryCode) {
    case '+20': // مصر
      return RegExp(r'^(01)[0-9]{9}$').hasMatch(phone);
    case '+966': // السعودية
      return RegExp(r'^(05)[0-9]{8}$').hasMatch(phone);
    case '+971': // الإمارات
      return RegExp(r'^(05)[0-9]{8}$').hasMatch(phone);
    case '+962': // الأردن
      return RegExp(r'^(07)[789][0-9]{7}$').hasMatch(phone);
    case '+965': // الكويت
      return RegExp(r'^(5|6|9)[0-9]{7}$').hasMatch(phone);
    case '+974': // قطر
      return RegExp(r'^(3|5|6|7)[0-9]{7}$').hasMatch(phone);
    case '+968': // عمان
      return RegExp(r'^(9)[0-9]{7}$').hasMatch(phone);
    case '+973': // البحرين
      return RegExp(r'^(3)[0-9]{7}$').hasMatch(phone);
    case '+961': // لبنان
      return RegExp(r'^(03|70|71|76|78|79|81)[0-9]{6}$').hasMatch(phone);
    case '+964': // العراق
      return RegExp(r'^(07)[0-9]{9}$').hasMatch(phone);
    case '+212': // المغرب
      return RegExp(r'^(06|07)[0-9]{8}$').hasMatch(phone);
    case '+216': // تونس
      return RegExp(r'^[2459][0-9]{7}$').hasMatch(phone);
    case '+213': // الجزائر
      return RegExp(r'^(05|06|07)[0-9]{8}$').hasMatch(phone);
    case '+967': // اليمن
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