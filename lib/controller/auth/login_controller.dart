import 'package:collect/core/errors/app_exception.dart';
import 'package:collect/core/routes/app_routes.dart';
import 'package:collect/core/security/key_service.dart';
import 'package:collect/data/datasource/auth/login_datasource.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../view/widgets/errors/error_dialog.dart';

abstract class LoginController  extends GetxController{

  Future<void> login();
  Future<void> loginWithGoogle();
  Future<void> sendResetPassword(String email);
  void signOut();
}

class LoginControllerImpl extends LoginController{
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginData loginData = LoginData();
  RxBool loading = false.obs;
  RxBool loadingGoogle = false.obs;
  @override
  login() async {
    try{
      if(loadingGoogle.value) return;
      loading.value = true;
      final user = await loginData.login( email: emailController.text.trim(), password: passwordController.text.trim());
      if(user?.displayName != null){
        prefs!.setString("logged_in","yes");
        Get.offAllNamed(AppRoutes.home);
        emailController.clear();
        passwordController.clear();
      }
    } on NoInternetException  {
      Get.toNamed(AppRoutes.noInternetConnection);
    }on AuthException catch(e){
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        content: ErrorDialog(message: e.message)
      );
    }catch (e){
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        content: ErrorDialog(message: e.toString())
      );
    }
    loading.value = false;
  }
  @override
  Future<void> loginWithGoogle() async {
    try{
      if(loading.value) return;
      loadingGoogle.value = true;
      final user = await loginData.loginWithGoogle();
      if(user != null){
        prefs!.setString("logged_in","yes");
        Get.offAllNamed(AppRoutes.home);
      }
    } on NoInternetException {
      Get.toNamed(AppRoutes.noInternetConnection);
    }on AuthException catch(e){
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
    loadingGoogle.value = false;
  }


  @override
  Future<void> sendResetPassword(String email) async{
    try{
      loginData.sendResetPasswordEmail(email);
    }on NoInternetException {
      Get.toNamed(AppRoutes.noInternetConnection);
    }on AuthException catch(e){
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        content: ErrorDialog(message: e.message)
      );
    }catch (e){
      Get.defaultDialog(
        title: '',
        titleStyle: TextStyle(fontSize: 0),
        content: ErrorDialog(message: e.toString())
      );
    }
  }
  @override
  void signOut() {
    loginData.signOut();
    KeyService keyService = KeyService.instance;
    keyService.signOutClear();
    prefs!.remove('logged_in');
    Get.offAllNamed(AppRoutes.auth);
  }



  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}