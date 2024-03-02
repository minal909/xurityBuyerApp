import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:xuriti/logic/view_models/transaction_manager.dart';
import 'package:xuriti/models/core/get_company_list_model.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../models/core/invoice_model.dart';
import '../../theme/constants.dart';
import 'pending_invoices_screen/paid_invoices_screen.dart';

class InvTransactions extends StatefulWidget {
  List invtr;
  String invcDate;
  String invoiceNo;
  String seller;
  // String transAmount;
  // String transDate;
  // String amountCleared;
  // String interest;
  // String discount;
  // String remarks;
  // TransactionInvoice invoice;

  // Invoice currentInvoice;
  InvTransactions({
    required this.invtr,
    required this.invcDate,
    required this.invoiceNo,
    required this.seller,
    // required this.transAmount,
    // required this.transDate,
    // required this.amountCleared,
    // required this.interest,
    // required this.discount,
    // required this.remarks,
    // required this.invoice,

    // required this.currentInvoice,
  });

  @override
  State<InvTransactions> createState() => _InvTransactionsState(
        this.invtr,
        this.invcDate,
        this.invoiceNo,
        this.seller,
        // this.transAmount,
        // this.transDate,
        // this.amountCleared,
        // this.interest,
        // this.discount,
        // this.remarks
      );
}

class _InvTransactionsState extends State<InvTransactions> {
  List invtr = [];
  String invcDate = '';
  String invoiceNo = '';
  String seller = '';
  // String transAmount = '';
  // String transDate = '';
  // String amountCleared = '';
  // String interest = '';
  // String discount = '';
  // String remarks = '';
  String discnt = '';
  String intrst = '';
  String trmt = '';
  String clrAmt = '';

  int currentIndex = 0;
  _InvTransactionsState(
    this.invtr,
    this.invcDate,
    this.invoiceNo,
    this.seller,
    // this.transAmount,
    // this.transDate,
    // this.amountCleared,
    // this.interest,
    // this.discount,
    // this.remarks
  );

  @override
  Widget build(BuildContext context) {
    TransactionInvoice? invoice =
        Provider.of<TransactionManager>(context).selectedInvoice;
    DateTime id2 = DateTime.parse(widget.invcDate); //invoice date

    String invDate = DateFormat("dd-MMM-yyyy").format(id2);

    // DateTime id = DateTime.parse(widget.transDate); //invoice date

    // String trnsdt = DateFormat("dd-MMM-yyyy").format(id);
    GetCompany company = GetCompany();
    int? indexOfCompany = getIt<SharedPreferences>().getInt('companyIndex');
    if (indexOfCompany != null) {
      company =
          Provider.of<TransactionManager>(context).companyList[indexOfCompany];
    }

    // List<Widget> screens = [
    PaidInvoices();
    //   PHistory(),
    //   AllSellers(),
    // ];
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');
    List transLenght = invtr[0];
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';

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
                        left: 9,
                        right: 7,
                        top: 70,
                      ),

                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      child: Container(
                        // height: h10p * 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  // width: w10p * 1.2,
                                  // height: h10p * 0.3,
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
                                      //progress!.show();
                                      Navigator.pushNamed(
                                          context, homeCompanyList);
                                      //progress.dismiss();
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
                                  'Transaction Ledger',
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
                                        '$invoiceNo',
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
                                        '$seller',
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
                                    //left: 6,
                                    right: 10,
                                    // top: 3,
                                  ),
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,

