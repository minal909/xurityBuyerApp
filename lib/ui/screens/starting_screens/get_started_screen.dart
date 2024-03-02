import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../models/helper/service_locator.dart';
import '../../routes/router.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset("assets/images/xuriti-logo.png"),
                    )
                  ]),
              backgroundColor: Colours.black,
              body: ProgressHUD(
                child: Builder(builder: (context) {
                  final progress = ProgressHUD.of(context);
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w10p * .5, vertical: h1p * 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get Started",
                            style: TextStyles.textStyle15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Row(children: [
                              Expanded(
                                flex: 3,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, signUp);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: const Center(
                                        child: Text("Create an Account",
                                            style: TextStyles.textStyle5)),
                                    decoration: BoxDecoration(
                                        color: Colours.primary,
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Expanded(
                                flex: 2,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, login);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: const Center(
                                        child: Text("Sign In",
                                            style: TextStyles.textStyle5)),
                                    decoration: BoxDecoration(
                                        color: Colours.primary,
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          if(Platform.isAndroid)
                          InkWell(
                            onTap: () async {
                              //     ScaffoldMessenger.of(context)
                              //         .showSnackBar(
                              //          SnackBar(
                              //           duration: Duration(seconds: 2),
                              //             behavior:
                              //             SnackBarBehavior
                              //                 .floating,
                              //             content: Text(
                              //               'sign up with google',
                              //               style: TextStyle(
                              //                   color: Colours
                              //                       .primary),
                              //             )));
                              //     AuthManager authManager =  getIt<AuthManager>();
                              //       String? message =   await  authManager.googleLogin();
                              // if(message == "User not found"){
                              //   Navigator.pushNamed(context, signUp);
                              // }else if(message == "User found") {
                              //   Navigator.pushNamed(context, landing);
                              // }
                              // else if(message == "company not registered"){
                              //   Navigator.pushNamed(context, businessRegister);
                              //
                              // }
                              // else if(message == "Your account is inactive"){
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(const SnackBar(
                              //       behavior: SnackBarBehavior.floating,
                              //       content: Text(
                              //         'Your account is inactive',
                              //         style: TextStyle(
                              //             color: Colours.primary),
                              //       )));
                              // }

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      content: Text(
                                        'sign up with google',
                                        style:
                                            TextStyle(color: Colours.primary),
                                      )));
                              AuthManager authManager = getIt<AuthManager>();
                              context.showLoader();
                              // progress!.show();
                              Map<String, dynamic>? message = await authManager
                                  .googleLogin(isSignIn: false);
                              // progress.dismiss();
                              context.hideLoader();
                              if (message != null) {
                                if (message['status'] == false) {
                                  if (message['message'] == "User Not Found") {
                                    Navigator.pushNamed(context, signUp);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              message['message'],
                                              style: TextStyle(
                                                  color: Colours.primary),
                                            )));
                                  }
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            message['message'],
                                            style: TextStyle(
                                                color: Colours.primary),
                                          )));
                                  Navigator.pushNamed(context, oktWrapper);
                                }
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: h1p * 2),
                              child: Container(
                                height: h1p * 7,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/google_icon.png",
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    const Text("Sign up with google",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: "Poppins",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0)),
                                  ],
                                )),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7)),
                              ),
                            ),
                          ),
                          // if (Platform.isIOS) 

                          
                            // InkWell(
                            //   onTap: () async {
                            //     // _signInWithApple(context);
                            //   },
                            //   child: Padding(
                            //     padding:
                            //         EdgeInsets.symmetric(vertical: h1p * 2),
                            //     child: Container(
                            //       height: h1p * 7,
                            //       child: Center(
                            //           child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Icon(
                            //             FontAwesomeIcons.apple,
                            //             size: 20,
                            //           ),
                            //           const SizedBox(
                            //             width: 18,
                            //           ),
                            //           const Text("Sign up with apple",
                            //               style: TextStyle(
                            //                   color: Colors.black,
                            //                   fontWeight: FontWeight.w700,
                            //                   fontFamily: "Poppins",
                            //                   fontStyle: FontStyle.normal,
                            //                   fontSize: 14.0)),
                            //         ],
                            //       )),
                            //       decoration: BoxDecoration(
                            //           color: Colors.white,
                            //           borderRadius: BorderRadius.circular(7)),
                            //     ),
                            //   ),
                            // ),
                      ],
                      ));
                }),
              )));
    });
  }
}
