import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/theme/constants.dart';
import '../../../firebase_options.dart';
import 'package:yaml/yaml.dart';
import 'package:xuriti/main.dart';

import '../../push_notification/notification.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {}

  _navigateLogin() async {
    var delay = await Future.delayed(const Duration(milliseconds: 3000), () {});
    getIt<SharedPreferences>().getString('id');

    SharedPreferences shared = await SharedPreferences.getInstance();
    String? token = await getIt<SharedPreferences>().getString("token");
    // await initPlatformState();
    if (getIt<SharedPreferences>().getString('onboardViewed') == 'true') {
      if (getIt<SharedPreferences>().getString('token') == null ||
          getIt<SharedPreferences>().getString('id') == null) {
        Navigator.pushReplacementNamed(context, getStarted);
      } else {
        // final mainid = getIt<SharedPreferences>().getString('mainid');
        // if (mainid == 'mainid') {
        //   Navigator.pushNamed(context, oktWrapper);
        // }
        final payment =
            getIt<SharedPreferences>().getString('payment').toString();

        final splashid =
            getIt<SharedPreferences>().getString('splashid').toString();
        bool? checkid = getIt<SharedPreferences>().getBool('checkId');
        String sid = splashid;
        final mainid = getIt<SharedPreferences>().getBool('mainid');
        // if (splashid == null) {
        //   Navigator.pushNamed(context, oktWrapper);
        // }

        // ignore: unnecessary_null_comparison
        // if (sid == null) {
        //   Navigator.pushNamed(context, oktWrapper);
        // }
// navigationdetails
        splashid == null
            ? Navigator.pushNamed(context, oktWrapper)
            : splashid == "navigationdetails"
                ? null
                : splashid == "navigationInv"
                    ? Navigator.pushNamed(context, landing)
                    : splashid == "navigationpay"
                        ? Navigator.pushNamed(context, totalPayment)
                        : Navigator.pushNamed(context, oktWrapper);

        // }

        // setState(() {
        //   splashid == false;
        // });
        print('the slpash id is -------------$splashid');

        String? userId = getIt<SharedPreferences>().getString('id');
        UserDetails? userInfo = await getIt<AuthManager>().getUInfo(userId);
      }
    } else {
      Navigator.pushNamed(context, onBoard);
    }
  }

  void navigatemain() {}
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateLogin());
    return Scaffold(
      backgroundColor: Colours.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 180),
            Container(
                width: 158.016,
                height: 55,
                decoration: const BoxDecoration(
                    color: Colours.black,
                    image: DecorationImage(
                      image: AssetImage("assets/images/xuriti-white.png"),
                      fit: BoxFit.fill,
                    ))),
            const SizedBox(height: 70),
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset("assets/images/logo1.svg"),
            ),
            const SizedBox(
              height: 70,
            ),
            const Text(
              "“The question is not",
              style: TextStyles.textStyle2,
            ),
            const Text(
              "what you look at,but",
              style: TextStyles.textStyle2,
            ),
            const Text(
              "what you see.“",
              style: TextStyles.textStyle2,
            ),
          ],
        ),
      ),
    );
  }
}
