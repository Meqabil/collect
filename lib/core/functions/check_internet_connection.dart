import 'dart:io';

Future<bool> checkInternetConnection() async{
  try{
    List<InternetAddress> res = await InternetAddress.lookup("google.com");
    if(res.isNotEmpty){
      return true;
    }
  } on SocketException catch (_){
    return false;
  }
  return false;
}