import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/ui/push_notification/notification.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'firebase_options.dart';
import 'logic/view_models/auth_manager.dart';
import 'logic/view_models/company_details_manager.dart';
import 'logic/view_models/password_manager.dart';
import 'logic/view_models/profile_manager.dart';
import 'logic/view_models/reward_manager.dart';
import 'logic/view_models/trans_history_manager.dart';
import 'logic/view_models/transaction_manager.dart';
import 'models/helper/service_locator.dart';
import 'ui/routes/routnames.dart';
import 'package:firebase_core/firebase_core.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
bool splashid = false;
void main() async {
  // enableFlutterDriverExtension();  // for appium mobile testing
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefrences = await SharedPreferences.getInstance();
  prefrences.remove("splashid");

  Firebase.initializeApp().then((value) async {
    FirebaseInitialization.sharedInstance.registerNotification();
    // FirebaseInitialization.sharedInstance.navigate();
    FirebaseInitialization.sharedInstance.configLocalNotification();
    await FirebaseMessaging.instance.subscribeToTopic('topic1');
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  });

  runApp(const MyApp());

  Firebase.initializeApp().then((value) {
    FirebaseInitialization.sharedInstance.registerNotification();
    FirebaseInitialization.sharedInstance.configLocalNotification();
  });

  HttpOverrides.global = MyHttpOverrides();

  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 786),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => getIt<AuthManager>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<CompanyDetailsManager>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<TransactionManager>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<PasswordManager>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<RewardManager>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<ProfileManager>()),
              ChangeNotifierProvider(
                  create: (context) => getIt<TransHistoryManager>()),
            ],
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                onGenerateRoute: Routers.generateRoute,
                navigatorKey: navigatorKey,
                initialRoute: splash),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
