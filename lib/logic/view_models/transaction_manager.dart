

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/reward_manager.dart';
import 'package:xuriti/models/core/get_company_list_model.dart';
import 'package:xuriti/models/core/invoice_model.dart';

import 'package:xuriti/models/services/dio_service.dart';
import 'package:open_file_safe/open_file_safe.dart';

import '../../models/core/transactional_model.dart';
import '../../models/helper/service_locator.dart';

class TransactionManager extends ChangeNotifier {
  Transaction? transaction;
  Invoices? invoices;
  Invoices? tempInvoice;
  dynamic selectedCreditLimit;
  dynamic availableCredit;
  dynamic compDetails;

  // dynamic credit;

  List<Invoice> pendingInvoice = [];
  List<Invoice> cnInvoice = [];
  List<Invoice> paidInvoices = [];
  // List<Invoice> confirmedInInvoices = [];
  // List<Invoice> confirmedCNInvoices = [];
  List<Invoice> invoiceType = [];
  List<Invoice> transactionInvoice = [];
  List<Invoice> confirmedInvoices = [];
  String currentCompanyId = 'none';

  dynamic totalAmt = 0;
  Invoice? currentInvoice;
  Invoice1? notificationInv;
  TransactionInvoice? selectedInvoice;
  Invoice? currentPaidInvoice;
  bool? isPending;
  String errorMessage = "";
  List<GetCompany> companyList = [];
  int paymentCounter = 0;
  double payableAmount = 0;

  getTransactionLedger(String? id) async {
    String? companyId = getIt<SharedPreferences>().getString('companyId');
    try {
      String url = "/ledger/companies/transaction_ledger?buyer=$companyId";
      String? token = getIt<SharedPreferences>().getString("token");
      dynamic responseData = await getIt<DioClient>().get(url, token: token);
      print("responseData =========> $responseData");

      if (responseData != null && responseData['status'] == true) {
        TransactionModel transactionModel =
            TransactionModel.fromJson(responseData);

        return transactionModel;
      } else if (responseData == null) {
        return TransactionModel();
      }
    } catch (e) {
      print(e);
    }
  }

  getInvDetails(String? id) async {
    String? companyId = getIt<SharedPreferences>().getString('companyId');
    try {
      String url = "/invoice/invoices?_id=$id";
      String? token = getIt<SharedPreferences>().getString("token");
      dynamic responseData = await getIt<DioClient>().get(url, token: token);
      print("responseData =========> $responseData");

      if (responseData != null && responseData['status'] == true) {
        Invoice invDetails = Invoice.fromJson(responseData);

        return invDetails;
      } else if (responseData == null) {
        return Invoice();
      }
    } catch (e) {
      print(e);
    }
  }

 
  getTransactionData(transactionData) {
    transaction = transactionData;
    notifyListeners();
  }

  Future<TransactionModel?> getTransactionStatement(String? id) async {
    TransactionModel? transactionModel;
    String? companyId = getIt<SharedPreferences>().getString('companyId');
    try {
      String url = "ledger/companies/transaction_ledger/$companyId";
      String? token = getIt<SharedPreferences>().getString("token");
      // notifyListeners();
      dynamic responseData = await getIt<DioClient>().get(url, token: token);
      print("responseData =========> $responseData");

      if (responseData['status'] == true) {
        return responseData;
      }
    } catch (e) {
      print(e);
    }
    return transactionModel;
  }

  getTotalOutstandingAmount(companyId) async {
    if (companyId != null) {
      // String url = "/invoice/paymentsummary/?buyer=$companyId";
      String url = "/payment/total_payable/$companyId";

      String? token = getIt<SharedPreferences>().getString("token");
      dynamic responseData = await getIt<DioClient>().get(url, token: token);

      if (responseData != null && responseData['status'] == true) {
        dynamic outstandingAmountObj =
            TotalOutstandingAmount.fromJson(responseData);
        if (outstandingAmountObj != null) {
          if (outstandingAmountObj!.outstaningAmount != null) {
            return outstandingAmountObj!.outstaningAmount;
          }
        }
      }
    }
    return 0;
  }

