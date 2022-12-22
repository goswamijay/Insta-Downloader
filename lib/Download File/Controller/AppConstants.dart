import 'package:device_info_plus/device_info_plus.dart';

class AppConstants  {

  static String Whatsapp_path = "";

  static getInfo1() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo info = await deviceInfo.androidInfo;

    print( info.version.sdkInt.toString());
    if(info.version.sdkInt < 30){
      Whatsapp_path = "/storage/emulated/0/Insta Downloader";
      return Whatsapp_path.toString();
    }else{
      Whatsapp_path = "/storage/emulated/0/Insta Downloader";
      return Whatsapp_path.toString();
    }
  }
}