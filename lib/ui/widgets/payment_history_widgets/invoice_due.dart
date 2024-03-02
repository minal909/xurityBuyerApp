import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/constants.dart';

class InvoiceDueDateWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String invoiceDate;
  final String companyName;
  final String dueDate;
  final String companyNameDue;

  const InvoiceDueDateWidget({required this.maxWidth,required this.maxHeight,required this.invoiceDate,required this.companyName,required this.dueDate,required this.companyNameDue});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints)
    {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return
        Padding(
        padding:  EdgeInsets.symmetric(horizontal: w10p * .50),
        child: Container(

          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Invoice Date",
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      invoiceDate,
                      style: TextStyles.textStyle63,
                    ),
                    Text(
                      companyName,
                      style: TextStyles.textStyle64,
                    ),
                  ],
                ),

                SvgPicture.asset("assets/images/arrow.svg"),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Due Date",
                      style: TextStyles.textStyle62,
                    ),
                    Text(
                      dueDate,
                      style: TextStyles.textStyle63,
                    ),
                    Text(
                      companyNameDue,
                      style: TextStyles.textStyle64,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
