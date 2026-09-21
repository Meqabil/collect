import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class ContactUsController extends GetxController{
  Future<void> contactUs();
  Future<void> emailUs();
  Future<void> sendUsOnWhatsApp({required String phone, required String message});
}

class ContactUsControllerImpl extends ContactUsController{

  @override
  Future<void> contactUs() async{
    final url = Uri.parse("tel://01091372608");
    if(await canLaunchUrl(url)){
      await launchUrl(url,mode: LaunchMode.externalApplication);
    }else{
      throw Exception("Couldn't call the developer");
    }
  }

  @override
  Future<void> emailUs() async {
    final url = Uri.parse("mailto:mohmmedmek1234@gmail.com");
    if(await canLaunchUrl(url)){
      await launchUrl(url,mode: LaunchMode.externalApplication);
    }else{
      throw Exception("Couldn't call the developer");
    }
  }


  @override
  Future<void> sendUsOnWhatsApp({required String phone,required String message}) async {
    if(phone.startsWith("0")){
      phone = "2$phone";
    }
    final url = Uri.parse(
      'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw Exception('Could not open WhatsApp');
    }
  }
}
