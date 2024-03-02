import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../theme/constants.dart';

class AppbarWidget extends StatefulWidget {
  GlobalKey<ScaffoldState>? askey;
  AppbarWidget({Key? key, askey}) : super(key: key);

  @override
  State<AppbarWidget> createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Container(
        color: Colours.black,
        height: maxHeight,
        child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/xuriti-logo.png",
                width: w10p * 1.9,
              ),
              // InkWell
              //   (
              //   onTap: (){
              //  widget.askey!.currentState!.openEndDrawer();
              //   },
              //     child: SvgPicture.asset("assets/images/menubutton.svg"))
            ],
          ),
        ),
      );
    });
  }
}
