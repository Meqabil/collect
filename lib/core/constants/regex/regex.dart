
import 'package:get/get.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'email_is_required'.tr;
  }
  // The regular expression for email validation
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  if (!emailRegex.hasMatch(value)) {
    return 'valid_email'.tr;
  }
  return null;
}


String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'password_is_required'.tr;
  }
  // Requires at least 8 characters and 1 number
  final passwordRegex = RegExp(r'^(?=.*[0-9]).{8,}$');

  if (!passwordRegex.hasMatch(value)) {
    return 'valid_password'.tr;
  }

  return null;
}
