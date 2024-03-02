import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/seller_list_model.dart';
import '../helper/service_locator.dart';

class DioClient {
  //final String baseUrl = "https://uat.xuriti.app/api";
  //final String baseUrl = "https://dev.xuriti.app/api";
  //final String baseUrl = "https://dev.xuriti.app/api";
  final String baseUrl = "https://dev.xuriti.app/api";
  // final String baseUrl = "https://demo.xuriti.app/api";

  final String launchUrl = "https://www.xuriti.com/";

  final String contactUrl = "https://www.xuriti.com/contact-us/";

  postFormData(String endUrl, FormData data, String? token) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    String url = baseUrl + endUrl;
    var dio = Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);

        return response.data;
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      return response.data;
    } catch (e) {
      print(e);
    }
  }
  // postFormData(String endUrl, FormData data, String? token) async {
  //   BaseOptions options = new BaseOptions(
  //       baseUrl: baseUrl,
  //       receiveDataWhenStatusError: true,
  //       connectTimeout: 60 * 1000, // 60 seconds
  //       receiveTimeout: 120 * 1000 // 60 seconds
  //       );
  //   String url = baseUrl + endUrl;
  //   var dio = Dio();
  //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //       (HttpClient client) {
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //     return client;
  //   };
  //   try {
  //     if (token == null) {
  //       Response response = await dio.post(url, data: data);

  //       return response.data;
  //     }
  //     if (token != null) {
  //       print('/////////// no err11111');
  //       Response response = await dio.post(url,
  //           data: data,
  //           options: Options(headers: {'Authorization': 'Bearer $token'}));
  //       print('/////////// no err222222222222');
  //       print(response);
  //       return response.data;
  //     }
  //   } catch (e) {
  //     print('///////////errrrr');
  //     print(e);
  //   }
  // }

  post(String endUrl, Map<String, dynamic> data, String? token) async {
    print(endUrl);
    var dio = Dio();

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    print(url);
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);
        return response.data;
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {}
  }

  // postNotification(
  //     String endUrl, Map<String, dynamic> data, String? token) async {
  //   var dio = Dio();

  //   // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //   //     (HttpClient client) {
  //   //   client.badCertificateCallback =
  //   //       (X509Certificate cert, String host, int port) => true;
  //   //   return client;
  //   // };
  //   String apikey =
  //       'AAAAb4JP7sA:APA91bEOa5-WG8AKLgVJ88waMQ3PrS8JxlbL0rH0VAejE-v1_exd8huG3fnnVh_FrkW7P0rdlVynjqrtqwfYjZIiO1A8rqOCiDWWn852vV9Fv-QgoKEGeKle7cV0BCqrgsvgvVc7bIhx';
  //   String url = endUrl;

  //   Response response = await dio.post(url,
  //       data: data,
  //       options: Options(headers: {
  //         'Authorization': 'Bearer' + '$apikey',
  //         HttpHeaders.contentTypeHeader: 'application/json'
  //       }));
  //   return response.data;
  // }

  get(String endUrl, {String? token}) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      print(token.toString());
      if (token == null) {
        Response response = await dio.get(url);

        return response.data;
      } else {
        Map responseMap = {};
        Response response = await dio.get(url,
            options: Options(
                validateStatus: (status) {
                  if (status == 200 || status == 440) {
                    return true;
                  } else {
                    return false;
                  }
                },
                headers: {'Authorization': 'Bearer $token'}));

        if (response.statusCode == 440) {
          Map<String, dynamic> responseMap = response.data;
          responseMap.addEntries([MapEntry("statusCode", 440)]);
        }
        return response.data;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  put(endUrl, data, {String? token}) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      if (token == null) {
        Response response = await dio.put(url, data: data);
        return response.data;
      }
      Response response = await dio.put(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {}
  }

  Future<dynamic> patch(endUrl, data, {String? token}) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;

    try {
      if (token == null) {
        Response response = await dio.patch(url, data: data);
        return response.data;
      }

      Response response = await dio.patch(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {}
  }

  // download(link, String fileName) async {
  //   String savePath = await getIt<TransactionManager>().getFilePath(fileName);
  //   var dio = Dio();
  // try{
  //   Response response = await dio.download(link, savePath);
  //   return response.statusCode;
  // }catch (e){
  //   print(e);
  // }
  //
  // }
  KycDetails(String companyid) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    String endUrl = '/kyc/$companyid/status';
    String? token = getIt<SharedPreferences>().getString('token');
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');

    String url = baseUrl + endUrl;
    final uri = Uri.parse(url);

    try {
      print(token.toString());
      if (token == null) {
        Response response = await dio.get(url);
        return response.data;
      }
      Response response = await dio.get(url,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {
      return e;
    }
  }

  aadhaar_captured_data(String endUrl, FormData data, String? token) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);
        print('URL11111 -----> $url');
        return response.data;
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'Aadhaar api successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future transactionLedgerNetwork(String? companyid) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    String? token = getIt<SharedPreferences>().getString('token');
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');

    String endUrl = '/ledger/companies/transaction_ledger?buyer=$companyid';
    String url = baseUrl + endUrl;
    final uri = Uri.parse(url);

    // try {
    //   print(token.toString());
    // if (token == null) {
    //   Response response = await dio.get(url);
    //   return response.data;
    // }
    // if (token != null) {
    Response response = await dio.get(url,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    final data = response.data;
    return data;
    // }

    // catch (e) {
    //   return nul;
    // }
  }

  Future transactionStatementInv(String? companyid) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    String endUrl = "/ledger/statement/buyer/$companyid";
    String? token = getIt<SharedPreferences>().getString('token');
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');

    String url = baseUrl + endUrl;
    final uri = Uri.parse(url);

    //   Response response = await dio.get(url);
    // try {
    //   print(token.toString());
    // if (token == null) {
    //   return response.data;
    // }
    // if (token != null) {
    Response response = await dio.get(url,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    final data = response.data;
    return data;
    // }

    // catch (e) {
    //   return nul;
    // }
  }

  Future getCompName(String? companyid) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    String endUrl = "/entity/entity/$companyid";
    String? token = getIt<SharedPreferences>().getString('token');
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');

    String url = baseUrl + endUrl;
    final uri = Uri.parse(url);

    //   Response response = await dio.get(url);
    // try {
    //   print(token.toString());
    // if (token == null) {
    //   return response.data;
    // }
    // if (token != null) {
    Response response = await dio.get(url,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    final data = response.data;
    return data;
    // }

    // catch (e) {
    //   return nul;
    // }
  }

  Future getInvDetails(String? invid) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    String endUrl = "/invoice/invoices?_id=$invid";
    String? token = getIt<SharedPreferences>().getString('token');
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');

    String url = baseUrl + endUrl;
    final uri = Uri.parse(url);

    //   Response response = await dio.get(url);
    // try {
    //   print(token.toString());
    // if (token == null) {
    //   return response.data;
    // }
    // if (token != null) {
    Response response = await dio.get(url,
        options: Options(headers: {'Authorization': 'Bearer $token'}));
    final data = response.data;
    return data;
    // }

    // catch (e) {
    //   return nul;
    // }
  }

 

  pan_captured_data(String url, FormData data, String? token) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio(options);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);

        return response.data;
      }
      print('=== $url $token $data');
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'Pan api successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      print(response);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  // pan verify
  verify_pan(String url, FormData data, String? token) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio(options);

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);

        return response.data;
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'Pan api successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  mobile_verfication(String url, Object data, String? token) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio(options);
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);

        return response.data;
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'generate otp successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  otp_verfication(String url, Object data, String? token) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio(options);
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);

        return response.data;
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'otp verified successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  getCaptcha(String endUrl, {String? token}) async {
    var dio = Dio();
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    String url = baseUrl + endUrl;
    try {
      print(token.toString());
      if (token == null) {
        Response response = await dio.get(url);
        return response.data;
      }
      Response response = await dio.get(url,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      return response.data;
    } catch (e) {
      // print(e);
    }
  }

  aadhaar_otp(String url, Object data, String? token) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio(options);
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);

        return response.data;
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        // Fluttertoast.showToast(
        //     msg: 'otp verified successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  aadhaar_otp_verify(String url, Object data, String? token) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60 * 1000, // 60 seconds
        receiveTimeout: 120 * 1000 // 60 seconds
        );
    var dio = Dio(options);
    try {
      if (token == null) {
        Response response = await dio.post(url, data: data);

        return response.data;
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200) {
        print("OTP Verified...");
        // Fluttertoast.showToast(
        //     msg: 'otp verified successful....',
        //     toastLength: Toast.LENGTH_LONG,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 3,
        //     backgroundColor: Color.fromARGB(255, 253, 153, 33),
        //     textColor: Colors.white,
        //     fontSize: 12.0);
      }
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
