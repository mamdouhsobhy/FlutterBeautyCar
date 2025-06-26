import 'package:easy_localization/easy_localization.dart';

bool isEmailValid(String email) {
  return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

bool isPhoneValid(String phone, String countryCode) {
  switch (countryCode) {
    case '+20': // مصر
      return RegExp(r'^(1)[0-9]{9}$').hasMatch(phone);
    case '+966': // السعودية
      return RegExp(r'^(5)[0-9]{8}$').hasMatch(phone);
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

String? getCountryCode(String phone) {
  if (phone.startsWith('+20')) return '+20'; // مصر
  if (phone.startsWith('+966')) return '+966'; // السعودية
  if (phone.startsWith('+971')) return '+971'; // الإمارات
  if (phone.startsWith('+962')) return '+962'; // الأردن
  if (phone.startsWith('+965')) return '+965'; // الكويت
  if (phone.startsWith('+974')) return '+974'; // قطر
  if (phone.startsWith('+968')) return '+968'; // عمان
  if (phone.startsWith('+973')) return '+973'; // البحرين
  if (phone.startsWith('+961')) return '+961'; // لبنان
  if (phone.startsWith('+964')) return '+964'; // العراق
  if (phone.startsWith('+212')) return '+212'; // المغرب
  if (phone.startsWith('+216')) return '+216'; // تونس
  if (phone.startsWith('+213')) return '+213'; // الجزائر
  if (phone.startsWith('+967')) return '+967'; // اليمن
  return null; // Return null if no matching country code is found
}

String? getIsoCode(String phone) {
  if (phone.startsWith('+20')) return 'EG'; // مصر
  if (phone.startsWith('+966')) return 'SA'; // السعودية
  if (phone.startsWith('+971')) return 'AE'; // الإمارات
  if (phone.startsWith('+962')) return 'JO'; // الأردن
  if (phone.startsWith('+965')) return 'KW'; // الكويت
  if (phone.startsWith('+974')) return 'QA'; // قطر
  if (phone.startsWith('+968')) return 'OM'; // عمان
  if (phone.startsWith('+973')) return 'BH'; // البحرين
  if (phone.startsWith('+961')) return 'LB'; // لبنان
  if (phone.startsWith('+964')) return 'IQ'; // العراق
  if (phone.startsWith('+212')) return 'MA'; // المغرب
  if (phone.startsWith('+216')) return 'TN'; // تونس
  if (phone.startsWith('+213')) return 'DZ'; // الجزائر
  if (phone.startsWith('+967')) return 'YE'; // اليمن
  return null; // Return null if no matching country code is found
}

extension DateTimeFormat on DateTime {
  String toFormattedDate() {
    return DateFormat("d MMMM yyyy").format(this); // For "16 March 2025"
  }

  String toFormattedTime() {
    return DateFormat("hh:mm a").format(this); // For "08:00 AM" or "08:00 PM"
  }
}