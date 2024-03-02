import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';

import '../../models/services/dio_service.dart';

class ProfileManager extends ChangeNotifier {
  String? id = getIt<SharedPreferences>().getString('id');

  updateProfile({
    required String? name,
    required String? gid,
    required String? email,
    required String? mobileNo,
    required String? password,
    required String fName,
    required String lName,
    required String? userRole,
  }) async {
    String? id = getIt<SharedPreferences>().getString('id');

    String url = "/user/$id";
    Map<String, dynamic> data = {
      "name": name,
      "gid": gid,
      "email": email,
      "mobileNumber": mobileNo,
      "password": password,
      "firstName": fName,
      "lastName": lName,
      "userRole": userRole,
      "registeredBy": getIt<SharedPreferences>().getString('id')
    };
    String? token = getIt<SharedPreferences>().getString('token');

    dynamic responseData =
        await getIt<DioClient>().put(url, data, token: token);
    notifyListeners();
    return responseData;
  }

  updatePassword({required String id}) {
    String url = "/auth/reset-password/:id/:token";
    String? id = getIt<SharedPreferences>().getString('id');
    String? token = getIt<SharedPreferences>().getString('token');
    Map<String, dynamic> data = {"_id": id};
    Map<String, dynamic> responseData =
        getIt<DioClient>().post(url, data, token);
  }

  forgotPassword({required String email}) {
    String url = "/auth/forgot-password";
    String? token = getIt<SharedPreferences>().getString('token');
    Map<String, dynamic> data = {"email": email};
    dynamic responseData = getIt<DioClient>().post(url, data, token);
  }

  getTermsAndConditions() {
    String url = "/user/termsconditions";
    String? token = getIt<SharedPreferences>().getString('token');
    dynamic responseData = getIt<DioClient>().get(url, token: token);
    if (responseData != null) {
      return responseData;
    } else {
      return {"status": false};
    }
  }

  getContactUs() {
    String url = "https://www.xuriti.com/contact-us/";
    String? token = getIt<SharedPreferences>().getString('token');
    dynamic responseData = getIt<DioClient>().get(url, token: token);
    if (responseData != null) {
      return responseData;
    } else {
      return {"status": false};
    }
  }
}
