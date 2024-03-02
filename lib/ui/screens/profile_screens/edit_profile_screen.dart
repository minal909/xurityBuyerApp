import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/password_manager.dart';
import 'package:xuriti/logic/view_models/profile_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/widgets/profile/profile_widget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';
import '../../../logic/view_models/auth_manager.dart';
import '../../../models/core/get_company_list_model.dart';
import '../../../models/helper/service_locator.dart';
import '../../theme/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<ScaffoldState> ssk = GlobalKey();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    getIt<PasswordManager>().reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GetCompany company = GetCompany();
    UserDetails? userInfo = Provider.of<AuthManager>(context).uInfo;
    int? indexOfCompany = getIt<SharedPreferences>().getInt('companyIndex');
    String? transDate = userInfo!.user!.createdAt;
    DateTime id = DateTime.parse(transDate!);
    String convertedDate = DateFormat("yyyy-MM-dd").format(id);
    String emailMessage = Provider.of<PasswordManager>(context).emailMsg;
    String mobileMessage = Provider.of<PasswordManager>(context).mobileMsg;
    String nameMessage = Provider.of<PasswordManager>(context).nameMsg;
    String userNameMsg = Provider.of<PasswordManager>(context).userNameMsg;
    String secondNameMessage =
        Provider.of<PasswordManager>(context).secondNameMsg;

    if (indexOfCompany != null) {
      company =
          Provider.of<TransactionManager>(context).companyList[indexOfCompany];
    }

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;

      return Scaffold(
          key: ssk,
          backgroundColor: Colours.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * 1.7,
            flexibleSpace: ProfileWidget(pskey: ssk),
          ),
          body: ProgressHUD(child: Builder(builder: (context) {
            final progress = ProgressHUD.of(context);
            return Column(children: [
              SizedBox(
                height: h10p * .3,
              ),
              Expanded(
                  child: Container(
                      width: maxWidth,
                      decoration: const BoxDecoration(
                          color: Colours.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(26),
                            topRight: Radius.circular(26),
                          )),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: h1p * 2.5, right: h1p * 2.5, top: 18),
                        child: ListView(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(context, profile);
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/images/arrowLeft.svg"),
                                SizedBox(
                                  width: w10p * .3,
                                ),
                                const Text(
                                  "Back",
                                  style: TextStyles.textStyle41,
                                ),
                              ],
                            ),
                          ),
                          // CircleAvatar(
                          //   radius: 70,
                          //   child: Image.asset("assets/images/editProfile.png",
                          //       fit: BoxFit.cover),
                          // ),
                          SizedBox(
                            height: h1p * 2,
                          ),
                          const Text(
                            "View Details",
                            style: TextStyles.textStyle87,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: h1p * 4,
                          ),
                          Row(
                            children: [
                              //  SizedBox(width:w10p*.5 ,),
                              const Text(
                                "First Name",
                                style: TextStyles.textStyle38,
                              ),
                              SizedBox(width: w10p * 2.8),
                              const Text(
                                "Last Name",
                                style: TextStyles.textStyle38,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: TextField(
                                      enabled: false,
                                      onChanged: (_) {
                                        getIt<PasswordManager>()
                                            .validateFirstName(
                                                firstNameController.text);
                                      },
                                      controller: firstNameController,
                                      style: TextStyles.textStyle4,
                                      decoration: InputDecoration(
                                          focusedBorder: outlineInputBorder,
                                          enabledBorder: outlineInputBorder,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 24),
                                          fillColor: Colours.paleGrey,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          hintText: (userInfo.user == null ||
                                                  userInfo.user!.firstName ==
                                                      null)
                                              ? "firstName"
                                              : userInfo.user!.firstName ?? '',
                                          hintStyle: TextStyles.textStyle70)),
                                )),
                                const SizedBox(
                                  width: 18,
                                ),
                                Expanded(
                                    child: SizedBox(
                                  height: 45,
                                  child: TextField(
                                      enabled: false,
                                      onChanged: (_) {
                                        getIt<PasswordManager>()
                                            .validateSecondName(
                                                lastNameController.text);
                                      },
                                      controller: lastNameController,
                                      style: TextStyles.textStyle4,
                                      decoration: InputDecoration(
                                          focusedBorder: outlineInputBorder,
                                          enabledBorder: outlineInputBorder,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 24),
                                          fillColor: Colours.paleGrey,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          hintText: (userInfo.user == null ||
                                                  userInfo.user!.lastName ==
                                                      null)
                                              ? "lastName"
                                              : userInfo.user!.lastName ?? '',
                                          hintStyle: TextStyles.textStyle70)),
                                )),
                              ],
                            ),
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
                          ),
                          Text("Username", style: TextStyles.textStyle38),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 45,
                              child: TextField(
                                  enabled: false,
                                  onChanged: (_) {
                                    getIt<PasswordManager>().validateUserName(
                                        userNameController.text);
                                  },
                                  controller: userNameController,
                                  style: TextStyles.textStyle4,
                                  decoration: InputDecoration(
                                      focusedBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 24),
                                      fillColor: Colours.paleGrey,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: (userInfo.user == null)
                                          ? "userName"
                                          : userInfo.user!.name ?? '',
                                      hintStyle: TextStyles.textStyle70)),
                            ),
                          ),
                          userNameMsg == ""
                              ? Container()
                              : Row(
                                  children: [
                                    Text(userNameMsg,
                                        style:
                                            const TextStyle(color: Colors.red)),
                                  ],
                                ),
                          const Text("Email Id", style: TextStyles.textStyle38),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 45,
                              child: TextField(
                                  enabled: false,
                                  onSubmitted: (_) {
                                    getIt<PasswordManager>()
                                        .validateEmail(emailController.text);
                                  },
                                  controller: emailController,
                                  style: TextStyles.textStyle4,
                                  decoration: InputDecoration(
                                      focusedBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 24),
                                      fillColor: Colours.paleGrey,
                                      filled: true,
                                      hintText: (userInfo.user == null)
                                          ? "email id"
                                          : userInfo.user!.email ?? '',
                                      hintStyle: TextStyles.textStyle70)),
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
                          const Text("Mobile Number",
                              style: TextStyles.textStyle38),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 45,
                              child: TextField(
                                  enabled: false,
                                  onSubmitted: (val) {
                                    getIt<PasswordManager>()
                                        .validateMobile(val);
                                  },
                                  controller: numberController,
                                  style: TextStyles.textStyle4,
                                  decoration: InputDecoration(
                                      focusedBorder: outlineInputBorder,
                                      enabledBorder: outlineInputBorder,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 24),
                                      fillColor: Colours.paleGrey,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: (userInfo.user == null)
                                          ? "mobile no"
                                          : userInfo.user!.mobileNumber
                                              .toString(),
                                      hintStyle: TextStyles.textStyle70)),
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
                          Card(
                            elevation: 2,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: w1p * 5, vertical: h1p * 3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          'Company Name :',
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          (indexOfCompany == null ||
                                                  company.companyDetails ==
                                                      null)
                                              ? " "
                                              : company.companyDetails!
                                                      .companyName ??
                                                  "",
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          'Address :',
                                          style: TextStyles.textStyle54,
                                        ),
                                        Expanded(
                                          child: AutoSizeText(
                                            (indexOfCompany == null ||
                                                    company.companyDetails ==
                                                        null)
                                                ? " "
                                                : company.companyDetails!
                                                        .address ??
                                                    '',
                                            style: TextStyles.textStyle55,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          'PAN No :',
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          (indexOfCompany == null ||
                                                  company.companyDetails ==
                                                      null)
                                              ? " "
                                              : company.companyDetails!.pan ??
                                                  '',
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          'District :',
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          (indexOfCompany == null ||
                                                  company.companyDetails ==
                                                      null)
                                              ? " "
                                              : company.companyDetails!
                                                      .district ??
                                                  "",
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          'State :',
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          (indexOfCompany == null ||
                                                  company.companyDetails ==
                                                      null)
                                              ? " "
                                              : company.companyDetails!.state ??
                                                  '',
                                          style: TextStyles.textStyle55,
                                        ),
                                        SizedBox(
                                          width: w10p * 1.7,
                                        ),
                                        const AutoSizeText(
                                          'PINCODE :',
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          (indexOfCompany == null ||
                                                  company.companyDetails ==
                                                      null)
                                              ? " "
                                              : company.companyDetails!.pincode
                                                  .toString(),
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: h1p * .5,
                                    ),
                                    Row(
                                      children: [
                                        AutoSizeText(
                                          'Type of Business :',
                                          style: TextStyles.textStyle54,
                                        ),
                                        AutoSizeText(
                                          (indexOfCompany == null ||
                                                  company.companyDetails ==
                                                      null)
                                              ? " "
                                              : company
                                                      .companyDetails!.status ??
                                                  '',
                                          style: TextStyles.textStyle55,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          // const Padding(
                          //   padding: EdgeInsets.symmetric(vertical: 30),
                          //   child: Text(
                          //     "Change Password",
                          //     style: TextStyles.textStyle88,
                          //     textAlign: TextAlign.center,
                          //   ),
                          // ),
                          // const Text("Current Password",
                          //     style: TextStyles.textStyle38),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                          //   child: SizedBox(
                          //     height: 45,
                          //     child: TextField(
                          //         //controller: fNameController,
                          //         style: TextStyles.textStyle4,
                          //         decoration: InputDecoration(
                          //             focusedBorder: outlineInputBorder,
                          //             enabledBorder: outlineInputBorder,
                          //             contentPadding: const EdgeInsets.symmetric(
                          //                 vertical: 10, horizontal: 24),
                          //             fillColor: Colours.paleGrey,
                          //             filled: true,
                          //             border: OutlineInputBorder(
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             hintText: "Enter Text",
                          //             hintStyle: TextStyles.textStyle70)),
                          //   ),
                          // ),
                          // const Text("New Password",
                          //     style: TextStyles.textStyle38),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                          //   child: SizedBox(
                          //     height: 45,
                          //     child: TextField(
                          //         style: TextStyles.textStyle4,
                          //         decoration: InputDecoration(
                          //             focusedBorder: outlineInputBorder,
                          //             enabledBorder: outlineInputBorder,
                          //             contentPadding: const EdgeInsets.symmetric(
                          //                 vertical: 10, horizontal: 24),
                          //             fillColor: Colours.paleGrey,
                          //             filled: true,
                          //             border: OutlineInputBorder(
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             hintText: "Enter Text",
                          //             hintStyle: TextStyles.textStyle70)),
                          //   ),
                          // ),
                          // const Text("Confirm New Password",
                          //     style: TextStyles.textStyle38),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                          //   child: SizedBox(
                          //     height: 45,
                          //     child: TextField(
                          //       controller: passwordController,
                          //         style: TextStyles.textStyle4,
                          //         decoration: InputDecoration(
                          //             focusedBorder: outlineInputBorder,
                          //             enabledBorder: outlineInputBorder,
                          //             contentPadding: const EdgeInsets.symmetric(
                          //                 vertical: 10, horizontal: 24),
                          //             fillColor: Colours.paleGrey,
                          //             filled: true,
                          //             border: OutlineInputBorder(
                          //               borderRadius: BorderRadius.circular(10),
                          //             ),
                          //             hintText: "Enter Text",
                          //             hintStyle: TextStyles.textStyle70)),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       vertical: h1p * 4, horizontal: w1p * 5),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Container(
                          //         height: h10p * .5,
                          //         width: w10p * 4,
                          //         decoration: BoxDecoration(
                          //             color: Colours.failPrimary,
                          //             borderRadius: BorderRadius.circular(5)),
                          //         child: const Center(
                          //             child: Text(
                          //           'Discard Changes',
                          //           style: TextStyles.textStyle46,
                          //         )),
                          //       ),
                          //       SizedBox(
                          //         width: w10p * .3,
                          //       ),
                          //       GestureDetector(
                          //         onTap: () async {
                          //           if (userInfo != null &&
                          //               userInfo.user != null) {
                          //             String? firstName = firstNameController.text.isEmpty?userInfo.user!.firstName:firstNameController.text.trim();
                          //             String? lastName = lastNameController.text.isEmpty?userInfo.user!.lastName:lastNameController.text.trim();
                          //             String? userName = userNameController.text.isEmpty?userInfo.user!.name:userNameController.text.trim();
                          //             String? mobileNo = numberController.text.isEmpty?userInfo.user!.mobileNumber:numberController.text.trim();
                          //             String? email = emailController.text.isEmpty?userInfo.user!.email:emailController.text.trim();
                          //             String? password =getIt<SharedPreferences>().getString("password");
                          //
                          //             if (firstName != null &&
                          //                 lastName != null &&
                          //                 userName != null &&
                          //                 userInfo.user!.gid != null &&
                          //                 userInfo.user!.userRole != null ) {
                          //               progress!.show();
                          //            Map<String, dynamic> data =await   getIt<ProfileManager>().updateProfile(name: userName, gid: userInfo.user!.gid, password: passwordController.text.trim(), fName: firstName, lName: lastName, userRole: userInfo.user!.userRole, mobileNo:mobileNo, email: email,);
                          //               data['status'] == true? await getIt<AuthManager>().signInwithEmailandPassword(email: email ?? "", password: passwordController.text.trim())
                          //                   : Fluttertoast.showToast(msg: data['message']);
                          //               progress.dismiss();
                          //               Fluttertoast.showToast(msg: data['message']);
                          //
                          //               Navigator.pushReplacementNamed(context, profile);
                          //
                          //             }
                          //             else {
                          //               ScaffoldMessenger.of(context)
                          //                   .showSnackBar(SnackBar(
                          //                   behavior: SnackBarBehavior.floating,
                          //                   content: Text(
                          //                     "Please add all the fields",
                          //                     style:
                          //                     TextStyle(color: Colors.red),
                          //                   )));
                          //             }
                          //           } else {
                          //             ScaffoldMessenger.of(context)
                          //                 .showSnackBar(SnackBar(
                          //                 behavior: SnackBarBehavior.floating,
                          //                 content: Text(
                          //                   "Please try again later",
                          //                   style:
                          //                   TextStyle(color: Colors.red),
                          //                 )));
                          //           }
                          //         },
                          //         child: Container(
                          //           height: h10p * .5,
                          //           width: w10p * 2.4,
                          //           decoration: BoxDecoration(
                          //               color: Colours.successPrimary,
                          //               borderRadius: BorderRadius.circular(5)),
                          //           child: const Center(
                          //               child: Text(
                          //             'Update',
                          //             style: TextStyles.textStyle46,
                          //           )),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // )
                        ]),
                      ))),
            ]);
          })));
    });
  }
}

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox();
  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          //    width: 350,
          height: 110,
          decoration: const BoxDecoration(
              color: Colours.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              )),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 33),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/tickMark.svg"),
                    const SizedBox(
                      width: 19,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Your changes have been',
                          style: TextStyles.textStyle70,
                        ),
                        Text(
                          'saved',
                          style: TextStyles.textStyle70,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  color: Colours.charcoalGrey,
                  child: const Center(
                    child: Text(
                      "Close",
                      style: TextStyles.textStyle2,
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
}