  getInetialInvoices({String? id, bool resetConfirmedInvoices = false}) async {
    //when the company is changed, we need to reset the invoices
    String? companyId = getIt<SharedPreferences>().getString('companyId');
    if (companyId == null) {
      print('//////////////error- companyId null in getInetialInvoices');
      return Invoices(status: false);
    }

    if (confirmedInvoices.length == 0 ||
        resetConfirmedInvoices ||
        currentCompanyId != companyId) {
      //reset all invoices arrays to empty array
      currentCompanyId = companyId;
      confirmedInvoices = [];
      paidInvoices = [];
      pendingInvoice = [];
      cnInvoice = [];

      //fetch only the first 5 invoices for all pages
      String? token = getIt<SharedPreferences>().getString("token");
      await getCreditLimit(token);
      await getIt<RewardManager>().getRewards();
      await addInvoices(id: id, status: 'Pending', type: 'IN');
      await addInvoices(id: id, status: 'Paid', type: 'IN');
      //get all cn invoices(pagination is not implemented for CN invoices)  //getOutsta
      String urlCn = "/invoice/search-invoice/$id/buyer?invoice_type=CN";
      dynamic responseDataCn =
          await getIt<DioClient>().get(urlCn, token: token);
      if (responseDataCn != null) {
        invoices = Invoices.fromJson(responseDataCn);
        List<Invoice> invoiceList = invoices?.invoice ?? [];
        cnInvoice = invoiceList;
      }
      ////////////////////////////////////add all cn invoices done
      String url =
          "/invoice/search-invoice/$id/buyer?multi_invoice_status_A=Confirmed&multi_invoice_status_B=Partpay&invoice_type=IN&limit=5&page=1";
      //rename shouldCalculateTotalOutstandingAmount to getOutstandingAmount
      dynamic responseData = await getIt<DioClient>().get(url, token: token);
      if (responseData == null) {
        print('////////////////////response null');
        return Invoices(status: false);
      }
      invoices = Invoices.fromJson(responseData);
      totalAmt = await getTotalOutstandingAmount(companyId);
      List<Invoice> invoiceList = invoices?.invoice ?? [];
      confirmedInvoices = invoiceList;

      notifyListeners();
      return Invoices(invoice: confirmedInvoices, status: true);
    }
    return Invoices(status: false);
  }

  addInvoices(
      {required String? id, String? status, String? type = 'IN'}) async {
    int limit = 5;
    if (id != null) {
      String url;
      String? token = getIt<SharedPreferences>().getString("token");
      int index = 0;
      if (type == 'IN') {
        switch (status) {
          case 'Confirmed':
          case 'Partpay':
            index = confirmedInvoices.length;
            break;
          case 'Paid':
            index = paidInvoices.length;
            break;
          case 'Pending':
            index = pendingInvoice.length;
            break;
        }
        if (index % limit != 0) {
          return false;
        }
        int page = (index ~/ limit) + 1;
        if (status == 'Confirmed' || status == 'Partpay') {
          url =
              "/invoice/search-invoice/$id/buyer?multi_invoice_status_A=Confirmed&multi_invoice_status_B=Partpay&invoice_type=$type&limit=$limit&page=$page";
        } else {
          url =
              "/invoice/search-invoice/$id/buyer?invoice_status=$status&invoice_type=$type&limit=$limit&page=$page";
        }
      } else {
        // index = cnInvoice.length;
        // if (index % limit != 0) {
        //   return false;
        // }
        // int page = index ~/ limit;
        // url =
        //     "/invoice/search-invoice/$id/buyer?invoice_type=$type&limit=$limit&page=$page";
        return false;
      }

      dynamic responseData = await getIt<DioClient>().get(url, token: token);

      if (responseData == null || responseData['status'] != true) {
        // return Future.error('responseData invalid');
        return false;
      } else {
        invoices = Invoices.fromJson(responseData);
        List<Invoice> invoiceList = invoices?.invoice ?? [];
        if (invoiceList.isNotEmpty) {
          if (type == 'IN') {
            switch (status) {
              case 'Confirmed':
              case 'Partpay':
                confirmedInvoices = confirmedInvoices + invoiceList;
                break;
              case 'Paid':
                paidInvoices = paidInvoices + invoiceList;
                break;
              case 'Pending':
                pendingInvoice = pendingInvoice + invoiceList;
                break;
            }
          } else {
            // cnInvoice = cnInvoice + invoiceList;
          }

          notifyListeners();
          if (invoiceList.length == 5) {
            return true;
          } else {
            //end of invoices
            // return [];
            return false; //this is used to see if more invoices are there
          }
        }
      }
    } else {
      return Future.error('id needed');
    }
  }

  invoiceDispose() {
    confirmedInvoices = [];
    paidInvoices = [];
    pendingInvoice = [];
    cnInvoice = [];
  }

