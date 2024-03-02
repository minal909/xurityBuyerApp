import 'package:flutter/material.dart';





class ClosedScreen extends StatefulWidget {
  const ClosedScreen({Key? key}) : super(key: key);

  @override
  State<ClosedScreen> createState() => _ClosedScreenState();
}

class _ClosedScreenState extends State<ClosedScreen> {
  @override
  Widget build(BuildContext context) {
    return   LayoutBuilder(builder: (context, constraints)
    {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return ListView(
        children: [
          // AllPaymentHistory(),
          // AllPaymentHistory(),
          // AllPaymentHistory()
        //   ClosedWidget(maxWidth: maxWidth, maxHeight: maxHeight,amount: "12,345",day: "30.Aug.2022",companyName: "Company Name",),
        //   ClosedSavedWidget(maxWidth: maxWidth, maxHeight: maxHeight, amount:  "12,345", day: "30.Aug.2022",SAmount: "545",companyName: "Company Name"),
        //   ClosedWidget(maxWidth: maxWidth, maxHeight: maxHeight,amount: "12,345",day: "30.Aug.2022",companyName: "Company Name",),
         ],
      );
    });
  }
}
