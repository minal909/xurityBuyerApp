import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/CompanyInfo_model.dart';
import 'package:xuriti/models/core/EntityModel.dart';
import 'package:xuriti/models/core/seller_id_model.dart';
import 'package:xuriti/models/core/seller_info_model.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/models/services/dio_service.dart';
import '../../models/core/seller_list_model.dart';

class CompanyDetailsManager extends ChangeNotifier {
  CompanyInfo? companyinfo;
  CompanyInfoV2? companyinfoV2;
  SellerInfo? sellerInfo;
  SellerInfo? sellerInfo1;

  List<MSeller> sellers = [];
  List<SellerListDetails> sellerAllLists = [];
  BussinessDetails bussinessDetails = BussinessDetails();
  String? revisedDiscount;
  String? payableAmount;
  String? settledAmount;
  String? revisedInterest;
  //String? revisedgstSettled;
  String? chosenSellerId;
  String? selectedSellerId;
  Map<String, dynamic> response = {};
  bool isDisable = true;
  String? errorMessage;
  String settleAmountMsg = "";
  String panNo = "";
  int? _statusCode;
  int? get responseCode => _statusCode;

  double? revisedTotalOutstandingAmount;
  int status = 0;
  int currentSellerIndex = 0;
  bool isSwitched = false;
  bool isChecked = false;
  bool isConsent = false;
  Map<String, dynamic> registrationData = {};

  String? sellerId;
  List<SellerListDetails>? sellerListDetails;
  SellerList? sellerList;
  resetSellerInfo() {
    sellerInfo = null;
    isSwitched = false;
    chosenSellerId = null;
    revisedInterest = "0";
    // revisedgstSettled = "0";
    settledAmount = "0";
    revisedDiscount = "0";
    payableAmount = "0";
    isDisable = true;
  }

  resetRevisedValues() {
    revisedDiscount = "0";
    payableAmount = "0";
    revisedInterest = "0";
    // revisedgstSettled = "0";
    settledAmount = "0";
    settleAmountMsg = "";
    notifyListeners();
  }

  toggleSwitch() {
    isSwitched = !isSwitched;
    resetRevisedValues();
    notifyListeners();
  }

  validateSettleAmount(String settleAMount) {
    if (settleAMount.isNotEmpty) {
      String pattern = r"^\-?[0-9]+(?:\.[0-9]{1,2})?$";
      RegExp regExp = RegExp(pattern);
      regExp.hasMatch(settleAMount)
          ? settleAmountMsg = ""
          : settleAmountMsg = "Please enter a valid amount";
    } else {
      settleAmountMsg = "Please enter settle amount";
    }
    notifyListeners();
  }

  isValidateSettleAmount(String settleAMount) {
    bool isValidate;

    String pattern = r"^\-?[0-9]+(?:\.[0-9]{1,2})?$";
    RegExp regExp = RegExp(pattern);
    regExp.hasMatch(settleAMount) ? isValidate = true : isValidate = false;
    return isValidate;
  }

  checkBox() {
    isChecked = !isChecked;
    notifyListeners();
  }

  disposeRegisterCompanyDetails() {
    status = 0;
    isChecked = false;
  }




