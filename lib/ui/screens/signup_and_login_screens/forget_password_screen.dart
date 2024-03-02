import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../logic/view_models/password_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../theme/constants.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    getIt<PasswordManager>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String emailMessage = Provider.of<PasswordManager>(context).emailMsg;

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
          backgroundColor: Colours.black,
          resizeToAvoidBottomInset: true,
          body: ProgressHUD(child: Builder(builder: (context) {
            final progress = ProgressHUD.of(context);
            return ListView(children: [
              SizedBox(
                height: h1p * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 280, right: 20),
                child: Container(
                    height: h1p * 4,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/images/xuriti1.png"),
                      fit: BoxFit.fill,
                    ))),
              ),
              SizedBox(
                height: h1p * 3,
              ),
              Container(
                  width: maxWidth,
                  height: maxHeight,
                  decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      )),
                  child: Column(children: [
                    Center(
                        child: Form(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                          SizedBox(
                            height: h1p * 3,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w10p * .7, vertical: h1p * 3),
                              child: Row(children: [
                                SvgPicture.asset("assets/images/arrowLeft.svg"),
                                SizedBox(
                                  width: w10p * 2,
                                ),
                                Text(
                                  "Forgot Password ?",
                                  style: TextStyles.textStyle3,
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: w10p * .6, bottom: h1p * 2),
                            child: Row(
                              children: [
                                Text("We’ll send a recovery link"),
                              ],
                            ),
                          ),
                          Container(
                            width: w10p * 9,
                            decoration: const BoxDecoration(
                              color: Colours.paleGrey,
                            ),
                            child: TextFormField(
                                onFieldSubmitted: (_) {
                                  getIt<PasswordManager>()
                                      .validateEmail(emailController.text);
                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  fillColor: Colours.paleGrey,
                                  hintText: "Email id ",
                                  hintStyle: TextStyles.textStyle4,
                                )),
                          ),
                          emailMessage == ""
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(left: w10p * .6),
                                  child: Row(
                                    children: [
                                      Text(emailMessage,
                                          style: const TextStyle(
                                              color: Colors.red)),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: h10p * .5,
                          ),
                          InkWell(
                            onTap: () async {
                              context.showLoader();
                              // progress!.show();
                              Map<String, dynamic> forgetPassword =
                                  await getIt<PasswordManager>().forgotPassword(
                                      email: emailController.text);
                              print(forgetPassword);
                              // progress.dismiss();
                              context.hideLoader();
                              if (forgetPassword['status'] == true) {
                                Fluttertoast.showToast(
                                    msg: forgetPassword['message'].toString(),
                                    textColor: Colors.green);
                                Navigator.pop(context);
                              } else {
                                Fluttertoast.showToast(
                                    msg: forgetPassword['message'].toString(),
                                    textColor: Colors.red);
                              }
                            },
                            child: Container(
                              width: w10p * 3,
                              padding: EdgeInsets.symmetric(vertical: h1p * 1),
                              child: const Center(
                                  child: Text("Continue",
                                      style: TextStyles.textStyle5)),
                              decoration: BoxDecoration(
                                  color: Colours.primary,
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                          ),
                        ])))
                  ]))
            ]);
          })));
    });
  }
}
