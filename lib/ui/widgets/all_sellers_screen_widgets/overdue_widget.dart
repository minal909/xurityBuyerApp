import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/constants.dart';



class OverdueWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String heading1;
  final String heading2;
  final String companyName;
  const OverdueWidget({required this.maxHeight,required this.maxWidth,required this.heading1,required this.heading2,required this.companyName}) ;

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return
      Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Card(
        elevation: 1,
        child: Container(
          height: h10p * 3.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("assets/images/overdue_screens.svg"),
                    SvgPicture.asset("assets/images/overdueFrame.svg"),
                     Text(
                      companyName,
                      style: TextStyles.textStyle59,
                    ),
                    const Text(
                      "Interest Charged",
                      style: TextStyles.textStyle60,
                    ),
                     Text(
                      " ₹ $heading1",
                      style: TextStyles.textStyle61,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "05 days Overdue",
                      style: TextStyles.textStyle57,
                    ),
                     Text(
                      "₹ $heading2",
                      style: TextStyles.textStyle58,
                    ),
                    SvgPicture.asset("assets/images/button.svg"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
