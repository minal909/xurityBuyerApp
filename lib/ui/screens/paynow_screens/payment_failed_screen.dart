import 'dart:async';
import 'package:flutter/material.dart';

import '../../../logic/view_models/company_details_manager.dart';
import '../../../models/helper/service_locator.dart';
import '../../routes/router.dart';
import '../../theme/constants.dart';
class PaymentFailed extends StatefulWidget {
  const PaymentFailed({Key? key}) : super(key: key);

  @override
  State<PaymentFailed> createState() => _PaymentFailedState();
}

class _PaymentFailedState extends State<PaymentFailed> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    getIt<CompanyDetailsManager>().resetSellerInfo();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, landing);

  }

  initScreen(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return SafeArea(
          child: Scaffold(

              backgroundColor: Colours.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  toolbarHeight: h10p * .8,
                  flexibleSpace:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Padding(
                      padding:  EdgeInsets.only(left:w1p * 3,top: h1p * 3),
                      child: Image.asset(
                      "assets/images/xuriti-logo.png",
                      width: w10p * 1.9,
                  ),
                    ),]),),
              body: Container(
                  width: maxWidth,
                  decoration: const BoxDecoration(
                      color: Colours.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: h10p * 2.8),
                      child: Column(
                        children: [
                          Container(
                              height: h10p * 1.5,
                              width: w10p * 2,
                              child: Image(image: AssetImage(
                                "assets/images/kycImages/cancel.png",))),
                          SizedBox(height: h1p * 2,),
                          Text("Payment Failed", style: TextStyles.textStyle26,)
                        ],
                      ),
                    ),
                  )))
      );
    });
  }
}

