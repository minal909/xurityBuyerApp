import 'package:flutter/cupertino.dart';

import '../../models/helper/service_locator.dart';
import '../../models/services/dio_service.dart';

class PasswordManager extends ChangeNotifier {
  String passMsg2 = "";
  String passMsg = "";
  String emailMsg = "";
  String mobileMsg = "";
  String nameMsg = "";
  String secondNameMsg = "";
  String userNameMsg = "";

  void reset(){
    passMsg = "";
    passMsg2 = "";
    emailMsg = "";
    mobileMsg = "";
    nameMsg = "";
    secondNameMsg= "";
    userNameMsg = "";
  }

  forgotPassword({required String email}) async {
    String url = "/auth/forgot-password";
    Map<String, dynamic> data = {
      "email": email,
    };
    Map<String, dynamic> responseData =
        await getIt<DioClient>().post(url, data, null);
    print(responseData);
    return responseData;
  }






  passwordConfirmation(String password, String confirmPassword) {
    if (password != confirmPassword) {
      passMsg2 = "Password mismatch";
    } else {
      passMsg2 = "";
    }
    notifyListeners();
  }


  allValidation({required String firstName,required String secondName, required String email,
  required String password, required String number
  }){
    validateFirstName(firstName);
    validateSecondName(secondName);
    validateEmail(email);
    validatePassword(password);
    validateMobile(number);
  }

  profileValidation(){
    if(
    emailMsg.isEmpty &&
    mobileMsg.isEmpty &&
    nameMsg.isEmpty &&
    secondNameMsg.isEmpty &&
    userNameMsg.isEmpty){
      return true;
    }else{
      return false;
    }
  }


  validateEmail(String email) {
    if (email.isNotEmpty) {
      String pattern =
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
      RegExp regExp =  RegExp(pattern);
      regExp.hasMatch(email)
          ? emailMsg = ""
          : emailMsg = "Please enter a valid email id";
    } else {
      emailMsg = "Please enter email id";
    }
    notifyListeners();
  }

  validateFirstName(String firstName) {
    if (firstName.isNotEmpty) {
      String pattern =
          r"^[A-Za-z]+$";
      RegExp regExp = RegExp(pattern);
      regExp.hasMatch(firstName)
          ? nameMsg = ""
          : nameMsg = "Please enter a valid name";
    } else {
      nameMsg = "Please enter first name";
    }
    notifyListeners();
  }
  validateUserName(String userName ){
    if (userName.isNotEmpty) {
      String pattern =
          r"^[A-Za-z]+$";
      RegExp regExp = RegExp(pattern);
      regExp.hasMatch(userName)
          ? userNameMsg = ""
          : userNameMsg = "Please enter a valid name";
    } else {
      userNameMsg = "Please enter user name";
    }
    notifyListeners();
  }
  validateSecondName(String secondName) {
    if (secondName.isNotEmpty) {
      String pattern =
          r"^[A-Za-z]+$";
      RegExp regExp = RegExp(pattern);
      regExp.hasMatch(secondName)
          ? secondNameMsg = ""
          : secondNameMsg = "Please enter a valid name";
    } else {
      secondNameMsg = "Please enter last name";
    }
    notifyListeners();
  }

  validateMobile(String mobile) {
    if (mobile.isNotEmpty) {
      if(mobile.length == 10){
        String pattern =
            r"^[0-9]+$";
        RegExp regExp = RegExp(pattern);
        regExp.hasMatch(mobile)
            ? mobileMsg = ""
            : mobileMsg = "Please enter a valid mobile";
      }else{
        mobileMsg = "Please enter 10 digits";
      }
    }
     else {
      mobileMsg = "Please enter mobile number";
    }
    notifyListeners();
  }


  validatePassword(String value) {
    if (value.length > 5) {
      String pattern =
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regExp =  RegExp(pattern);
      regExp.hasMatch(value)
          ? passMsg = ""
          : passMsg = "Password must contain correct format";
    } else {
      passMsg = "Password must contain 6 characters";
    }
    notifyListeners();
  }
}
