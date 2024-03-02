import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/get_company_list_model.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/kyc_screens/kyc_verification_screen.dart';
import 'package:xuriti/ui/widgets/auto-update/update_button.dart';
import 'package:xuriti/ui/widgets/auto-update/upgrade_widget.dart';

import '../../theme/constants.dart';

class CompanyList extends StatefulWidget {
  const CompanyList({Key? key}) : super(key: key);

  @override
  State<CompanyList> createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  bool _showbtn = true;
  @override
  void initState() {
    UpgradeWidget(
      builder: (BuildContext context, Upgrader upgrader) {
        return UpdateButton();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    List<GetCompany>? company =
        Provider.of<TransactionManager>(context).companyList;

    onWillPop() async {
      DateTime _lastExitTime = DateTime.now();

      if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 3)) {
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
bool checkid = false;
        getIt<SharedPreferences>().setBool('checkId', checkid);
    return LayoutBuilder(builder: (context, constraints) {
      // double maxHeight = constraints.maxHeight;
      // double maxWidth = constraints.maxWidth;
      // double h1p = maxHeight * 0.01;
      // double h10p = maxHeight * 0.1;
      // double w10p = maxWidth * 0.1;
      // double w1p = maxWidth * 0.01;
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      bool isSessionExpired = false;

      return WillPopScope(
          onWillPop: onWillPop,
          child: SafeArea(
              child: UpgradeAlert(
            child: Scaffold(
                floatingActionButton: AnimatedSlide(
                  offset: _showbtn ? Offset.zero : Offset(0, 2),
                  duration: duration,
                  child: AnimatedOpacity(
                    opacity: _showbtn ? 1 : 0,
                    duration: duration,
                    child: FloatingActionButton(
                      backgroundColor: Colours.tangerine,
                      child: Icon(
                        Icons.logout,
                        color: Colours.white,
                      ),
                      onPressed: () async => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Logging out'),
                          content: const Text('Are you sure?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colours.tangerine),
                              ),
                            ),
                            TextButton(
                              onPressed: () async {
                                await getIt<AuthManager>().logOut();
                                await getIt<SharedPreferences>().clear();
                                await getIt<SharedPreferences>()
                                    .setString('onboardViewed', 'true');

                                Navigator.pushNamed(context, getStarted);
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colours.tangerine),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                        padding: EdgeInsets.symmetric(
                            vertical: h1p * 2, horizontal: w1p * 3),
                        child: Image.asset(
                          "assets/images/xuriti1.png",
                        ),
                      ),
                    ],
                  ),
                ),
                body: OrientationBuilder(builder: (context, orientation) {
                  return ProgressHUD(
                    child: Container(
                      width: maxWidth,
                      decoration: const BoxDecoration(
                          color: Colours.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                          )),
                      child: NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          final ScrollDirection direction =
                              notification.direction;
                          setState(() {
                            if (direction == ScrollDirection.reverse) {
                              _showbtn = false;
                            } else if (direction == ScrollDirection.forward) {
                              _showbtn = true;
                            }
                          });
                          return true;
                        },
                        child: Container(
                          height: double.infinity,
                          child: CustomScrollView(shrinkWrap: true, slivers: [
                            SliverList(
                                delegate: SliverChildListDelegate(
                              [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: h1p * 2,
                                          bottom: h1p * 2,
                                          left: w10p * 4,
                                          right: w1p * 20),
                                      child: Text(
                                        "Retailer",
                                        style: TextStyles.textStyle56,
                                      ),
                                    ),
                                    SizedBox(
                                      width: w1p * 5,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, businessRegister);
                                        },
                                        child: Icon(Icons.add))
                                  ],
                                )
                              ],
                            )),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final progress = ProgressHUD.of(context);
                                final coname =
                                    company[index].companyDetails == null
                                        ? ""
                                        : company[index]
                                                .companyDetails!
                                                .companyName ??
                                            "";
                                final compname = [coname];

                                final gstno =
                                    company[index].companyDetails!.gstin ?? '';

                                String newLineString() {
                                  StringBuffer sb = new StringBuffer();
                                  for (String line in compname) {
                                    sb.write(line + "\n");
                                  }
                                  return sb.toString();
                                }

                                return InkWell(
                                    onTap: () async {
                                      print("clicked...........");
                                      String? companyId =
                                          company[index].companyDetails!.sId;
                                      String? companyName = company[index]
                                          .companyDetails!
                                          .companyName;
                                      String? companyStatus =
                                          company[index].companyDetails!.status;
                                      if (companyStatus == "Approved") {
                                        print("Active");
                                        Text("Active");
                                      }
                                      await getIt<SharedPreferences>()
                                          .setString('companyId', companyId!);
                                      await getIt<SharedPreferences>()
                                          .setString(
                                              'companyStatus', companyStatus!);
                                      await getIt<SharedPreferences>()
                                          .setString(
                                              'companyName', companyName!);
                                      await getIt<SharedPreferences>()
                                          .setInt('companyIndex', index);
                                      if (companyStatus == "Approved") {
                                        Navigator.pushReplacementNamed(
                                            context, landing);
                                      } else if (companyStatus == "Hold") {
                                        showDialog<String>(
                                          context: context,

                                          builder: (BuildContext context) =>
                                              // Container(
                                              //   decoration: const BoxDecoration(
                                              //       color: Colours.white,
                                              //       borderRadius: BorderRadius.only(
                                              //         topLeft: Radius.circular(26),
                                              //         topRight: Radius.circular(26),
                                              //       )),
                                              //   child:
                                              AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            title: const Text(
                                              'Update your KYC',
                                              style: TextStyles.textStyle56,
                                            ),
                                            content: Text(
                                              // 'You are not allowed to perform any operation, $companyName status is $companyStatus. Please proceed to KYC Verification.',
                                              '$companyName status is In-Progress. Please proceed for KYC verification process',
                                              style: TextStyles.textStyle117,
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    // autofocus: true,
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  KycVerification()));
                                                    },
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    ),
                                                    // onPressed: () =>
                                                    //     Navigator.pop(context, 'Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colours.paleRed,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          // ),
                                        );
                                      } else if (companyStatus == "Inactive") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                duration: Duration(seconds: 5),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                  'You are not allowed to perform any operation, $companyName status is $companyStatus. Please contact to Xuriti team.',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )));
                                      } else if (companyStatus ==
                                          "In-Progress") {
                                        showDialog<String>(
                                          context: context,

                                          builder: (BuildContext context) =>
                                              // Container(
                                              //   decoration: const BoxDecoration(
                                              //       color: Colours.white,
                                              //       borderRadius: BorderRadius.only(
                                              //         topLeft: Radius.circular(26),
                                              //         topRight: Radius.circular(26),
                                              //       )),
                                              //   child:
                                              AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            title: const Text(
                                              'Update your KYC',
                                              style: TextStyles.textStyle56,
                                            ),
                                            content: Text(
                                              // 'You are not allowed to perform any operation, $companyName status is $companyStatus. Please proceed to KYC Verification.',
                                              '$companyName status is In-Progress. Please proceed for KYC verification process',
                                              style: TextStyles.textStyle117,
                                            ),
                                            actions: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    autofocus: true,
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          new MaterialPageRoute(
                                                              builder: (context) =>
                                                                  KycVerification()));
                                                    },
                                                    child: Icon(
                                                      Icons.check,
                                                      color: Colors.green,
                                                    ),
                                                    // onPressed: () =>
                                                    //     Navigator.pop(context, 'Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Cancel'),
                                                    child: Icon(
                                                      Icons.close,
                                                      color: Colours.paleRed,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                            // ),
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: w1p * 5,
                                          right: w1p * 5,
                                          bottom: h1p * 3,
                                        ),
                                        child: Container(
                                            height: orientation ==
                                                    Orientation.portrait
                                                ? maxHeight * 0.1
                                                : maxHeight * 0.2,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 8.0,
                                                      color: Colours.primary)
                                                ],
                                                border: Border.all(
                                                    color: Colours.primary,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255)),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: w1p * 2,
                                                  right: 6,
                                                  bottom: h1p * 0.3,
                                                  top: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    orientation ==
                                                            Orientation.portrait
                                                        ? MainAxisAlignment
                                                            .spaceBetween
                                                        : MainAxisAlignment
                                                            .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  
                                                  orientation ==
                                                          Orientation.portrait
                                                      ? Expanded(
                                                          child: SizedBox())
                                                      : Container(
                                                          width: 2,
                                                        ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width: maxWidth * 0.65,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              company[index]
                                                                          .companyDetails ==
                                                                      null
                                                                  ? ""
                                                                  : company[index]
                                                                          .companyDetails!
                                                                          .companyName ??
                                                                      "",
                                                              style: TextStyles
                                                                  .textStyleC85,
                                                            ),
                                                            Text(
                                                              "GST No :$gstno",
                                                              style: TextStyles
                                                                  .textStyleC71,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // Expanded(child: SizedBox()),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Text(''),
                                                      SizedBox(
                                                        width: 7.5,
                                                      ),
                                                      CompanyDetails
                                                          .companyStatusToIcon(
                                                              company[index]
                                                                      .companyDetails
                                                                      ?.status ??
                                                                  "unknown"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ));
                                },
                                childCount: company.length,
                              ))
                            ]),
                          ),
                        ),
                      ),
                    );
                      })))));
    });
  }
}
