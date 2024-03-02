import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/logic/view_models/company_details_manager.dart';
import 'package:xuriti/logic/view_models/profile_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/seller_id_model.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/theme/constants.dart';

class SearchGST extends StatefulWidget {
  SearchGST({super.key, this.gstNo, this.userinfo});

  final TextEditingController? gstNo;
  final userinfo;

  @override
  State<SearchGST> createState() => _SearchGSTState();
}

class _SearchGSTState extends State<SearchGST> {
  TextEditingController companyName = TextEditingController();
  String? companyId = getIt<SharedPreferences>().getString("token");
  double sheetSize = .6;
  double maxSize = 1;
  bool showDetails = false;
  bool showButton = false;
  SellerIdModel? sellerIdModel;
  String? selectedId;

  @override
  void dispose() {
    getIt<CompanyDetailsManager>().disposeRegisterCompanyDetails();
    super.dispose();
  }

  Widget build(BuildContext context) {
    // print(sellerIdModel!.sellerListDetails);
    // print(sellerIdModel);

    // UserDetails? userInfo = UserDetails();
    SellerListDetails? selectedValue;
    UserDetails? userInfo = Provider.of<AuthManager>(context).uInfo;
    TextEditingController emailController = TextEditingController(
      text: userInfo!.user!.email,
    );
    TextEditingController mobileController = TextEditingController(
      text: userInfo.user!.mobileNumber,
    );
    TextEditingController panController = TextEditingController(
      text: widget.gstNo!.text.substring(2, 12),
    );
    TextEditingController gstNumber = TextEditingController(
      text: widget.gstNo!.text,
    );

    // RegExp regExp = new RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}");
    // dynamic panNumber = regExp.stringMatch(widget.gstNo as String);

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset("assets/images/xuriti-logo.png"),
                )
              ]),
          body: ProgressHUD(
            child: Builder(
              builder: (context) {
                final progress = ProgressHUD.of(context);
                return Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ListView(
                      // controller: scrollController,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                    "assets/images/arrowLeft.svg"),
                              ),
                              SizedBox(
                                width: w10p * 1.5,
                              ),
                              Text(
                                "Register your company",
                                style: TextStyles.textStyle3,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextFormField(
                                enabled: false,
                                controller: gstNumber,
                                style: TextStyles.textStyle4,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "GST No.",
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextFormField(
                                controller: companyName,
                                style: TextStyles.textStyle4,
                                inputFormatters: [],
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Company name",
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextFormField(
                                enabled: false,
                                controller: panController,
                                style: TextStyles.textStyle4,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "PAN No.",
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextFormField(
                                enabled: false,
                                controller: mobileController,
                                style: TextStyles.textStyle4,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Mobile Number",
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: SizedBox(
                            height: 45,
                            child: TextFormField(
                                enabled: false,
                                controller: emailController,
                                style: TextStyles.textStyle4,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 24),
                                  fillColor: Colours.paleGrey,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: "Email",
                                )),
                          ),
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.symmetric(
                        //         vertical: 8,
                        //       ),
                        //       child: InkWell(
                        //         onTap: () async {
                        //           progress!.show();
                        //           Navigator.push(context, MaterialPageRoute(
                        //             builder: (context) {
                        //               return SearchGST();
                        //             },
                        //           ));

                        //           // gstNumber.text.isNotEmpty
                        //           //     ? await getIt<CompanyDetailsManager>()
                        //           //         .gstSearch(
                        //           //             gstNo: gstNumber.text,
                        //           //             uInfo: userInfo)
                        //           //     // Navigator.push(
                        //           //     //     context,
                        //           //     //     MaterialPageRoute(
                        //           //     //         builder: (context) =>
                        //           //     //             ResponseScreen()));

                        //           //     : Fluttertoast.showToast(
                        //           //         msg: "Please enter GST number",
                        //           //         textColor: Colors.red);
                        //           // progress.dismiss();
                        //           // await getIt<CompanyDetailsManager>()
                        //           //     .gstSearch(
                        //           //         gstNo: gstNumber.text,
                        //           //         uInfo: userInfo);
                        //         },
                        //         child: Container(
                        //           padding: const EdgeInsets.symmetric(
                        //             vertical: 10,
                        //           ),
                        //           width: w10p * 8.7,
                        //           child: Center(
                        //               child: Text("Get Company Details",
                        //                   style: TextStyles.textStyle5)),
                        //           decoration: BoxDecoration(
                        //               color: Colours.primary,
                        //               borderRadius: BorderRadius.circular(7)),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 3,
                        // ),

                        Consumer<CompanyDetailsManager>(
                            builder: (context, params, child) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    // Expanded(
                                    //     child: SizedBox(
                                    //   height: 45,
                                    //   child: TextField(
                                    //       controller: tanController,
                                    //       style: TextStyles.textStyle4,
                                    //       decoration: InputDecoration(
                                    //         contentPadding:
                                    //             const EdgeInsets.symmetric(
                                    //                 vertical: 10,
                                    //                 horizontal: 24),
                                    //         fillColor: Colours.paleGrey,
                                    //         filled: true,
                                    //         border: OutlineInputBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //         ),
                                    //         hintText: "TAN",
                                    //       )),
                                    // )),
                                    // const SizedBox(
                                    //   width: 18,
                                    // ),
                                    // Expanded(
                                    //     child: SizedBox(
                                    //   height: 45,
                                    //   child: TextField(
                                    //       controller: cinController,
                                    //       style: TextStyles.textStyle4,
                                    //       decoration: InputDecoration(
                                    //         contentPadding:
                                    //             const EdgeInsets.symmetric(
                                    //                 vertical: 10,
                                    //                 horizontal: 24),
                                    //         fillColor: Colours.paleGrey,
                                    //         filled: true,
                                    //         border: OutlineInputBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10),
                                    //         ),
                                    //         hintText: "CIN",
                                    //       )),
                                    // )),
                                  ],
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(vertical: 8),
                              //   child: SizedBox(
                              //     height: 45,
                              //     child: TextField(
                              //
                              //         controller: panController,
                              //         style: TextStyles.textStyle4,
                              //         decoration: InputDecoration(
                              //           contentPadding:
                              //           const EdgeInsets.symmetric(
                              //               vertical: 10, horizontal: 24),
                              //           fillColor: Colours.paleGrey,
                              //           filled: true,
                              //           border: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(10),
                              //           ),
                              //           hintText: "PAN",
                              //         )),
                              //   ),
                              // ),

                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(vertical: 12),
                              //   child: SizedBox(
                              //     height: 45,
                              //     child: TextField(
                              //         controller: turnoverController,
                              //         style: TextStyles.textStyle4,
                              //         decoration: InputDecoration(
                              //           contentPadding:
                              //               const EdgeInsets.symmetric(
                              //                   vertical: 10, horizontal: 24),
                              //           fillColor: Colours.paleGrey,
                              //           filled: true,
                              //           border: OutlineInputBorder(
                              //             borderRadius:
                              //                 BorderRadius.circular(10),
                              //           ),
                              //           hintText: "Annual TurnOver",
                              //         )),
                              //   ),
                              // ),
                              FutureBuilder(
                                  future: getIt<CompanyDetailsManager>()
                                      .getSellerDetails(selectedValue),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<SellerListDetails> sellerLists =
                                          snapshot.data
                                              as List<SellerListDetails>;
                                      // selectedValue = sellerLists.first;
                                      return Consumer<CompanyDetailsManager>(
                                        builder: (context, value, child) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            height: 45,
                                            width: 350,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                              ), //border of dropdown button
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              //
                                              color: Colours.paleGrey,
                                            ),
                                            child: CustomDropDown(
                                              selectedValue: selectedValue,
                                              items: sellerLists,
                                              callback: (id) {
                                                selectedId = id;
                                              },
                                            ),
                                          );
                                          //     DropdownButtonHideUnderline(
                                          //         child: DropdownButton<
                                          //             String>(
                                          //   value: selectedValue,
                                          //   // isExpanded: true,
                                          //   iconSize: 36,

                                          //   items: sellerLists.map(
                                          //       (SellerListDetails
                                          //           sellerListDetails) {
                                          //     selectedValue =
                                          //         sellerLists.first.id;
                                          //     return DropdownMenuItem<
                                          //         String>(
                                          //       value:
                                          //           sellerListDetails.id!,
                                          //       child: Text(
                                          //         sellerListDetails
                                          //                 .sellerName ??
                                          //             ' ',
                                          //         style: TextStyles
                                          //             .textStyle122,
                                          //       ),
                                          //     );
                                          //   }).toList(),
                                          //   onChanged: (val) async {
                                          //     Fluttertoast.showToast(
                                          //         msg:
                                          //             "Fetching data please wait");
                                          //     // setState(() {
                                          //     //   _chosenSellerId = sellerId;
                                          //     // });

                                          //     setState(() {
                                          //       selectedValue =
                                          //           val.toString();
                                          //     });

                                          //     progress!.show();
                                          //     dynamic data = await getIt<
                                          //             CompanyDetailsManager>()
                                          //         .getSellerDetails(val);
                                          //     progress.dismiss();
                                          //     if (data != null) {
                                          //       Fluttertoast.showToast(
                                          //           msg: "Data fetched");
                                          //       // }
                                          //     }
                                          //   },
                                          //   hint: Container(
                                          //     width: 150, //and here
                                          //     child: Text(
                                          //       "Please Select Seller",
                                          //       style:
                                          //           TextStyles.textStyle128,
                                          //       textAlign: TextAlign.end,
                                          //     ),
                                          //   ),
                                          // )));
                                        },
                                      );
                                      // buttonDecoration: BoxDecoration(
                                      //   color: Colours.paleGrey,
                                      //   border: Border.all(
                                      //       color: Colours.black
                                      //           .withOpacity(0.6)),
                                      //   borderRadius:
                                      //       BorderRadius.circular(10),
                                      // ),
                                      // dropdownWidth: 350.0,
                                      // hint: "Select Associate Seller",
                                      // dropdownItems: sellerLists.map(
                                      //     (SellerListDetails seller) {

                                      // }),
                                    }
                                    return Container();
                                  }),
                              // Container(
                              //   width: 300.0,
                              //   child: DropdownButtonHideUnderline(
                              //     child: DropdownButton(
                              //       hint: Text(
                              //         "Please Select Seller",
                              //         style: TextStyles.textStyle128,
                              //         textAlign: TextAlign.end,
                              //       ),
                              //       isExpanded: true,
                              //       items: [],

                              //       // items: sellerIdModel?.sellerListDetails!
                              //       //     .map((item) {
                              //       //   return DropdownMenuItem(
                              //       //     child: Text(item.sellerName),
                              //       //     value: item.id.toString(),
                              //       //   );
                              //       // }).toList(),
                              //       onChanged: null,
                              //       style:
                              //           Theme.of(context).textTheme.bodyLarge,
                              //     ),
                              //   ),
                              // ),
                              checkbox_widget(params: params, h1p: h1p),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    widget.gstNo != null || widget.gstNo == ''
                                        ? InkWell(
                                            onTap: () async {
                                              // if (tanController.text != "" &&
                                              //     cinController.text != "" &&
                                              //     panController.text != "" &&
                                              //     turnoverController.text != "") {
                                              if (params.isChecked == true) {
                                                progress!.show();
                                                Map<String,
                                                    dynamic> result = await getIt<
                                                        CompanyDetailsManager>()
                                                    .manualAddEntity(
                                                  gstNo: gstNumber.text,
                                                  userId: userInfo.user?.sId,
                                                  adminEmail:
                                                      emailController.text,
                                                  adminMobile:
                                                      mobileController.text,

                                                  companyName: companyName.text,
                                                  selectedId: selectedId,

                                                  // pan:
                                                  //     panController.text.isEmpty
                                                  //         ? panNo
                                                  //         : panController.text,
                                                  pan: panController.text,
                                                );
                                                progress.dismiss();
                                                if (result['status'] == true) {
                                                  Fluttertoast.showToast(
                                                      msg: result['message']
                                                          .toString(),
                                                      textColor: Colors.green);

                                                  Navigator.pushNamed(
                                                      context, oktWrapper);
                                                } else {
                                                  if (result['errors'] ==
                                                      null) {
                                                    Fluttertoast.showToast(
                                                        msg: result['message']
                                                            .toString(),
                                                        textColor: Colors.red);
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: result['errors']
                                                                ['message']
                                                            .toString(),
                                                        textColor: Colors.red);
                                                  }
                                                }
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        content: Text(
                                                          "Please accept terms and conditions",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        )));
                                              }
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              width: w10p * 8.7,
                                              child: const Center(
                                                  child: Text("CREATE",
                                                      style: TextStyles
                                                          .textStyle5)),
                                              decoration: BoxDecoration(
                                                  color: Colours.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(7)),
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                            ),
                                            width: w10p * 8.7,
                                            child: const Center(
                                                child: Text("CREATE",
                                                    style:
                                                        TextStyles.textStyle5)),
                                            decoration: BoxDecoration(
                                                color: Colours.warmGrey,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                );
              },
            ),
          ));
    });
  }
}

