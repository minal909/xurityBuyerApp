//import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xuriti/logic/view_models/company_details_manager.dart';
import 'package:xuriti/logic/view_models/profile_manager.dart';
import 'package:xuriti/logic/view_models/trans_history_manager.dart';
import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/CompanyInfo_model.dart';
import 'package:xuriti/models/core/seller_id_model.dart';
import 'package:xuriti/models/core/user_details.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/registration_screens/search_gst.dart';
//import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../logic/view_models/auth_manager.dart';
import '../../theme/constants.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({Key? key}) : super(key: key);

  @override
  State<AddCompany> createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  TextEditingController cinController = TextEditingController();
  TextEditingController tanController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController turnoverController = TextEditingController();
  String? companyId = getIt<SharedPreferences>().getString("token");
  double sheetSize = .6;
  double maxSize = 1;
  bool showDetails = false;
  bool showButton = false;
  SellerIdModel? sellerIdModel;
  String? selectedId;
  CompanyInfoV2? companyInfoV2;
  dynamic pan;
  int? statusCode;

  @override
  void dispose() {
    getIt<CompanyDetailsManager>().disposeRegisterCompanyDetails();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserDetails? userInfo = Provider.of<AuthManager>(context).uInfo;
    // print(sellerIdModel!.sellerListDetails);
    // print(sellerIdModel);

    // UserDetails? userInfo = UserDetails();
    SellerListDetails? selectedValue;
    Company? company;
    CompanyInfo? companyInfo;

    TextEditingController gstNumber = TextEditingController();
    List<SellerListDetails>? sellerListDetails;
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                width: w10p * 2.2,
                              ),
                              Text(
                                "Add your business",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  // context.showLoader();
                                  //  progress!.show();
                                  // dynamic responseData =
                                  //     await getIt<CompanyDetailsManager>()
                                  //         .gstSearch2(
                                  //             gstNo: gstNumber.text,
                                  //             uInfo: userInfo);
                                  // final statusCode = responseData['code'];

                                  //
                                  progress!.show();
                                  gstNumber.text.isNotEmpty
                                      ? await getIt<CompanyDetailsManager>()
                                          .gstSearch2(
                                          gstNo: gstNumber.text,
                                          uInfo: userInfo,
                                        )
                                          .then((value) {
                                          if (value != null &&
                                              value.code == 450) {
                                            value.code = statusCode;
                                             Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SearchGST(
                                                gstNo: gstNumber,
                                                userinfo: userInfo,
                                              );
                                            }));
                                            progress.dismiss();
                                          } else if (value?.code == 201) {
                                          } else if (value?.code == 412) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "GST already registered with another user",
                                                textColor: Colors.white);
                                          } else if (value?.code == 403) {
                                            Fluttertoast.showToast(
                                                msg: "Invalid GST Number",
                                                textColor: Colors.white);
                                          }
                                        })
                                      : Fluttertoast.showToast(
                                          msg: "Please enter GST number",
                                          textColor: Colors.white);
                                  // progress.dismiss();
                                  // context.hideLoader();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  width: w10p * 8.7,
                                  child: Center(
                                      child: Text("Get GST Details",
                                          style: TextStyles.textStyle5)),
                                  decoration: BoxDecoration(
                                      color: Colours.primary,
                                      borderRadius: BorderRadius.circular(7)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Consumer<CompanyDetailsManager>(
                            builder: (context, params, child) {
                          return params.status == 1 &&
                                  params.companyinfoV2?.company != null
                              ? Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    height: h10p * 3,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 0.5,
                                              blurRadius: 3)
                                        ]),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 18),
                                    width: maxWidth,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Company Name : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${params.companyinfoV2?.company!.companyName}",
                                                      style: TextStyles
                                                          .textStyle16),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Address : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            //  SizedBox(width: w10p * ,)
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                      "${params.companyinfoV2?.company!.address}",
                                                      //maxLines: 2,
                                                      softWrap: true,
                                                      style: TextStyles
                                                          .textStyle16),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "PAN No : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Text(params.panNo,
                                                style: TextStyles.textStyle16),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "District : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Text(
                                                "${params.companyinfoV2?.company!.district}",
                                                style: TextStyles.textStyle16),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "State : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Text(
                                                "${params.companyinfoV2?.company!.state![0]}",
                                                style: TextStyles.textStyle16),
                                            SizedBox(
                                              width: w10p * .2,
                                            ),
                                            Text(
                                                "(${params.companyinfoV2?.company!.state![1]})",
                                                style: TextStyles.textStyle16),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            const Text(
                                              "Pincode : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Text(
                                                "${params.companyinfoV2?.company!.pinCode}",
                                                style: TextStyles.textStyle16),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : params.status == 2 || params.status == 0
                                  ? Container(
                                      child: Center(
                                        child: Text(params.errorMessage ?? ""),
                                      ),
                                    )
                                  : Container();
                        }),
                        Consumer<CompanyDetailsManager>(
                            builder: (context, params, child) {
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: SizedBox(
                                      height: 45,
                                      child: TextField(
                                          controller: tanController,
                                          style: TextStyles.textStyle4,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 24),
                                            fillColor: Colours.paleGrey,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: "TAN",
                                          )),
                                    )),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      height: 45,
                                      child: TextField(
                                          controller: cinController,
                                          style: TextStyles.textStyle4,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10,
                                                    horizontal: 24),
                                            fillColor: Colours.paleGrey,
                                            filled: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            hintText: "CIN",
                                          )),
                                    )),
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

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                child: SizedBox(
                                  height: 45,
                                  child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: turnoverController,
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
                                        hintText: "Annual TurnOver",
                                      )),
                                ),
                              ),
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
                                        },
                                      );
                                    } else if (!snapshot.hasData) {
                                      return Container();
                                    }
                                    return Container();
                                  }),

                              //       // items: sellerIdModel?.sellerListDetails!
                              //       //     .map((item) {
                              //       //   return DropdownMenuItem(
                              //       //     child: Text(item.sellerName),
                              //       //     value: item.id.toString(),
                              //       //   );

                              BusinessCheckBox(params: params, h1p: h1p),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    gstNumber.text.isNotEmpty
                                        ? InkWell(
                                            onTap: () async {
                                              String gstIn = gstNumber.text;

                                              String panNo = gstIn.substring(
                                                  3, gstIn.length - 4);

                                              // if (tanController.text != "" &&
                                              //     cinController.text != "" &&
                                              //     panController.text != "" &&
                                              //     turnoverController.text != "") {
                                              if (params.isChecked == true) {
                                                progress!.show();
                                                Map<String, dynamic> result = await getIt<
                                                        CompanyDetailsManager>()
                                                    .addEntity(
                                                        gstNo: gstNumber.text,
                                                        // consent: consent,
                                                        userId:
                                                            userInfo?.user?.sId,
                                                        adminEmail: userInfo
                                                            ?.user?.email,
                                                        adminMobile:
                                                            userInfo?.user
                                                                ?.mobileNumber,
                                                        companyName: params
                                                            .companyinfoV2
                                                            ?.company
                                                            ?.companyName,
                                                        tan: tanController.text,
                                                        cin: cinController.text,
                                                        pan: panController
                                                                .text.isEmpty
                                                            ? panNo
                                                            : panController
                                                                .text,
                                                        selectedId: selectedId
                                                            .toString(),
                                                        annualTurnover:
                                                            turnoverController
                                                                .text);
                                                // progress.dismiss();
                                                // context.hideLoader();
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

class BusinessCheckBox extends StatefulWidget {
  const BusinessCheckBox({
    Key? key,
    required this.h1p,
    required this.params,
  }) : super(key: key);

  final double h1p;
  final params;

  @override
  State<BusinessCheckBox> createState() => _BusinessCheckBoxState();
}

class _BusinessCheckBoxState extends State<BusinessCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.h1p * .1),
      child: CheckboxListTile(
        title: GestureDetector(
            onTap: () async {
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
            },
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

class CenterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 1),
          child: Text(
            "Your Shop has been \nsuccessfully registered.",
            style: TextStyles.textStyle15,
          ),
        ),
      ],
    );
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
