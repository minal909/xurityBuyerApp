import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:xuriti/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart' as inst;
import 'package:get/get_core/src/get_main.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/invoices_screens/invoices_screen.dart';
import 'package:xuriti/ui/screens/starting_screens/landing_Screen.dart';

import '../../logic/view_models/company_details_manager.dart';
import '../../main.dart';
import '../../models/core/seller_list_model.dart';
import '../../models/helper/service_locator.dart';
import '../../models/services/dio_service.dart';

class FirebaseInitialization {
  FirebaseInitialization._privateConstructor();

  String? fcmToken;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static FirebaseInitialization sharedInstance =
      FirebaseInitialization._privateConstructor();

  void registerNotification() async {
    try {
      if (Platform.isIOS) {
      } else {
        var val = await Permission.notification.isDenied;
        if (val) {}
      }

      var apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      fcmToken = await FirebaseMessaging.instance.getToken();
      String tkn = fcmToken.toString();
      // String deviceToken =
      getIt<SharedPreferences>().setString('theToken', tkn);

      log(fcmToken.toString());
      print('device token,,,,,,,,,,,,,,,,,,,,,, $fcmToken');
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
          final data = message.data;
          print('onMessage:******************* ${data['Inv_id']}');
          showNotification(message.data, message.notification);

          return;
        },
        onError: (error) {
          print(error);
        },
        // onDone: () {
        //   navigatorKey.currentState!.pushNamed(InvoiceScreen);
        // },
      );
    } catch (e) {
      return;
    }
  }

  //configure notification
  void configLocalNotification() async {
    // String splashid = 'splashid';
    // getIt<SharedPreferences>().setString('splashid', splashid);
    // inst.Get.put(SharedPreferences.getInstance());
    // GetIt.instance.registerSingleton<SharedPreferences>(
    //     await SharedPreferences.getInstance());

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      // bool mainid = false;
      // getIt<SharedPreferences>().setBool('mainid', mainid);
      // getIt<SharedPreferences>().getString('id');
      bool checkid = true;
      getIt<SharedPreferences>().setBool('checkId', checkid);
      SharedPreferences shared = await SharedPreferences.getInstance();
      String? token = await getIt<SharedPreferences>().getString("token");

      if (message != null) {
        dynamic responseData =
            await getIt<DioClient>().getCompName(message.data["entityid"]);
        String entId = message.data['entityid'];

        getIt<SharedPreferences>().setString('companyId', entId);

        String companyname = responseData['company']['company_name'];
        getIt<SharedPreferences>().setString('companyName', companyname);

        String entityid = message.data['entityid'];
        getIt<SharedPreferences>().setString('entityid', entityid);

        if (message.data['module'] == 'Payments') {
          String splashid = 'navigationpay';
          getIt<SharedPreferences>().setString('splashid', splashid);
        } else if (message.data['module'] == 'Invoices' &&
            message.data['target'] == null) {
          String splashid = 'navigationInv';
          getIt<SharedPreferences>().setString('splashid', splashid);
        } else if (message.data['module'] == 'Invoices' &&
            message.data['target'] != null) {
          String splashid = 'navigationdetails';
          getIt<SharedPreferences>().setString('splashid', splashid);
          String targetid = message.data['target'];
          getIt<SharedPreferences>().setString('targetid', targetid);
          bool checkid = true;
          getIt<SharedPreferences>().setBool('checkId', checkid);
          dynamic responseData =
              await getIt<DioClient>().getInvDetails(targetid);
          var invoice = responseData['invoice'][0];
          String iddt = invoice['invoice_date'];
          getIt<SharedPreferences>().setString('invDate', iddt);
          var intrest = invoice['paid_interest'];
          var disc = invoice['paid_discount'];
          var duedt = invoice['invoice_due_date'];
          String checkUndefined =
              invoice['bill_details']['gst_summary']['total_tax'];
          String billVal = invoice['bill_details']['gst_summary']['total_tax'];
          String invamt = invoice['invoice_amount'];
          String outAmt = invoice['outstanding_amount'].toString();
          int crLimt = invoice['buyer']['creditLimit'];
          // String crLimit = crLimt.toString();
          var availCrd = invoice['buyer']['avail_credit'].toStringAsFixed(2);

          String availCr = availCrd.toString();
          String duedate = duedt.toString();
          String pDisc = disc.toString();

          String intr = intrest.toString();
          String compname = invoice['seller']['company_name'];
          String address = invoice['seller']['address'];
          String state = invoice['seller']['state'];
          String gstin = invoice['seller']['gstin'];
          dynamic creditLmt = invoice['buyer']['creditLimit'];
          dynamic crdlmt = creditLmt / 100000;
          dynamic crdLimit = crdlmt.toString();
          getIt<SharedPreferences>().setString('crdLimit', crdLimit);

          dynamic availCredit = invoice['buyer']['avail_credit'];
          dynamic avlCredit = availCredit / 100000;
          dynamic availLimit = crdlmt.toString();
          getIt<SharedPreferences>().setString('availLimit', availLimit);

          String invno = invoice['invoice_number'];
          String invstatus = invoice['invoice_status'];
          getIt<SharedPreferences>().setString('invno', invno);
          getIt<SharedPreferences>().setString('invstatus', invstatus);

          getIt<SharedPreferences>().setString('state', state);
          getIt<SharedPreferences>().setString('gstin', gstin);

          getIt<SharedPreferences>().setString('address', address);

          getIt<SharedPreferences>().setString('billValue', billVal);
          getIt<SharedPreferences>().setString('compname', compname);

          getIt<SharedPreferences>().setString('undefined', checkUndefined);

          getIt<SharedPreferences>().setString('inv_amt', invamt);

          getIt<SharedPreferences>().setString('outstanding', outAmt);

          getIt<SharedPreferences>().setString('duedate', duedate);

          getIt<SharedPreferences>().setString('paidintr', intr);
          getIt<SharedPreferences>().setString('paidDisc', pDisc);

          navigatorKey.currentState!.pushNamed(upcomingDetails);
        }

        // _handleMessage(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      bool checkid = true;
      getIt<SharedPreferences>().setBool('checkId', checkid);
      _handleMessage(message);
    });
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void _handleMessage(RemoteMessage message) async {
    String splashid = 'splashid';
    getIt<SharedPreferences>().setString('splashid', splashid);
    if (message.data != null) {
      dynamic responseData =
          await getIt<DioClient>().getCompName(message.data["entityid"]);
      print(
          "response of comp name for notif ${responseData['company']['company_name']}");
      String entId = message.data['entityid'];

      getIt<SharedPreferences>().setString('companyId', entId);

      String companyname = responseData['company']['company_name'];
      getIt<SharedPreferences>().setString('companyName', companyname);

      String entityid = message.data['entityid'];
      getIt<SharedPreferences>().setString('entityid', entityid);

      if (message.data['module'] == 'Invoices' &&
          message.data['target'] != null) {
        String targetid = message.data['target'];
        getIt<SharedPreferences>().setString('targetid', targetid);
        bool checkid = true;
        getIt<SharedPreferences>().setBool('checkId', checkid);
        dynamic responseData = await getIt<DioClient>().getInvDetails(targetid);
        var invoice = responseData['invoice'][0];
        String iddt = invoice['invoice_date'];
        getIt<SharedPreferences>().setString('invDate', iddt);
        var intrest = invoice['paid_interest'];
        var disc = invoice['paid_discount'];
        var duedt = invoice['invoice_due_date'];
        String checkUndefined =
            invoice['bill_details']['gst_summary']['total_tax'];
        String billVal = invoice['bill_details']['gst_summary']['total_tax'];
        String invamt = invoice['invoice_amount'];
        String outAmt = invoice['outstanding_amount'].toString();
        int crLimt = invoice['buyer']['creditLimit'];
        // String crLimit = crLimt.toString();
        var availCrd = invoice['buyer']['avail_credit'].toStringAsFixed(2);

        String availCr = availCrd.toString();
        String duedate = duedt.toString();
        String pDisc = disc.toString();

        String intr = intrest.toString();
        String compname = invoice['seller']['company_name'];
        String address = invoice['seller']['address'];
        String state = invoice['seller']['state'];
        String gstin = invoice['seller']['gstin'];
        dynamic creditLmt = invoice['buyer']['creditLimit'];
        dynamic crdlmt = creditLmt / 100000;
        dynamic crdLimit = crdlmt.toString();
        getIt<SharedPreferences>().setString('crdLimit', crdLimit);

        dynamic availCredit = invoice['buyer']['avail_credit'];
        dynamic avlCredit = availCredit / 100000;
        dynamic availLimit = crdlmt.toString();
        getIt<SharedPreferences>().setString('availLimit', availLimit);

        String invno = invoice['invoice_number'];
        String invstatus = invoice['invoice_status'];
        getIt<SharedPreferences>().setString('invno', invno);
        getIt<SharedPreferences>().setString('invstatus', invstatus);

        getIt<SharedPreferences>().setString('state', state);
        getIt<SharedPreferences>().setString('gstin', gstin);

        getIt<SharedPreferences>().setString('address', address);

        getIt<SharedPreferences>().setString('billValue', billVal);
        getIt<SharedPreferences>().setString('compname', compname);

        getIt<SharedPreferences>().setString('undefined', checkUndefined);

        getIt<SharedPreferences>().setString('inv_amt', invamt);

        getIt<SharedPreferences>().setString('outstanding', outAmt);

        getIt<SharedPreferences>().setString('duedate', duedate);

        getIt<SharedPreferences>().setString('paidintr', intr);
        getIt<SharedPreferences>().setString('paidDisc', pDisc);

        navigatorKey.currentState!.pushNamed(upcomingDetails);
      } else if (message.data['module'] == 'Invoices' &&
          message.data['target'] == null) {
        String splashid = 'splashid';
        getIt<SharedPreferences>().setString('splashid', splashid);
        String entityid = message.data['entityid'];
        getIt<SharedPreferences>().setString('entityid', entityid);

        navigatorKey.currentState!.pushNamed(landing);

        var targetid = null;
        getIt<SharedPreferences>().setString('targetid', targetid);
      } else if (message.data['module'] == 'Payments') {
        getIt<CompanyDetailsManager>().getSellerList(message.data["entityid"]);
        String splashid = 'splashid';
        getIt<SharedPreferences>().setString('splashid', splashid);
        String payment = 'paynow';
        getIt<SharedPreferences>().setString('payment', payment);

        navigatorKey.currentState!.pushNamed(totalPayment);
      }
    }
  }

  void showNotification(
      Map<String, dynamic> data, RemoteNotification? remoteNotification) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'com.transport.trnasportplus',
      'Transport plus',
      channelDescription: 'your channel description',
      playSound: true,
      // icon: "@mipmap/ic_launcher",
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.show();

    await flutterLocalNotificationsPlugin
        .show(
          0,
          remoteNotification?.title ?? "",
          remoteNotification?.body ?? '',
          platformChannelSpecifics,
          payload: jsonEncode(data),
        )
        .then((value) {});
  }
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}
