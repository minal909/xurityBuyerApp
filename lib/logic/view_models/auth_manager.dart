import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/models/services/dio_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:xuriti/models/services/user_info_service.dart';

class AuthManager extends ChangeNotifier {
  String message = "";
  UserDetails? userDetails;
  bool isVerified = false;
  int getOtp = 0;
  bool userCreated = false;
  // CreditLimit? creditLimit;8075211
  UserDetails? uInfo;
  UserInfoService userInfoService = getIt<UserInfoService>();
  String? errorMessage = "";
  String? gid;
  String? email;
  String? firstName;
  String? lastName;
  String? userName;
  String platformVersion = 'Unknown';
  String? appdata = 'Unknown';
  //String sdkBaseUrl = "https://dev.xuriti.app/api";
  // String sdkBaseUrl = "https://uat.xuriti.app/api";
  String? fcmToken;
  final _firebaseAuth = FirebaseAuth.instance;
  void reset() {
    message = "";

    isVerified = false;
    getOtp = 0;
    userCreated = false;
    // notifyListeners();
  }

  // Future<User> signInWithApple({List<Scope> scopes = const []}) async {
  //   // sign-in request code

  //   final result = await TheAppleSignIn.performRequests(
  //       [AppleIdRequest(requestedScopes: scopes)]);

  //   // checking the result
  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       final appleIdCredential = result.credential!;
  //       final oAuthProvider = OAuthProvider('apple.com');
  //       final credential = oAuthProvider.credential(
  //         idToken: String.fromCharCodes(appleIdCredential.identityToken!),
  //         accessToken:
  //             String.fromCharCodes(appleIdCredential.authorizationCode!),
  //       );
  //       final userCredential =
  //           await _firebaseAuth.signInWithCredential(credential);
  //       final firebaseUser = userCredential.user!;
  //       if (scopes.contains(Scope.fullName)) {
  //         final fullName = appleIdCredential.fullName;
  //         if (fullName != null &&
  //             fullName.givenName != null &&
  //             fullName.familyName != null) {
  //           final displayName = '${fullName.givenName} ${fullName.familyName}';
  //           await firebaseUser.updateDisplayName(displayName);
  //         }
  //       } else if (scopes.contains(Scope.email)) {
  //         final email = appleIdCredential.email;
  //         if (email != null) {
  //           final displayEmail = '$email';
  //           await firebaseUser.updateEmail(displayEmail);
  //         }
  //       }
  //       return firebaseUser;

  //     case AuthorizationStatus.error:
  //       throw PlatformException(
  //           code: 'Error_Authorization_Denied',
  //           message: result.error.toString());

  //     case AuthorizationStatus.cancelled:
  //       throw PlatformException(
  //         code: "Aborted by user",
  //         message: 'Sign in aborted by user',
  //       );

  //     default:
  //       throw UnimplementedError();
  //   }
  // }

  registerUser(
      {required String fname,
      required String lname,
      required String number,
      required String email,
      required String password,
      required String cpassword}) async {
    if (fname.isEmpty ||
        lname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        number.isEmpty) {
      message = "Some Fields are Missing";
    } else if (EmailValidator.validate(email) == false) {
      message = "Email not Valid";
    } else if (cpassword != password) {
      message = "Password  Mismatch";
    } else {
      message = "";

      String url = "/auth/register-user";
      Map<String, dynamic> data = {
        "firstName": fname,
        "lastName": lname,
        "mobileNumber": number,
        "gid": gid ?? "",
        "email": email,
        "password": password
      };
      notifyListeners();
      Map<String, dynamic> responseData =
          await getIt<DioClient>().post(url, data, null);

      return responseData;
    }
  }

  otpInitiate({required String phoneNumber}) async {
    if (phoneNumber.length != 10) {
      return;
    } else {
      getIt<SharedPreferences>().setString("phoneNumber", phoneNumber);

      String url = "/auth/send-otp";
      Map<String, dynamic> data = {"recipient": phoneNumber};
      Map<String, dynamic> responseData =
          await getIt<DioClient>().post(url, data, null);
      if (responseData['status'] == true) {
        getOtp = 1;
      } else {
        getOtp = 0;
      }

      notifyListeners();

      return responseData;
    }
  }

  Future<Map<String, dynamic>> otpVerification({required String otp}) async {
    String? phoneNumber =
        await getIt<SharedPreferences>().getString("phoneNumber");
    String url = "/auth/verify-otp";
    Map<String, dynamic> data = {
      "mobileNumber": phoneNumber,
      "otp": otp,
    };
    Map<String, dynamic> responseData =
        await getIt<DioClient>().post(url, data, null);
    if (responseData["status"] == true) {
      getOtp == 2;
      isVerified = true;
      notifyListeners();
    }
    return responseData;
  }

