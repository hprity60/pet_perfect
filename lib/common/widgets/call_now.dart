import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

// void callNow(String phoneNumber) async{
  
//   Fluttertoast.showToast(msg: "Calling number: $phoneNumber");
//   if (await canLaunch("tel:$phoneNumber")) {
//     await launch("tel:$phoneNumber");
//   } else {
    
//   Fluttertoast.showToast(msg: "Could not call number: $phoneNumber");
//   }
// }


Future<void> callNow(String url) async {
    if (await canLaunch("tel:"+url)) {
      await launch("tel:"+url);
    } else {
      Fluttertoast.showToast(msg: "Could not call number: $url");
//   
      throw 'Could not launch $url';
    }
  }