                                      // scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: transLenght.length,
                                      itemBuilder: (context, index) {
                                        final trType = transLenght[index]
                                            ['transaction_type'];

                                        final trAmount =
                                            transLenght[index]['amount'];
                                        double trammt = trAmount.toDouble();
                                        MoneyFormatter fmf =
                                            MoneyFormatter(amount: trammt);

                                        MoneyFormatterOutput trmt = fmf.output;
                                        // String trmt =
                                        //     double.parse(trAmount as String)
                                        //         .toStringAsFixed(2)
                                        //         .toString()
                                        //         .replaceAllMapped(
                                        //             reg, mathFunc);
                                        // this.trmt = trmt;

                                        // String trmt =
                                        //     double.parse(trAmount as String)
                                        //         .toStringAsFixed(2)
                                        //         .toString()
                                        //         .replaceAllMapped(
                                        //             reg, mathFunc);
                                        //   final trmt =
                                        //       double.parse(trAmount.toString())
                                        //           .toStringAsFixed(2);
                                        //   this.trmt = trmt;
                                        // } else {
                                        //   String tramnt = trAmount.toString();
                                        //   String trmt = tramnt.replaceAllMapped(
                                        //       reg, mathFunc);
                                        //   this.trmt = trmt;
                                        // }
                                        // } else {
                                        //   String trmt = trAmount
                                        //       .replaceAllMapped(reg, mathFunc);
                                        //   this.trmt = trmt;
                                        // }

                                        // String trmt =
                                        //     double.parse(trAmount as String)
                                        //         .toStringAsFixed(2)
                                        //         .toString()
                                        //         .replaceAllMapped(
                                        //             reg, mathFunc);

                                        final trDate = transLenght[index]
                                                ['transaction_date'] ??
                                            '';
                                        DateTime trdt = DateTime.parse(
                                            trDate); //invoice date

                                        String transdt =
                                            DateFormat("dd-MMM-yyyy")
                                                .format(trdt);
                                        final trRemark =
                                            transLenght[index]['remark'];
                                        final remarks = [trRemark];
                                        String getNewLineString() {
                                          StringBuffer sb = new StringBuffer();
                                          for (String line in remarks) {
                                            sb.write(line + "\n");
                                          }
                                          return sb.toString();
                                        }

                                        final trinterest = transLenght[index]
                                                ['interest'] ??
                                            '';
                                        if (trinterest == 0.0 ||
                                            trinterest == 0) {
                                          String intrst = trinterest.toString();
                                          intrst = '';
                                        } else {
                                          String strint = trinterest.toString();
                                          double dblintr = double.parse(strint);
                                          MoneyFormatter fmf =
                                              MoneyFormatter(amount: dblintr);

                                          MoneyFormatterOutput intrmf =
                                              fmf.output;
                                          final nonint = intrmf.nonSymbol;

                                          String intrst = nonint.toString();
                                          this.intrst = intrst;
                                        }

                                        // MoneyFormatter discount =
                                        //     MoneyFormatter(amount: trdisc);

                                        // MoneyFormatterOutput discnt =
                                        //     discount.output;

                                        // if (trdisc is double) {
                                        //   // final trDiscount = trdisc.toString();
                                        //   final discnt =
                                        //       double.parse(trdisc.toString())
                                        //           .toStringAsFixed(2);
                                        //   this.discnt = discnt;
                                        // }
                                        //  else {
                                        final trdisc = transLenght[index]
                                                ['discount'] ??
                                            '';

                                        if (trdisc is double) {
                                          // final trDiscount = trdisc.toString();
                                          final discnt =
                                              double.parse(trdisc.toString())
                                                  .toStringAsFixed(2);
                                          this.discnt = discnt;
                                        } else {
                                          if (trdisc == 0.0) {
                                            String discnt = trdisc.toString();
                                            this.discnt = '';
                                          } else {
                                            String discnt1 = trdisc.toString();
                                            String discnt =
                                                discnt1.replaceAllMapped(
                                                    reg, mathFunc);
                                            this.discnt = discnt;
                                          }
                                        }

                                        // else {
                                        //   String discnt1 = trdisc.toString();
                                        //   String discnt = discnt1
                                        //       .replaceAllMapped(reg, mathFunc);
                                        //   this.discnt = discnt;
                                        // }

                                        final amtCleared = transLenght[index]
                                                ['transaction_amount'] ??
                                            '';
                                        double amtclr =
                                            double.parse(amtCleared);
                                        MoneyFormatter amtcleared =
                                            MoneyFormatter(amount: amtclr);

                                        MoneyFormatterOutput clrAmt =
                                            amtcleared.output;
                                        // String clrAmt =
                                        //     double.parse(amtCleared as String)
                                        //         .toStringAsFixed(2)
                                        //         .toString()
                                        //         .replaceAllMapped(
                                        //             reg, mathFunc);
                                        // this.clrAmt = clrAmt;

                                        // if (amtCleared is double) {
                                        //   final clrAmt = double.parse(
                                        //           amtCleared.toString())
                                        //       .toStringAsFixed(2);
                                        //   this.clrAmt = clrAmt;
                                        // } else {
                                        //   String clramt1 =
                                        //       amtCleared.toString();
                                        //   String clrAmt = clramt1
                                        //       .replaceAllMapped(reg, mathFunc);
                                        //   this.clrAmt = clrAmt;
                                        // }

                                        return SizedBox(
                                          height: maxHeight * 0.28,
                                          child: Card(
                                              shadowColor: Color.fromARGB(
                                                  255, 245, 175, 45),
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Transaction Type",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          "$trType",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        Text(
                                                          "Transaction Amount",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${trmt.nonSymbol}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        Text(
                                                          "Transaction Date",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          "$transdt",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        Text(
                                                          "Amount Cleared",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${clrAmt.nonSymbol}",
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 6),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: w10p * 1.85,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Interest",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          "$intrst",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        Text(
                                                          "Discount",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${discnt}",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(height: 15),
                                                        Text(
                                                          "Remarks",
                                                          style: TextStyle(
                                                            fontSize: 13,
                                                          ),
                                                        ),
                                                        // Flexible(
                                                        //   child:
                                                        Text(
                                                          getNewLineString(),
                                                          maxLines: 4,
                                                          style: TextStyle(
                                                              // leadingDistribution:
                                                              //     TextLeadingDistribution
                                                              //         .values
                                                              //         .last,

                                                              // fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),

                                                        // Expanded(
                                                        //     child: SizedBox()),

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
                                                                  FontWeight
                                                                      .bold),
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
                                                    ),
                                                    // SizedBox(
                                                    //   width: w10p * 0.2,
                                                    // )
                                                  ],
                                                ),
                                              )),
                                        );
                                      }),
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