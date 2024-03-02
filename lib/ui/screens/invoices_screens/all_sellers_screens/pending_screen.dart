import 'package:flutter/material.dart';

import '../../../theme/constants.dart';

class PendingScreen extends StatefulWidget {
  final double parentHeight;
  // final double parentHeight;
  PendingScreen({required this.parentHeight}) ;

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  // int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // int? index = getIt<CompanyDetailsManager>().currentSellerIndex;
    // SellerList? sellerList = getIt<CompanyDetailsManager>().sellerList;
    // // Seller seller =sellerList![index] ;

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Container(
        width: maxWidth,
        height: maxHeight,
        decoration: const BoxDecoration(
            color: Colours.white,

          ),
        child: CustomScrollView(
         slivers: [

      //       SliverList(
      //           delegate: SliverChildBuilderDelegate(
      //         ((context, index) {
      //           return PendingInvoiceWidget(
      //             maxWidth: maxWidth,
      //             maxHeight: maxHeight,
      //             amount: "1,42,345",
      //             dueDate: "",
      //             invoiceDate: "",
      //             companyName: "Nippon Paint",
      //             savedAmount: "545",
      //             isOverdue: false,
      //             fullDetails:,
      //             index: index,
      //           );
      //         }),
      //         childCount: 1,
      //       )),
      // //       SliverList(delegate: SliverChildBuilderDelegate(
      // //           ((context, index) {
      // //             return  OverdueWidget(maxHeight: maxHeight,maxWidth: maxWidth,heading1: "500",heading2: "1,42,345",companyName: "Company Name",);
      // //
      // // }))
      //
      //       )
      //     ]
        ]),
      );
    });
  }
}
