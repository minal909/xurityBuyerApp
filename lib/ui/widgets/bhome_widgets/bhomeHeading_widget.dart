import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/constants.dart';

class SubHeadingWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;

  final String heading1;

  const SubHeadingWidget({required this.maxWidth,required this.maxHeight,required this.heading1,}) ;

  @override
  Widget build(BuildContext context) {
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return Container(
      width: maxWidth,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colours.pumpkin,
      ),
      child:Padding(
        padding:  EdgeInsets.symmetric(horizontal: w10p * 0.2,vertical:h10p * .24 ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                SvgPicture.asset("assets/images/polygonRed.svg"),
                SizedBox(width: w10p*0.2,),
                Text(heading1,style: TextStyles.subHeading,),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
