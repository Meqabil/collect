import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collect/core/errors/app_exception.dart';
import 'package:get/get.dart';

import '../../view/widgets/errors/error_dialog.dart';

void handleFirestoreError(String operation, FirebaseException e) {
  String clientMessage = "db_err_unknown".tr;
  print("Firestore Error during $operation: [${e.code}] -> $clientMessage");
  switch (e.code) {
    case 'permission-denied':
      clientMessage = 'db_err_permission_denied'.tr;
      break;
    case 'not-found':
      clientMessage = "db_err_not_found".tr;
      break;
    case 'unavailable':
      clientMessage = 'no_internet_connection'.tr;
      throw NoInternetException();
    case 'failed-precondition':
      clientMessage = "db_err_failed_precondition".tr;
      break;
    case 'resource-exhausted':
      clientMessage = "db_err_resource_exhausted".tr;
      break;
    default:
      clientMessage = e.message ?? clientMessage;
  }
  print("Firestore Error during $operation: [${e.code}] -> $clientMessage");
  Get.defaultDialog(
    title: '',
    titleStyle: TextStyle(fontSize: 0),
    content: ErrorDialog(message: clientMessage)
  );
  throw Exception(clientMessage);
}