  getCreditLimit(
    token,
  ) async {
    // String? gstNo = getIt<SharedPreferences>().getString("gstIn");
    String? companyId = getIt<SharedPreferences>().getString('companyId');

    String url = "/entity/entity/$companyId";

    dynamic responseData = await getIt<DioClient>().get(url, token: token);

    if (responseData != null) {
      if (responseData['status'] == true && responseData['company'] != null) {
        dynamic totalcredit = responseData['company']['creditLimit'];
        dynamic availCredit = responseData['company']['avail_credit'];

        dynamic credit = availCredit / 100000;
        totalcredit = totalcredit / 100000;

        totalcredit = totalcredit.toString();
        credit = credit.toString();
        credit = double.parse(credit).toStringAsFixed(2); // available credit

        print("credit in lacs ---->$credit");

        selectedCreditLimit =
            double.parse(totalcredit).toStringAsFixed(2); // total credit

        availableCredit = credit;
        // availableCredit = double.parse(credit).toStringAsFixed(2);

        print("Credit Limit--------------------->$availableCredit");
        notifyListeners();
      }

      return '$availableCredit, $selectedCreditLimit';
    }
  }

  getAvailableCreditLimit(
    token,
  ) async {
    // String? gstNo = getIt<SharedPreferences>().getString("gstIn");
    String? companyId = getIt<SharedPreferences>().getString('companyId');

    String url = "/entity/entity/$companyId";

    dynamic responseData = await getIt<DioClient>().get(url, token: token);

    if (responseData != null) {
      if (responseData['status'] == true && responseData['company'] != null) {
        //  String credit = responseData['company']['creditLimit'].toString();
        String availCredit = responseData['company']['avail_credit'];

        //  selectedCreditLimit = double.parse(credit).toStringAsFixed(2);
        availableCredit = double.parse(availCredit).toStringAsFixed(2);

        dynamic credit = availableCredit / 100000;

        notifyListeners();
      }
      return availableCredit;
    }
  }

  getCompanyDetails(
    token,
  ) async {
    // String? gstNo = getIt<SharedPreferences>().getString("gstIn");
    String? companyId = getIt<SharedPreferences>().getString('entityid');

    String url = "/entity/entity/$companyId";

    dynamic responseData = await getIt<DioClient>().get(url, token: token);

    if (responseData != null) {
      if (responseData['status'] == true && responseData['company'] != null) {
        //  String credit = responseData['company']['creditLimit'].toString();
        compDetails = responseData['company'];
        notifyListeners();
      }
      return compDetails;
    }
  }



  getCompanyList(
    String? id,
    String? token,
    BuildContext context,
    Function(bool value) isSessionExpired,
  ) async {
    String url = "/entity/entities/$id";
    companyList = [];
    print(url);
    dynamic responseData = await getIt<DioClient>().get(url, token: token);
    print(responseData.toString());

    if (responseData['statusCode'] == 440) {
      isSessionExpired(true);
    } else if (responseData != null &&
        responseData['company'] != null &&
        responseData['company'].length > 0) {
      List<dynamic> companies = responseData['company'];

      for (var company in companies) {
        if (company.containsKey('company') && company['company'] != null) {
          GetCompany singleCompany = GetCompany.fromJson(company);
          companyList.add(singleCompany);
        }
      }
    } else {
      // print(responseData.toString());
    }
    return companyList;
  }

  changeSelectedInvoice(invoice) {
    currentInvoice = invoice;
    notifyListeners();
  }

  getNotificationInv(invoice) {
    notificationInv = invoice;
    notifyListeners();
  }

 

  transStateInvoice(invoice) {
    selectedInvoice = invoice;
    notifyListeners();
  }

  changePaidInvoice(invoice) {
    currentPaidInvoice = invoice;
    notifyListeners();
  }

  setWidgetType(widgetType) {
    isPending = widgetType;
  }

  changeInvoiceStatus(
      String? id,
      String status,
      int index,
      Invoice inv,
      String timeStamp,
      bool userConsent,
      String userComment,
      String userConsentMessage) async {
    String url = "/invoice/status";
    print(id);
    Map<String, dynamic> data = {
      "invoiceID": id,
      "status": status,
      "user_comment": userComment,
      "user_consent_message": userConsentMessage,
      "reason": "xyz",
      "userConsentGiven": userConsent,
      "consentimeStamp": timeStamp,
    };
    print(data);
    // print("status");
    String? token = getIt<SharedPreferences>().getString('token');
    dynamic responseData =
        await getIt<DioClient>().patch(url, data, token: token);
    print("responseData confirm ----$responseData");
    if (responseData != null && responseData['status'] == true) {
      String message = responseData["message"];

      if (responseData["message"] == "Invoice confirmed") {
        confirmedInvoices.add(inv);

        pendingInvoice.removeAt(index);
        notifyListeners();
        return message;
      } else if (responseData["message"] == "Invoice rejected") {
        pendingInvoice.removeAt(index);
        notifyListeners();
        return message;
      }
      return message;
    } else {
      return "Unexpected error occurred please try again later";
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {}
  }

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return;

    print('Path:${file.path}');

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(
        url,
        onReceiveProgress: showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,
        ),
      );
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
