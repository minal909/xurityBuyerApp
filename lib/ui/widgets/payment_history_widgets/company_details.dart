import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../../models/core/seller_list_model.dart';
import '../../theme/constants.dart';

class CompanyDetailsWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String companyName;
  final String image;
  final String companyAddress;
  final String state;
  final String gstNo;
  final String creditLimit;
  final String balanceCredit;

  const CompanyDetailsWidget({
    required this.maxWidth,
    required this.maxHeight,
    required this.image,
    required this.companyName,
    required this.companyAddress,
    required this.state,
    required this.gstNo,
    required this.creditLimit,
    required this.balanceCredit,
  });

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;

    double cl = (creditLimit == null) ? 0 : double.parse(creditLimit);

    double bc = (balanceCredit.isNotEmpty) ? double.parse(balanceCredit) : 0;

    double usedCredit = cl - bc;
    // double usedCreditAmt = double.parse(source)
    // usedCredit;

    MoneyFormatter usdcrdt = MoneyFormatter(amount: usedCredit);

    MoneyFormatterOutput usedcredt = usdcrdt.output;

    // String balcedCredit = bc.toStringAsFixed(2);

    MoneyFormatter balCred = MoneyFormatter(amount: bc);

    MoneyFormatterOutput balancedCrdt = balCred.output;

    String creditLimitAMt = cl.toStringAsFixed(2);

    print("usedCredit ======> $usedCredit");
    print("balcedCredit ======> $balancedCrdt");
    print("creditLimitAMt ======> $creditLimitAMt");
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            width: maxWidth - 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colours.wolfGrey, width: 1)),
            child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h10p * .1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: w10p * .2,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(image),
                      ),
                      SizedBox(
                        width: w10p * .5,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              companyName,
                              style: TextStyles.textStyle8,
                            ),
                            // AutoSizeText(
                            //   "Building name",
                            //   overflow: TextOverflow.ellipsis,
                            //   style: TextStyles.textStyle69,
                            // ),
                            AutoSizeText(
                              companyAddress,
                              style: TextStyles.textStyle69,
                              maxLines: 2,
                            ),
                            AutoSizeText(
                              state,
                              style: TextStyles.textStyle69,
                            ),
                            AutoSizeText(
                              gstNo,
                              style: TextStyles.textStyle69,
                            ),
                            // Row(
                            //   children: [
                            //     AutoSizeText(
                            //       "Credit Limit : ",
                            //       style: TextStyles.textStyle70,
                            //     ),
                            //     AutoSizeText(
                            //       "₹ $creditLimitAMt",
                            //       style: TextStyles.textStyle70,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h1p * 2,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colours.successIcon,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Used Credit",
                                style: TextStyles.textStyle71,
                              ),
                              Text(
                                "₹ ${usedcredt.nonSymbol}",
                                style: TextStyles.textStyle72,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                // "Available Credit Limit",
                                "Credit Limit",
                                style: TextStyles.textStyle71,
                              ),
                              Text(
                                "₹ ${balancedCrdt.nonSymbol}",
                                style: TextStyles.textStyle72,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ])),
      ),
    );
  }
}