  signInwithEmailandPassword({
    required String email,
    required String password,
  }) async {
    //  String url = "/auth/login";
    // String? fcmToken = await FirebaseMessaging.instance.getToken();
    // log(fcmToken ?? "");
    String? devicetoken = await FirebaseMessaging.instance.getToken();
    print('device tkn ;;;;;;;;;;; $devicetoken');
    String url = "/auth/user-login";
    // String url = "/auth/login";
    late Map<String, dynamic> response;
    Map<String, dynamic> data = {
      "email": email,
      "password": password,
      "recaptcha": "test_recaptcha",
      "login_type": 'mobile_app',
      "device_id": devicetoken
    };
    String? token = await getIt<SharedPreferences>().getString("token");

    Map<String, dynamic>? responseData =
        await getIt<DioClient>().post(url, data, token);

    if (responseData != null) {
      if (responseData["status"] == false) {
        return responseData;
      } else {
        Map<String, dynamic> user = responseData["user"];

        getIt<SharedPreferences>().setString('id', user["_id"]);
        getIt<SharedPreferences>().setString('email', user["email"]);
        getIt<SharedPreferences>()
            .setString('phoneNumber', user["mobile_number"]);
        // getIt<SharedPreferences>()
        //     .setString('devicetoken', user["devicetoken"]);
        // String token = FirebaseInstanceId.getInstance().getToken();

        print('push notifctn token from login $devicetoken');

        userDetails = UserDetails.fromJson(responseData);

        if (userDetails != null) {
          uInfo = userDetails;
          await getIt<UserInfoService>().addData(userDetails);

          //String? userId = userDetails?.user!.sId;
          //String? token = userDetails?.token;
          String? useName = userDetails!.user!.name;
          getIt<SharedPreferences>().setString('token', responseData["token"]);
          getIt<SharedPreferences>().setString('userName', useName!);

          return responseData;
          // Map<String, dynamic> sdkResponse = {};
          // try {
          //   Position position  = await Geolocator.getCurrentPosition();
          //   fcmToken = await  FirebaseMessaging.instance.getToken();
          //
          //   if(getIt<SharedPreferences>().getString('id') != null) {
          //
          //     String? userId = getIt<SharedPreferences>().getString('id');
          //     print("dataSdk");
          //     appdata = await _datasdkPlugin.getAppData(userId,
          //         sdkBaseUrl, position.latitude.toString(), position.longitude.toString(), fcmToken);
          //     print("userId, baseUrl, {position.latitude.toString()}, {position.longitude.toString()}, fcmToken");
          //     print("$userId, $sdkBaseUrl, ${position.latitude.toString()}, ${position.longitude.toString()}, $fcmToken");
          //     print("appdata");
          //     print(appdata);
          //     print("appdata");
          //     platformVersion = await _datasdkPlugin.getPlatformVersion() ??
          //         'Unknown platform version';
          //
          //
          //     if(appdata!= null && appdata == "SUCCESS"){
          //       sdkResponse['sdkStatus'] = true;
          //       sdkResponse['sdkMessage'] = 'Success.';
          //     }else{
          //       sdkResponse['sdkStatus'] = false;
          //       sdkResponse['sdkMessage'] = appdata;
          //     }
          //   }
          //
          // } on PlatformException {
          //   platformVersion = 'Failed to get platform version.';
          //   sdkResponse['sdkStatus'] = false;
          //   sdkResponse['sdkMessage'] = 'Failed to get platform version.';
          // }
        }
        response = {
          'status': false,
          'message': "Unexpected error occurred please try again later"
        };

        return response;
        // notifyListeners();
      }
    } else {
      response = {
        'status': false,
        'message': "Unexpected error occurred please try again later"
      };
      return response;
    }
  }

  logOut() async {
    String? id = getIt<SharedPreferences>().getString('id');
    String url = "/auth/logout";
    Map<String, dynamic> data = {"userID": id};

    await getIt<DioClient>().post(url, data, null);
    if (getIt<SharedPreferences>().getBool('isgLogin') == true) {
      await googleSignIn.signOut();
    }
  }

  getUInfo(String? userid) async {
    uInfo = await userInfoService.getInfo(userid);
  }

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  googleLogin({required bool isSignIn}) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    gid = _user!.id;
    email = _user!.email;
    userName = _user?.displayName;
    List<String> displayName = userName!.split(" ");
    firstName = displayName[0];
    lastName = displayName[1];
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    String? idToken = googleAuth.idToken ?? '';

    Map<String, dynamic> gResponse = await apiGoogleLogin(email, gid, idToken);

    if (gResponse['status'] == false) {
      if (isSignIn == true) {
        await googleSignIn.signOut();
        gid = null;
      } else {
        return gResponse;
      }
    } else {
      Map<String, dynamic> user = gResponse["user"];
      getIt<SharedPreferences>().setString('token', gResponse["token"]);

      getIt<SharedPreferences>().setBool('isgLogin', true);
      String? gToken = getIt<SharedPreferences>().getString("token");

      getIt<SharedPreferences>().setString('id', user["_id"]);
      String teemp = user.toString();
      getIt<SharedPreferences>().setString('temp', teemp);
      userDetails = UserDetails.fromJson(gResponse);
      uInfo = userDetails;

      await getIt<UserInfoService>().addData(userDetails);
      return gResponse;
    }
  }

  apiGoogleLogin(email, gid, String idToken) async {
    String url = "/auth/google-login";
    Map<String, dynamic> data = {
      "email": email,
      "gid": gid,
      "id_token": idToken
    };

    Map<String, dynamic> responseData =
        await getIt<DioClient>().post(url, data, null);

    return responseData;
  }

  // logInViaApple() async {
  //   final AuthorizationResult result = await TheAppleSignIn.performRequests([
  //     AppleIdRequest(requestedScopes: [
  //       Scope.email,
  //       Scope.fullName,
  //     ]),
  //   ]);

  //   switch (result.status) {
  //     case AuthorizationStatus.authorized:
  //       print(result.credential?.user);
  //       break;
  //     case AuthorizationStatus.error:
  //       print("Sign in failed: ${result.error?.localizedDescription}");
  //       break;
  //     case AuthorizationStatus.cancelled:
  //       print("User cancelled");
  //       break;

  //       break;
  //     default:
  //   }
  // }

  getIPAddress(String url) async {
    try {
      String finalUrl = "https://biz.xuriti.app/api";
      String urlLink = finalUrl + url;
      final response = await getIt<DioClient>().get(urlLink);
      return response.statusCode == 200 ? response.body : null;
    } catch (e) {
      return null;
    }
  }
}
