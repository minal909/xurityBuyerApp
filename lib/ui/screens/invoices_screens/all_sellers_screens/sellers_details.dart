import 'package:flutter/material.dart';
import 'package:xuriti/models/core/seller_list_model.dart';
import 'package:xuriti/ui/screens/invoices_screens/all_sellers_screens/pending_screen.dart';

import '../../../../logic/view_models/company_details_manager.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../theme/constants.dart';
import '../../../widgets/payment_history_widgets/company_details.dart';
import '../../../widgets/payment_history_widgets/leading.dart';
import '../../../widgets/profile/profile_widget.dart';
import 'closed_screen.dart';

class SellersDetails extends StatefulWidget {
  const SellersDetails({Key? key}) : super(key: key);

  @override
  State<SellersDetails> createState() => _SellersDetailsState();
}

class _SellersDetailsState extends State<SellersDetails> {
  GlobalKey<ScaffoldState> ssk = GlobalKey();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    int? index = getIt<CompanyDetailsManager>().currentSellerIndex;
    List<MSeller>? sellerList =
        getIt<CompanyDetailsManager>().sellerList!.seller;
    MSeller seller = sellerList![index];

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      List<Widget> screens = [
        PendingScreen(
          parentHeight: maxHeight,
        ),
        const ClosedScreen()
      ];
      return Scaffold(
          key: ssk,
          backgroundColor: Colours.black,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            toolbarHeight: h10p * 1.7,
            flexibleSpace: ProfileWidget(pskey: ssk),
          ),
          body: Container(
              width: maxWidth,
              height: maxHeight,
              decoration: const BoxDecoration(
                  color: Colours.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26),
                    topRight: Radius.circular(26),
                  )),
              child: Column(children: [
                LeadingWidget(
                  heading: "Back",
                ),
                CompanyDetailsWidget(
                  maxHeight: maxHeight,
                  maxWidth: maxWidth,
                  image: "assets/images/nippon-logo.png",
                  companyName: seller.seller!.companyName ?? "",
                  creditLimit: seller.seller!.creditLimit.toString(),
                  gstNo: seller.seller!.gstin ?? "",
                  companyAddress: seller.seller!.address ?? "",
                  state: seller.seller!.state ?? "",
                  balanceCredit: seller.seller!.availCredit.toString(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      child: Container(
                        height: h10p * 0.5,
                        width: w10p * 4.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: currentIndex == 0
                                ? Colours.tangerine
                                : Colours.white),
                        child: Center(
                          child: Text(
                            "Pending",
                            style: currentIndex == 0
                                ? TextStyles.textStyle2
                                : TextStyles.textStyle43,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      child: Container(
                        height: h10p * 0.5,
                        width: w10p * 4.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: currentIndex == 1
                                ? Colours.tangerine
                                : Colours.white),
                        child: Center(
                          child: Text(
                            "Closed",
                            style: currentIndex == 1
                                ? TextStyles.textStyle2
                                : TextStyles.textStyle43,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    width: maxWidth,
                    color: Colours.white,
                    child: screens[currentIndex],
                  ),
                )
              ])));
    });
  }
}
