import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AskController extends GetxController{
  Future<void> contactUs({required String number});
  Future<void> sendUsOnWhatsApp({required String phone, required String message,required String debtorName,required String money});
  void changeOption(int idx);
  void changeType(String t);
}

class AskControllerImpl extends AskController{
  String type = 'call';
  int option = 0;
  @override
  Future<void> contactUs({required String number}) async{
    final url = Uri.parse("tel:$number");
    if(await canLaunchUrl(url)){
      await launchUrl(url,mode: LaunchMode.externalApplication);
    }else{
      Get.showSnackbar(GetSnackBar(title: "Couldn't call the debtor",backgroundColor: Colors.red,duration: Duration(seconds: 1),));
    }
  }

  @override
  Future<void> sendUsOnWhatsApp({required String phone,required String message,required String debtorName,required String money}) async {
    if(phone.startsWith("0")){
      phone = "2$phone";
    }
    String coordinatedMessage = message.replaceAll('عميل', debtorName).replaceAll('مبلغ', money);
    final url = Uri.parse(
      'https://wa.me/$phone?text=${Uri.encodeComponent(coordinatedMessage)}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      Get.showSnackbar(GetSnackBar(title: 'Could not open WhatsApp',backgroundColor: Colors.red,duration: Duration(seconds: 1),));
    }
  }

  @override
  void changeOption(int idx) {
    option = idx;
    update();
  }

  @override
  void changeType(String t) {
    type = t;
    update();
  }
}