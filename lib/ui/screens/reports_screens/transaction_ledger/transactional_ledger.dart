import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xuriti/models/core/transactional_model.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/theme/constants.dart';
import 'package:xuriti/util/loaderWidget.dart';
import 'package:xuriti/util/loaderWidget.dart';

class TransactionalLedger extends StatefulWidget {
  List<dynamic> txn;
  String? account;
  String? accountType;
  String? invoiceID;
  String? createdAt;
  String? balance;
  String? recordType;
  String? counterParty;
  String? transactionType;
  String? transactionAmount;

  TransactionalLedger(
      {required this.account,
      required this.accountType,
      required this.balance,
      required this.counterParty,
      required this.createdAt,
      required this.txn,
      required this.invoiceID,
      required this.recordType,
      required this.transactionType,
      required this.transactionAmount});

  @override
  State<TransactionalLedger> createState() => _TransactionalLedgerState();
}

class _TransactionalLedgerState extends State<TransactionalLedger> {
  String? id = getIt<SharedPreferences>().getString('companyId');
  String balAmt = '';
  List<dynamic> txn = [];

  TransactionModel? transactionModel;
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';
  dynamic typeConv(record) {
    print(record);
    switch (record) {
      case "BPAYMENT":
        {
          record = Text(
            "Buyer Payment",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }

        break;
      case "GST Amount":
        {
          record = Text(
            "GST Amount",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }

        break;
      case "DISCOUNT":
        {
          record = Text(
            "Discount",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "CREDIT NOTE":
        {
          record = Text(
            "Credit Note",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "INTEREST":
        {
          record = Text(
            "Interest",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "SALESINVOICE":
        {
          record = Text(
            "Sales Invoice",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "INTEREST PAID":
        {
          record = Text(
            "Interest Paid",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;

      case "Interest Applied":
        {
          record = Text(
            "Interest Applied",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "Interest Paid":
        {
          record = Text(
            "Interest Paid",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;
      case "INTEREST APPLIED":
        {
          record = Text(
            "Interest Applied",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          );
        }
        break;

      default:
    }
    return record as dynamic;
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(widget.createdAt ?? '');

    String trancDate = DateFormat("dd-MMM-yyyy").format(date);
    String transacAmount = double.parse(widget.transactionAmount as String)
        .toStringAsFixed(2)
        .toString()
        .replaceAllMapped(reg, mathFunc);
    String balanceLeft = double.parse(widget.balance as String)
        .toStringAsFixed(2)
        .toString()
        .replaceAllMapped(reg, mathFunc);
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(
        backgroundColor: Colours.black,
        body: ProgressHUD(
          child: Builder(
            builder: (context) {
              final progress = ProgressHUD.of(context);

              return Column(children: [
                Container(
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 19,
                        right: 7,
                        top: 70,
                      ),

                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      child: Container(
                        height: h10p * 2.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.arrow_back,
                            //       color: Colors.white,
                            //     )
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: w10p * 1.2,
                                  height: h10p * 0.3,
                                  child:
                                      Image.asset("assets/images/xuriti1.png"),
                                ),

                                // const Text(
                                //   "Level 2",
                                //   style: TextStyle(color: Colours.white),
                                // )
                                GestureDetector(
                                    onTap: () {
                                      context.showLoader();
                                      // progress!.show();
                                      context.showLoader();
                                      // progress!.show();
                                      Navigator.pushNamed(
                                          context, homeCompanyList);
                                      // progress.dismiss();
                                      context.hideLoader();
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 1, color: Colors.white)
                                          //more than 50% of width makes circle
                                          ),
                                      child: Icon(
                                        Icons.business_center,
                                        color: Colours.tangerine,
                                      ),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Transaction Statement',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 228, 131, 20),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 15,
                                right: 15,
                                top: 45,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.invoiceID.toString(),
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        widget.account.toString(),
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                  // Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       'Invoice Date',
                                  //       style: TextStyle(
                                  //         color: Color.fromARGB(
                                  //             255, 250, 250, 250),
                                  //         fontSize: 16,
                                  //       ),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 7,
                                  //     ),
                                  //     Text(
                                  //       ' $invDate',
                                  //       style: TextStyle(
                                  //         color: Color.fromARGB(
                                  //             255, 248, 248, 248),
                                  //         fontSize: 12,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                    child: Container(
                        width: maxWidth,
                        // height: maxHeight,
                        // height: h10p * 3,
                        decoration: const BoxDecoration(
                            color: Colours.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26),
                              topRight: Radius.circular(26),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 18, top: 8),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: SvgPicture.asset(
                                        "assets/images/arrowLeft.svg"),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 6,
                                    right: 10,
                                    top: 3,
                                  ),
                                  child: ListView(children: [
                                    Card(
                                        shadowColor:
                                            Color.fromARGB(255, 245, 175, 45),
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 14,
                                            top: 12,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Transaction Type",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  typeConv(widget.recordType),
                                                  // Text(
                                                  //   widget.recordType
                                                  //       .toString(),
                                                  //   style: TextStyle(
                                                  //       fontSize: 15,
                                                  //       fontWeight:
                                                  //           FontWeight.bold),
                                                  // ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Transaction Amount",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    "₹ $transacAmount",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Transaction Date",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    trancDate,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Balance",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    "₹ $balanceLeft",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 6),
                                                ],
                                              ),
                                              SizedBox(
                                                width: w10p * 2.9,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Debit/Credit",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    widget.transactionType
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Counter Party",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100.0,
                                                    child: AutoSizeText(
                                                      // maxLines: 1,
                                                      "${widget.counterParty.toString()}",
                                                      
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  // SizedBox(height: 40),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Text(
                                                    "",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        )))
              ]);
            },
          ),
        ),

        // child: screens[currentIndex],
      );
    });
  }
}