  Future<CompanyInfo?> gstSearch({
    required String gstNo,
    required UserDetails? uInfo,
  }) async {
    if (gstNo.isNotEmpty && gstNo.length > 8) {
      panNo = gstNo.substring(2, 12);
    }

    String url = "/entity/v2/search-gst";
    String? token = getIt<SharedPreferences>().getString('token');
    Map<String, dynamic> data = {
      "gstin": gstNo,
    };

    try {
      Map<String, dynamic> responseData =
          await getIt<DioClient>().post(url, data, token);

      if (responseData["status"] == true && responseData["company"] != null) {
        companyinfo = CompanyInfo.fromJson(responseData);

        // registrationData = responseData["company"];
        registrationData['industryType'] = "IT";
        registrationData['annual_Turnover'] = "";
        registrationData['companyMobile'] = uInfo!.user!.mobileNumber ?? "";
        registrationData['companyEmail'] = uInfo.user!.email ?? "";
        registrationData['admin_mobile'] = uInfo.user!.mobileNumber ?? "";
        registrationData['admin_email'] = uInfo.user!.email ?? "";
        registrationData['userID'] = uInfo.user!.sId ?? "";
        registrationData['dealerName'] = uInfo.user!.name ?? "";
        status = 1;
        notifyListeners();
      } else {
        print(responseData);
        // status = 2;

        // notifyListeners();
        // errorMessage = (responseData['message']);
        // return responseData['message'];
      }
      return companyinfo;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<CompanyInfoV2?> gstSearch2({
    required String gstNo,
    required UserDetails? uInfo,
    
  }) async {
    if (gstNo.isNotEmpty) {
      panNo = gstNo.substring(2, 12);
    }

    String url = "/entity/v2/search-gst";
    String? token = getIt<SharedPreferences>().getString('token');
    Map<String, dynamic> data = {
      "gstin": gstNo,
    };

    try {
      Map<String, dynamic> responseData =
          await getIt<DioClient>().post(url, data, token);

      if (responseData["status"] == false) {
        companyinfoV2 = CompanyInfoV2.fromJson(responseData);

        registrationData['industryType'] = "IT";
        registrationData['annual_Turnover'] = "";
        registrationData['companyMobile'] = uInfo?.user!.mobileNumber ?? "";
        registrationData['companyEmail'] = uInfo?.user!.email ?? "";
        registrationData['admin_mobile'] = uInfo?.user!.mobileNumber ?? "";
        registrationData['admin_email'] = uInfo?.user!.email ?? "";
        registrationData['userID'] = uInfo?.user!.sId ?? "";
        registrationData['dealerName'] = uInfo?.user!.name ?? "";
        status = 1;
        notifyListeners();
      } else if (responseData["status"] == true) {
        companyinfoV2 = CompanyInfoV2.fromJson(responseData);

        registrationData['industryType'] = "IT";
        registrationData['annual_Turnover'] = "";
        registrationData['companyMobile'] = uInfo?.user!.mobileNumber ?? "";
        registrationData['companyEmail'] = uInfo?.user!.email ?? "";
        registrationData['admin_mobile'] = uInfo?.user!.mobileNumber ?? "";
        registrationData['admin_email'] = uInfo?.user!.email ?? "";
        registrationData['userID'] = uInfo?.user!.sId ?? "";
        registrationData['dealerName'] = uInfo?.user!.name ?? "";
        status = 1;
        notifyListeners();
        print(responseData);
      }
      return companyinfoV2;
    } catch (e) {
      print(e);
    }
    return null;
  }

  addEntity({
    required dynamic gstNo,
    required String tan,
    required String cin,
    required dynamic adminMobile,
    required String pan,
    required String annualTurnover,
    required String selectedId,
    required dynamic adminEmail,
    required dynamic companyName,
    required dynamic userId,
  }) async {
    String? token = await getIt<SharedPreferences>().getString("token");
    String url = "/entity/add-entity";

    registrationData['gstin'] = gstNo;
    registrationData['consent_gst_defaultFlag'] = isChecked;
    registrationData['tan'] = tan;
    registrationData['cin'] = cin;
    registrationData['pan'] = pan;
    registrationData['annual_Turnover'] = annualTurnover;
    registrationData['associated_seller'] = selectedId;
    registrationData['seller_flag'] = false;
    registrationData['admin_mobile'] = adminMobile;
    registrationData['admin_email'] = adminEmail;
    registrationData['companyName'] = companyName;

    Map<String, dynamic> responseData =
        await getIt<DioClient>().post(url, registrationData, token);
    if (responseData != null) {
      if (responseData['status'] == true) {
        companyinfo = null;
        return responseData;
      } else {
        return responseData;
      }
    } else {
      return responseData;

      // "errors": {"message": "Entity GSTIN Already Exist"},
      // "status": false
    }
  }

  manualAddEntity({
    required dynamic gstNo,
    required dynamic adminMobile,
    required dynamic pan,
    required dynamic adminEmail,
    required dynamic companyName,
    required dynamic selectedId,
    required dynamic userId,
  }) async {
    String? token = await getIt<SharedPreferences>().getString("token");
    String url = "/entity/add-entity";
    registrationData['consent_gst_defaultFlag'] = isChecked;
    registrationData['userID'] = userId;
    registrationData['pan'] = pan;
    registrationData['admin_mobile'] = adminMobile;
    registrationData['admin_email'] = adminEmail;
    registrationData['gstin'] = gstNo;
    registrationData['companyName'] = companyName;
    registrationData['associated_seller'] = selectedId;

    Map<String, dynamic> responseData =
        await getIt<DioClient>().post(url, registrationData, token);
    if (responseData.isNotEmpty) {
      if (responseData['status'] == true) {
        companyinfo = null;
        return responseData;
      } else {
        return responseData;
      }
    } else {
      return responseData;

      // "errors": {"message": "Entity GSTIN Already Exist"},
      // "status": false
    }
  }

  getSellerList(
    companyId,
  ) async {
    sellerList = SellerList();
    if (companyId != null) {
      String url = "/invoice/paymentsummary/?buyer=$companyId";
      // String url = "/payment/get_seller?buyer=$companyId";

      String? token = getIt<SharedPreferences>().getString("token");
      dynamic responseData = await getIt<DioClient>().get(url, token: token);

      if (responseData != null && responseData['status'] == true) {
        sellerList = SellerList.fromJson(responseData);
        if (sellerList != null) {
          if (sellerList!.seller != null) {
            return sellerList!.seller;
          }
        }
      }
    }
  }

  Future<MSeller> getPaymentHistorySeller() async {
    String? companyId = getIt<SharedPreferences>().getString('companyId');
    MSeller currentSeller = MSeller();
    await getSellerList(companyId);
    List<MSeller>? tempList = sellerList!.seller;
    for (var i in tempList!) {
      if (i.seller!.sId == sellerId) {
        // currentSeller = i;
        return i;
      }
    }
    return MSeller();
  }

  changeSelectedSellerId(sellerId) {
    sellerId = sellerId;
  }

  changeSelectedSeller(index) {
    currentSellerIndex = index;
  }

  Future<Map<String, dynamic>?> getSellerInfo(companyId, sellerId) async {
    chosenSellerId = sellerId;
    if (companyId != null && sellerId != null) {
      //  String url = "/invoice/paymentsummary/?buyer=$companyId&seller=$sellerId";
      String url = "/payment/summary?buyer=$companyId&seller=$sellerId";

      String? token = getIt<SharedPreferences>().getString("token");
      dynamic responseData = await getIt<DioClient>().get(url, token: token);

      if (responseData != null) {
        if (responseData['status'] == true) {
          //sellerInfo = null;
          sellerInfo = SellerInfo.fromJson(responseData);
          notifyListeners();
        } else {
          Map<String, dynamic> errorMessage = {
            "msg": "Something went wrong, please try again",
          };
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          "msg": "Something went wrong, please try again",
        };
        return errorMessage;
      }
      return responseData;
    }
    return null;
  }

  Future<Map<String, dynamic>?> getSellerInfoforPartpay(
      companyId, sellerId, payAmount) async {
    chosenSellerId = sellerId;
    if (companyId != null && sellerId != null) {
      //  String url = "/invoice/paymentsummary/?buyer=$companyId&seller=$sellerId";
      String url =
          "/payment/summary?buyer=$companyId&seller=$sellerId&pay_amount=$payAmount";

      String? token = getIt<SharedPreferences>().getString("token");
      dynamic responseData = await getIt<DioClient>().get(url, token: token);

      if (responseData != null) {
        if (responseData['status'] == true) {
          //sellerInfo = null;
          sellerInfo1 = SellerInfo.fromJson(responseData);
          notifyListeners();
        } else {
          Map<String, dynamic> errorMessage = {
            "msg": "Something went wrong, please try again",
          };
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          "msg": "Something went wrong, please try again",
        };
        return errorMessage;
      }
      return responseData;
    }
    return null;
  }

  getSellerDetails(sellerId) async {
    // selectedSellerId = sellerId;

    try {
      String url = "/entity/seller-list";
      String? token = getIt<SharedPreferences>().getString("token");
      dynamic responseData = await getIt<DioClient>().get(url, token: token);
      print('000000 $responseData');
      if (responseData != null && responseData['status'] == true) {
        SellerIdModel sellerIdModel = SellerIdModel.fromJson(responseData);

        return sellerIdModel.sellerListDetails;
      } else if (responseData == null) {
        return SellerIdModel();
      }
    } catch (e) {
      print(e);
    }
  }

  outstandingPayNow(companyId, sellerId, paidAmount,
      {isToggled = false}) async {
    Map<String, dynamic>? tempData = {};

    if (companyId != null && sellerId != null) {
      String url =
          "/invoice/paymentsummary/?buyer=$companyId&seller=$sellerId&pay_amount=$paidAmount";
      // "/payment/summary?buyer=$companyId&seller=$sellerId&pay_amount=$paidAmount";
      String? token = getIt<SharedPreferences>().getString("token");
      dynamic responseData = await getIt<DioClient>().get(url, token: token);

      if (responseData != null && responseData['status'] == true) {
        tempData['payableAmount'] = responseData['paybaleAmount'] ?? 0;
        // double tempOutstanding =
        //     double.parse(sellerInfo!.totalOutstanding ?? '0').toDouble();
        // tempOutstanding -=
        //     double.parse(responseData['total_discount'].toString());
        // tempOutstanding +=
        //     double.parse(responseData['total_interest'].toString());

        // print('${tempOutstanding} ------------>>>>>');

        tempData['revisedDiscount'] = ((responseData['total_discount'] != null)
            ? responseData['total_discount'].toString()
            : 0) as String?;
        // tempData['revisedgstSettled'] = ((responseData['total_gst'] != null)
        //     ? responseData['total_gst'].toString()
        //     : 0) as String?;
        tempData['interest'] = responseData['total_interest'];
        if (paidAmount != null && isSwitched == true && isToggled == true) {
          isDisable = true;
          revisedDiscount = double.parse(tempData['revisedDiscount'].toString())
              .toStringAsFixed(2);
          payableAmount = double.parse(tempData['payableAmount'].toString())
              .toStringAsFixed(2);
          // tempData['payableAmount'] =
          // double.parse(tempOutstanding.toString()).toStringAsFixed(2);
          revisedInterest =
              double.parse(tempData['interest'].toString()).toStringAsFixed(2);
          // revisedgstSettled =
          //     double.parse(tempData['revisedgstSettled'].toString())
          //         .toStringAsFixed(2);

          notifyListeners();
        }

        if (sellerInfo != null && sellerInfo!.totalOutstanding != null) {
          tempData['revisedTotalOutstandingAmount'] =
              double.parse(sellerInfo!.totalOutstanding!) -
                  (tempData['payableAmount'] ?? 0);
        }
      }
    }

    return tempData;
  }

  disablePaynow(bool disable) {
    isDisable = disable;
  }

  sendPayment({
    required String? buyerId,
    required String? sellerId,
    required String orderAmount,
    required String outStandingAmount,
    required String discount,
    required String settle_amount,
  }) async {
    String url = "/payment/vouch_payment";
    String? token = getIt<SharedPreferences>().getString("token");

    Map<String, dynamic> data = {
      "buyerid": buyerId,
      "sellerid": sellerId,
      "order_currency": "INR",
      "settle_amount": settle_amount,
      "order_amount": orderAmount,
      "outstanding_amount": outStandingAmount,
      "discount": discount,
      "customer_details": {
        "customer_id": getIt<SharedPreferences>().getString('id'),
        "customer_email": getIt<SharedPreferences>().getString("email"),
        "customer_phone": getIt<SharedPreferences>().getString("phoneNumber"),
      }
    };

    dynamic responseData = await getIt<DioClient>().post(url, data, token);
    print('Data.....${responseData}');
    return responseData;
  }
}
