import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/company_details_manager.dart';
import 'package:xuriti/models/core/get_company_list_model.dart';
import 'package:xuriti/models/core/invoice_model.dart';
import 'package:xuriti/ui/screens/bhome_screens/bhome_screen.dart';
import 'package:xuriti/ui/screens/invoices_screens/invoices_screen.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../widgets/drawer_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    getIt<CompanyDetailsManager>().resetSellerInfo();

    init();
    super.initState();
  }

  void refreshFutureToGetInvoicesList() {
    setState(() {});
  }

  Future init() async {
    String splash = 'splashid';
    getIt<SharedPreferences>().setString('splashid', splash);
  }

  GlobalKey<ScaffoldState> sk = GlobalKey();
  int currentIndex = 0;
  String? id = '';
  bool isId = false;
  DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
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

    String? entityid = getIt<SharedPreferences>().getString('entityid');
    bool? checkid = getIt<SharedPreferences>().getBool('checkId');
    if (checkid == true) {
      if (entityid != null) {
        setState(() {
          String? id = entityid;
          this.id = id;
          isId = true;
          currentIndex = 1;
        });
      }
    } else {
      setState(() {
        String? id = getIt<SharedPreferences>().getString('companyId');
        this.id = id;
        isId = false;
      });
    }

    String? compName = getIt<SharedPreferences>().getString('companyName');
    String comp2 = compName.toString();
    final company12 = [comp2];
    String getNewLineString() {
      StringBuffer sb = new StringBuffer();
      for (String line in company12) {
        sb.write(line + "\n");
      }
      return sb.toString();
    }

    // String getNewLineString() {
    //   StringBuffer sb = new StringBuffer();
    //   for (String line in compName) {
    //     sb.write(line + "\n");
    //   }
    //   return sb.toString();
    // }

    // String getNewLineString() {
    //   StringBuffer sb = new StringBuffer();
    //   for (String line in compName) {
    //     sb.write(line + "\n");
    //   }
    //   return sb.toString();
    // }

    String? compStatus = getIt<SharedPreferences>().getString('companyStatus');

    // CompanyDetails? status;
    List<Widget> screens = [
      BhomeScreen(),
      InvoicesScreen(refreshingFunction: refreshFutureToGetInvoicesList),
    ];

    return ProgressHUD(
      child: LayoutBuilder(builder: (context, constraints) {
        final progress = ProgressHUD.of(context);

        double maxHeight = constraints.maxHeight;
        double maxWidth = constraints.maxWidth;
        double h1p = maxHeight * 0.01;
        double h10p = maxHeight * 0.1;
        double w10p = maxWidth * 0.1;
        return WillPopScope(
          onWillPop: onWillPop,
          child: SafeArea(
              child: Scaffold(
            body: FutureBuilder(
                future: checkid!
                    ? getIt<TransactionManager>().getInetialInvoices(
                        id: getIt<SharedPreferences>().getString('entityid'))
                    : getIt<TransactionManager>().getInetialInvoices(id: id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final progress = ProgressHUD.of(context);

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      Invoices data = snapshot.data as Invoices;
                      String getNewLineString() {
                        StringBuffer sb = new StringBuffer();
                        for (String line in company12) {
                          sb.write(line + "\n");
                        }
                        return sb.toString();
                      }

                      return Scaffold(
                        key: sk,
                        endDrawer: DrawerWidget(
                          maxHeight: maxHeight,
                          maxWidth: maxWidth,
                        ),
                        backgroundColor: Colours.black,
                        appBar: AppBar(
                          backgroundColor: Colours.black,
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Image.asset("assets/images/xuriti1.png"),
                          ),
                          title: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  // left: 18,
                                  // right: 5,
                                  // top: 31,
                                  ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      // left: 18,
                                      // right: 5,
                                      top: 10,
                                    ),
                                    child: Container(
                                      width: maxWidth * 0.57,
                                      // height: maxHeight * 0.10,
                                      child: Text(
                                        getNewLineString(),
                                        // getNewLineString(),
                                        // maxLines: 4,
                                        style: TextStyles.textStyle,
                                      ),
                                    ),
                                  ),

                                  // SizedBox(
                                  //   width: 4,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      // left: 18,
                                      // right: 5,
                                      top: 10,
                                    ),
                                    child: CompanyDetails.companyStatusToIcon(
                                        compStatus),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            InkWell(
                              onTap: () {
                                sk.currentState!.openEndDrawer();
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(18),
                                  child: SvgPicture.asset(
                                      "assets/images/menubutton.svg")),
                            ),
                          ],
                        ),
                        body: SafeArea(child: screens[currentIndex]),
                        bottomNavigationBar: Container(
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    context.showLoader();

                                    await Future.delayed(
                                        const Duration(seconds: 1));

                                    setState(() {
                                      currentIndex = 0;
                                    });
                                    context.hideLoader();
                                  },
                                  child: Container(
                                    height: h10p * 0.5,
                                    width: w10p * 4.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: currentIndex == 0
                                            ? Colours.tangerine
                                            : Colours.black),
                                    child: const Center(
                                      child: Text(
                                        "Home",
                                        style: TextStyles.textStyle,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    context.showLoader();

                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    setState(() {
                                      currentIndex = 1;
                                    });
                                    getIt<TransactionManager>()
                                        .changeSelectedInvoice(
                                            data.invoice?[0]);
                                    context.hideLoader();
                                  },
                                  child: Container(
                                    height: h10p * 0.5,
                                    width: w10p * 4.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: currentIndex == 1
                                            ? Colours.tangerine
                                            : Colours.black),
                                    child: const Center(
                                      child: Text(
                                        "Invoices",
                                        style: TextStyles.textStyle,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(
                          child: Image.asset(
                              "assets/images/loaderxuriti-unscreen.gif",
                              height: 70
                              // "assets/images/Spinner-3-unscreen.gif",
                              //color: Colors.orange,
                              ));
                    }
                  } else {
                    return Scaffold(
                      key: sk,
                      endDrawer: DrawerWidget(
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                      ),
                      backgroundColor: Colours.black,
                      appBar: AppBar(
                        backgroundColor: Colours.black,
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Image.asset("assets/images/xuriti1.png"),
                        ),
                        title: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 10,
                                  ),
                                  child: Container(
                                    width: maxWidth * 0.57,

                                    // height: maxHeight * 0.10,
                                    child: Text(
                                      getNewLineString(),
                                   
                                      style: TextStyles.textStyle,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    // left: 18,
                                    top: 10,
                                  ),
                                  child: CompanyDetails.companyStatusToIcon(
                                      compStatus),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          InkWell(
                            onTap: () {
                              sk.currentState!.openEndDrawer();
                            },
                            child: Padding(
                                padding: const EdgeInsets.all(18),
                                child: SvgPicture.asset(
                                    "assets/images/menubutton.svg")),
                          ),
                        ],
                      ),
                      body: SafeArea(child: screens[currentIndex]),
                      bottomNavigationBar: Container(
                        color: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  context.showLoader();

                                  await Future.delayed(
                                      const Duration(seconds: 1));

                                  setState(() {
                                    currentIndex = 0;
                                  });
                                  context.hideLoader();
                                },
                                child: Container(
                                  height: h10p * 0.5,
                                  width: w10p * 4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: currentIndex == 0
                                          ? Colours.tangerine
                                          : Colours.black),
                                  child: const Center(
                                    child: Text(
                                      "Home",
                                      style: TextStyles.textStyle,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  context.showLoader();

                                  await Future.delayed(
                                      const Duration(seconds: 1));
                                  setState(() {
                                    currentIndex = 1;
                                  });

                                  context.hideLoader();
                                },
                                child: Container(
                                  height: h10p * 0.5,
                                  width: w10p * 4.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: currentIndex == 1
                                          ? Colours.tangerine
                                          : Colours.black),
                                  child: const Center(
                                    child: Text(
                                      "Invoices",
                                      style: TextStyles.textStyle,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
          )),
        );
      }),
    );
  }
}
