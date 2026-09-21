import 'package:get/get.dart';

class AppException implements Exception{
  final String message;
  AppException(this.message);
}


class NoInternetException extends AppException{
  NoInternetException() : super('no_internet_connection'.tr);
}

class AuthException extends AppException{
  AuthException(super.message);
}

class DebtorException extends AppException{
  DebtorException(super.message);
}

class DebtException extends AppException{
  DebtException(super.message);
}
class InstallmentException extends AppException{
  InstallmentException(super.message);
}