class checkbox_widget extends StatefulWidget {
  const checkbox_widget({Key? key, required this.h1p, required this.params})
      : super(key: key);

  final double h1p;
  final params;

  @override
  State<checkbox_widget> createState() => _checkbox_widgetState();
}

class _checkbox_widgetState extends State<checkbox_widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.h1p * .1),
      child: CheckboxListTile(
        title: GestureDetector(
            onTap: (() async {
              Map<String, dynamic> data =
                  await getIt<ProfileManager>().getTermsAndConditions();
              if (data['status'] == true) {
                _launchInBrowser(Uri.parse(
                    "https://docs.google.com/gview?embedded=true&url=${data['url']}"));
                Fluttertoast.showToast(msg: "Opening file");
              }
              Fluttertoast.showToast(msg: "Technical error occurred");
              await getIt<TransactionManager>().openFile(
                  url:
                      "https://s3.ap-south-1.amazonaws.com/xuriti.public.document/xuritiTermsofService.pdf");

              Fluttertoast.showToast(msg: "Opening file");
            }),
            child: Text(
              "Accept terms and conditions",
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            )),
        value: widget.params.isChecked,
        onChanged: (_) {
          setState(() {});
          widget.params.isChecked = !widget.params.isChecked;
        },
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}

class CustomDropDown extends StatefulWidget {
  CustomDropDown({
    super.key,
    this.selectedValue,
    required this.items,
    required this.callback,
  });

  SellerListDetails? selectedValue;
  List<SellerListDetails> items = [];
  Function(String value) callback;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
        child: DropdownButton<SellerListDetails>(
      isExpanded: true,
      value: widget.selectedValue,
      items: widget.items.map((SellerListDetails sellerListDetails) {
        return DropdownMenuItem<SellerListDetails>(
          value: sellerListDetails,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              sellerListDetails.sellerName ?? ' ',
              style: TextStyles.textStyle122,
            ),
          ),
        );
      }).toList(),
      onChanged: (val) async {
        Fluttertoast.showToast(msg: "Fetching data please wait");
        // setState(() {
        //   _chosenSellerId = sellerId;
        // });
        setState(() {
          widget.selectedValue = val;
          widget.callback(val!.id ?? '');
        });

        // progress!.show();
        // dynamic data =
        //     await getIt<CompanyDetailsManager>().getSellerDetails(val);
        // progress.dismiss();
        // if (data != null) {
        //   Fluttertoast.showToast(msg: "Data fetched");
        //   // }
        // }
      },
      hint: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Please Select Seller",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0)),
        ),
      ),
    ));
  }
}
