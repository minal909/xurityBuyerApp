import 'package:flutter/material.dart';

import '../../theme/constants.dart';

class Submitbutton extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String content;
  final bool isKyc;
  final bool active;
  const Submitbutton(
      {required this.maxWidth,
      required this.isKyc,
      required this.maxHeight,
      required this.content,
      this.active = true});

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    double w1p = maxWidth * 0.01;
    return active
        ? Padding(
            padding:
                EdgeInsets.symmetric(horizontal: w1p * 6, vertical: h1p * 8),
            child: Container(
              height: h1p * 6,
              width: w1p * 13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: isKyc == true ? Colours.pumpkin : Colours.successPrimary,
              ),
              child: Center(
                  child: Text(
                content,
                style: TextStyles.subHeading,
              )),
            ),
          )
        : Padding(
            padding:
                EdgeInsets.symmetric(horizontal: w1p * 6, vertical: h1p * 8),
            child: Container(
              height: h1p * 6,
              width: w1p * 13,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colours.gey,
              ),
              child: Center(
                  child: Text(
                content,
                style: TextStyles.subHeading,
              )),
            ),
          );
  }
}
