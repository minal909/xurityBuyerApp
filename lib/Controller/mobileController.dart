// import 'package:flutter/cupertino.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/helper/service_locator.dart';
// import '../models/services/dio_service.dart';

// class MobileVerification extends ChangeNotifier {
//   int getOtp = 0;
//   bool isVerified = false;
//   otpInitiate({required String phoneNumber}) async {
//     if (phoneNumber.length != 10) {
//       return;
//     } else {
//       getIt<SharedPreferences>().setString("phoneNumber", phoneNumber);

//       String url = "/kyc/phone-verification/request-otp";
//       Map<String, dynamic> data = {"recipient": phoneNumber};
//       Map<String, dynamic> responseData =
//           await getIt<DioClient>().post(url, data, null);
//       print(responseData);
//       if (responseData['status'] == true) {
//         getOtp = 1;
//       } else {
//         getOtp = 0;
//       }

//       notifyListeners();

//       return responseData;
//     }
//   }

//   Future<Map<String, dynamic>> otpVerification({required String otp}) async {
//     String? phoneNumber =
//         await getIt<SharedPreferences>().getString("phoneNumber");
//     String url = "/kyc/phone-verification/verify-otp";
//     Map<String, dynamic> data = {
//       "mobileNumber": phoneNumber,
//       "otp": otp,
//     };
//     Map<String, dynamic> responseData =
//         await getIt<DioClient>().post(url, data, null);
//     print(responseData);
//     if (responseData["status"] == true) {
//       getOtp == 2;
//       isVerified = true;
//       notifyListeners();
//     }
//     return responseData;
//   }
// }
