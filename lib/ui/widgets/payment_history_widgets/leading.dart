import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/constants.dart';

class LeadingWidget extends StatelessWidget {
  final String heading;

  const LeadingWidget({required this.heading}) ;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints)
    {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Padding(
        padding:
        const EdgeInsets.symmetric(vertical: 18, horizontal: 13),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              SvgPicture.asset("assets/images/arrowLeft.svg"),
              SizedBox(
                width: w10p * .3,
              ),
               Text(
                heading,
                style: TextStyles.textStyle41,
              ),
            ],
          ),
        ),
      );
  });
  }
}
