import 'package:collect/controller/auth/login_controller.dart';
import 'package:collect/controller/auth/sign_up_controller.dart';
import 'package:collect/controller/debts/debts_controller.dart';
import 'package:collect/controller/debtors/debtor_controller.dart';
import 'package:collect/controller/theme/theme_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controller/installments/installments_controller.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(SignUpControllerImpl(),);
    Get.put(LoginControllerImpl(),);
    Get.put(ThemeControllerImpl(),);
    Get.put(DebtorControllerImpl());
    Get.put(DebtsControllerImpl());
    Get.put(InstallmentsControllerImpl());
  }
}