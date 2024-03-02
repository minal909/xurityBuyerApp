import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';

import '../../../logic/view_models/auth_manager.dart';
import '../../../models/core/user_details.dart';
import '../../theme/constants.dart';

class CompanyRegisterScreen extends StatefulWidget {
  const CompanyRegisterScreen({Key? key}) : super(key: key);

  @override
  State<CompanyRegisterScreen> createState() => _CompanyRegisterScreenState();
}

class _CompanyRegisterScreenState extends State<CompanyRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = Provider.of<AuthManager>(context).uInfo;

    String? userName = getIt<SharedPreferences>().getString('userName');
    DateTime _lastExitTime = DateTime.now();
    onWillPop() async {
      if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 2)) {
        //showing message to user
        final snack = SnackBar(
          content: Text("Press the back button again to exit the app"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snack);
        _lastExitTime = DateTime.now();
        return false; // disable back press
      } else {
        return true; //  exit the app
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
            backgroundColor: Colours.black,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colours.black,
              automaticallyImplyLeading: false,
              toolbarHeight: h1p * 8,
              flexibleSpace: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: w1p * 55, top: h1p * 4),
                    child: Column(
                      children: [
                        Text(
                          "WELCOME",
                          style: TextStyles.sName,
                        ),
                        Text(
                          (userInfo == null || userInfo.user == null)
                              ? ""
                              : userInfo.user!.name ?? "",
                          style: TextStyles.textStyle21,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: h1p * 3,
                    ),
                    child: Image.asset(
                      "assets/images/xuriti1.png",
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colours.primary,
              onPressed: () async {
                await getIt<AuthManager>().logOut();
                await getIt<SharedPreferences>().clear();
                await getIt<SharedPreferences>()
                    .setString('onboardViewed', 'true');

                Navigator.pushNamed(context, getStarted);
              },
              child: Icon(Icons.logout_outlined),
            ),
            body: Container(
                // width: maxWidth,
                decoration: const BoxDecoration(
                    color: Colours.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(26),
                      topRight: Radius.circular(26),
                    )),
                child: ListView(children: [
                  Padding(
                    padding: EdgeInsets.only(left: w1p * 35),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: h1p * 5),
                          child: Text(
                            "Companies",
                            style: TextStyles.textStyle56,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, businessRegister);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: h1p * 13),
                              child: Icon(
                                Icons.add,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h1p * 26),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Please add your company",
                            style: TextStyle(
                                color: Colours.warmGrey75, fontSize: 21),
                          ),
                          Text(
                            "to get started",
                            style: TextStyle(
                                color: Colours.warmGrey75, fontSize: 21),
                          ),
                        ],
                      ),
                    ),
                  )
                ]))),
      );
    });
  }
}
