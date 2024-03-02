import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../logic/view_models/auth_manager.dart';
import '../../../logic/view_models/password_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController numberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController sNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cpassController = TextEditingController();
  bool isVisible = false;
  bool isVisibleC = false;

  @override
  void dispose() {
    getIt<AuthManager>().reset();
    getIt<PasswordManager>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String msg = Provider.of<AuthManager>(context).message;
    bool isVerified = Provider.of<AuthManager>(context).isVerified;
    int getOtp = Provider.of<AuthManager>(context).getOtp;
    bool userCreated = Provider.of<AuthManager>(context).userCreated;
    String passwordMessage2 = Provider.of<PasswordManager>(context).passMsg2;
    String passwordMessage = Provider.of<PasswordManager>(context).passMsg;
    String emailMessage = Provider.of<PasswordManager>(context).emailMsg;
    String mobileMessage = Provider.of<PasswordManager>(context).mobileMsg;
    String nameMessage = Provider.of<PasswordManager>(context).nameMsg;
    String secondNameMessage =
        Provider.of<PasswordManager>(context).secondNameMsg;
    String? firstName = Provider.of<AuthManager>(context).firstName;
    String? lastName = Provider.of<AuthManager>(context).lastName;
    String? email = Provider.of<AuthManager>(context).email;
    String? gid = Provider.of<AuthManager>(context).gid;

    if (gid != null) {
      fNameController.text = firstName ?? '';
      sNameController.text = lastName ?? '';
      eMailController.text = email ?? '';
    }
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
          resizeToAvoidBottomInset: true,
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
          body: ProgressHUD(child: Builder(builder: (context) {
            final progress = ProgressHUD.of(context);
            return ListView(children: [
              Container(
                  width: maxWidth,
                  height: maxHeight,
                  decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      )),
                  child: ListView(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(children: [
                        const Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            "Sign Up",
                            style: TextStyles.textStyle3,
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: TextField(
                                      onChanged: (_) {
                                        getIt<PasswordManager>()
                                            .validateFirstName(
                                                fNameController.text);
                                      },
                                      controller: fNameController,
                                      style: TextStyles.textStyle4,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 24),
                                        fillColor: Colours.paleGrey,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "First Name",
                                      )),
                                )),
                                const SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: TextField(
                                      onChanged: (_) {
                                        getIt<PasswordManager>()
                                            .validateSecondName(
                                                sNameController.text);
                                      },
                                      controller: sNameController,
                                      style: TextStyles.textStyle4,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 24),
                                        fillColor: Colours.paleGrey,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: "Last Name",
                                      )),
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                nameMessage == ""
                                    ? Container()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(nameMessage,
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                        ],
                                      ),
                                secondNameMessage == ""
                                    ? Container()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(secondNameMessage,
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                        ],
                                      ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextField(
                            // onSubmitted
                            onChanged: (_) {
                              getIt<PasswordManager>()
                                  .validateEmail(eMailController.text);
                            },
                            controller: eMailController,
                            style: TextStyles.textStyle4,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              hintText: "Email id",
                            ),
                          ),
                        ),
                        emailMessage == ""
                            ? Container()
                            : Row(
                                children: [
                                  Text(emailMessage,
                                      style:
                                          const TextStyle(color: Colors.red)),
                                ],
                              ),
                        const SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            //  onFieldSubmitted
                            onChanged: (val) {
                              getIt<PasswordManager>()
                                  .validatePassword(passController.text);
                            },
                            controller: passController,
                            style: TextStyles.textStyle4,
                            obscureText: isVisible,
                            decoration: InputDecoration(
                              suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isVisible = !isVisible;
                                    });
                                  },
                                  child: isVisible
                                      ? Icon(
                                          Icons.visibility_outlined,
                                          size: 20,
                                          color: Colors.grey,
                                        )
                                      : Icon(
                                          Icons.visibility_off_outlined,
                                          size: 20,
                                          color: Colors.grey,
                                        )),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              hintText: "Password",
                            ),
                          ),
                        ),
                        passwordMessage == ""
                            ? Container()
                            : Row(
                                children: [
                                  Text(passwordMessage,
                                      style:
                                          const TextStyle(color: Colors.red)),
                                ],
                              ),
                        const SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            // onFieldSubmitted
                            onChanged: (val) {
                              getIt<PasswordManager>().passwordConfirmation(
                                  val, passController.text);
                            },
                            controller: cpassController,
                            style: TextStyles.textStyle4,
                            obscureText: isVisibleC,
                            decoration: InputDecoration(
                              suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isVisibleC = !isVisibleC;
                                    });
                                  },
                                  child: isVisibleC
                                      ? Icon(
                                          Icons.visibility_outlined,
                                          size: 20,
                                          color: Colors.grey,
                                        )
                                      : Icon(
                                          Icons.visibility_off_outlined,
                                          size: 20,
                                          color: Colors.grey,
                                        )),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              hintText: "Confirm Password",
                            ),
                          ),
                        ),
                        passwordMessage2 == ""
                            ? Container()
                            : Row(
                                children: [
                                  Text(passwordMessage2,
                                      style:
                                          const TextStyle(color: Colors.red)),
                                ],
                              ),
                        const SizedBox(
                          height: 13,
                        ),
                        SizedBox(
                          height: 45,
                          child: TextFormField(
                            //onFieldSubmitted
                            onChanged: (_) {
                              getIt<PasswordManager>()
                                  .validateMobile(numberController.text);
                            },
                            controller: numberController,
                            style: TextStyles.textStyle4,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 24),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              fillColor: Colours.paleGrey,
                              filled: true,
                              hintText: "Mobile Number",
                              suffix: InkWell(
                                  onTap: () async {
                                    context.showLoader();
                                    //progress!.show();
                                    Map<String, dynamic> otpsend =
                                        await getIt<AuthManager>().otpInitiate(
                                            phoneNumber: numberController.text);
                                    //progress.dismiss();
                                    context.hideLoader();
                                    if (otpsend['status'] == true) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              content: Text(
                                                'OTP sending please wait....',
                                                style: TextStyle(
                                                    color: Colours.primary),
                                              )));
                                    }

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              otpsend['message'],
                                              style: TextStyle(
                                                  color: Colours.primary),
                                            )));
                                  },
                                  child: Text(
                                    getOtp == 1
                                        ? "Resend OTP"
                                        : getOtp == 0
                                            ? "Get OTP"
                                            : "",
                                    style: TextStyles.textStyle36,
                                  )),
                            ),
                          ),
                        ),
                        mobileMessage == ""
                            ? Container()
                            : Row(
                                children: [
                                  Text(mobileMessage,
                                      style:
                                          const TextStyle(color: Colors.red)),
                                ],
                              ),
                        SizedBox(
                          height: h1p * 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: getOtp == 1
                              ? SizedBox(
                                  height: 45,
                                  child: TextField(
                                      controller: otpController,
                                      style: TextStyles.textStyle4,
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 24),
                                          fillColor: Colours.paleGrey,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          hintText: "Enter OTP",
                                          suffix: InkWell(
                                              onTap: () async {
                                                context.showLoader();
                                                //progress!.show();
                                                Map<String, dynamic> verified =
                                                    await getIt<AuthManager>()
                                                        .otpVerification(
                                                            otp: otpController
                                                                .text);
                                                //progress.dismiss();
                                                context.hideLoader();
                                                if (verified['status'] ==
                                                    true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: Text(
                                                            verified['message'],
                                                            style: TextStyle(
                                                                color: Colours
                                                                    .primary),
                                                          )));
                                                  setState(() {});
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          content: Text(
                                                            verified['message'],
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red),
                                                          )));
                                                }
                                              },
                                              child: Text(
                                                isVerified
                                                    ? "Verified"
                                                    : "Verify",
                                                style: isVerified
                                                    ? TextStyles.verifiedText
                                                    : TextStyles.textStyle36,
                                              )))),
                                )
                              : Container(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        isVerified
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (fNameController.text.isNotEmpty &&
                                          sNameController.text.isNotEmpty &&
                                          passController.text.isNotEmpty &&
                                          cpassController.text.isNotEmpty &&
                                          numberController.text.isNotEmpty) {
                                        if (nameMessage.isEmpty &&
                                            secondNameMessage.isEmpty &&
                                            emailMessage.isEmpty &&
                                            passwordMessage.isEmpty &&
                                            passwordMessage2.isEmpty &&
                                            mobileMessage.isEmpty) {
                                          context.showLoader();
                                          // if (EmailValidator.validate(
                                          //         eMailController.text) ==
                                          //     true) {
                                          // progress!.show();
                                          Map<String, dynamic> created =
                                              await getIt<AuthManager>()
                                                  .registerUser(
                                                      fname:
                                                          fNameController.text,
                                                      lname:
                                                          sNameController.text,
                                                      email:
                                                          eMailController.text,
                                                      password:
                                                          passController.text,
                                                      cpassword:
                                                          cpassController.text,
                                                      number: numberController
                                                          .text);
                                          // progress.dismiss();
                                          context.hideLoader();
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(const SnackBar(
                                          //         behavior:
                                          //             SnackBarBehavior.floating,
                                          //         content: Text(
                                          //           'Creating user',
                                          //           style: TextStyle(
                                          //               color: Colours.primary),
                                          //         )));

                                          if (created['status'] == true) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                      created['message'],
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    )));
                                            Navigator.pushNamed(context, login);
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    content: Text(
                                                      created['message'],
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )));
                                          }
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: nameMessage +
                                                  secondNameMessage +
                                                  emailMessage +
                                                  passwordMessage +
                                                  passwordMessage2 +
                                                  mobileMessage,
                                              textColor: Colors.red);

                                          // if (fNameController.text.isEmpty) {
                                          //   Fluttertoast.showToast(
                                          //       msg: "Please enter first name",
                                          //       textColor: Colors.red);
                                          // }
                                          // if (sNameController.text.isEmpty) {
                                          //   Fluttertoast.showToast(
                                          //       msg: "Please enter last name",
                                          //       textColor: Colors.red);
                                          // }
                                          //
                                          // if (eMailController.text.isEmpty) {
                                          //   Fluttertoast.showToast(
                                          //       msg: "Please enter email",
                                          //       textColor: Colors.red);
                                        }
                                      } else {
                                        getIt<PasswordManager>().allValidation(
                                            firstName: fNameController.text,
                                            secondName: sNameController.text,
                                            email: eMailController.text,
                                            password: passController.text,
                                            number: numberController.text);
                                      }
                                    },
                                    child: Container(
                                      width: w10p * 8.7,
                                      height: h1p * 7,
                                      child: const Center(
                                          child: Text("REGISTER",
                                              style: TextStyles.textStyle5)),
                                      decoration: BoxDecoration(
                                          color: Colours.primary,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: w10p * 8.7,
                                      height: h1p * 7,
                                      child: const Center(
                                          child: Text("REGISTER",
                                              style: TextStyles.textStyle5)),
                                      decoration: BoxDecoration(
                                          color: Colours.gey,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: h1p * 6,
                        ),
                        Text(msg, style: const TextStyle(color: Colors.red)),
                        SizedBox(
                          height: h1p * 4,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already Registered?",
                                style: TextStyles.textStyle6,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, login);
                                },
                                child: const Text(
                                  " Sign In",
                                  style: TextStyles.textStyle8,
                                ),
                              ),
                            ]),
                        SizedBox(
                          height: h1p * 1,
                        ),
                        // const Text(
                        //   "Forgot Password?",
                        //   style: TextStyles.textStyle9,
                        // )
                      ]),
                    )
                  ]))
            ]);
          })));
    });
  }
}
