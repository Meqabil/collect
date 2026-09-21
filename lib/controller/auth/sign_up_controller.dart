
import 'package:collect/core/errors/app_exception.dart';
import 'package:collect/core/routes/app_routes.dart';
import 'package:collect/data/datasource/auth/SignUp_datasource.dart';
import 'package:collect/view/widgets/errors/error_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../view/screens/home/home_screen.dart';

abstract class SignUpController extends GetxController {

  void signUp();
}

class SignUpControllerImpl extends SignUpController{
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SignUpData signUpData = SignUpData();
  RxBool loading = false.obs;
  @override
  signUp() async {
    if(loading.value) return;
    loading.value = true;
    update();
    try{
      await signUpData.signUp(name: nameController.text.trim(), email: emailController.text.trim(), password: passwordController.text.trim());
      prefs!.setString("logged_in","yes");
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      Get.off(() => HomeScreen());
    } on NoInternetException {
      Get.toNamed(AppRoutes.noInternetConnection);
    } on AuthException catch (e){
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        content: ErrorDialog(message: e.message)
      );
    } catch (e){
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        content: ErrorDialog(message: e.toString())
      );
    }
    loading.value = false;
  }


  @override
  void onClose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

}