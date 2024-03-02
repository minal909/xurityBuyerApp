import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/registration_screens/business_register_screen.dart';

import '../../../logic/view_models/company_details_manager.dart';
import '../../theme/constants.dart';

class BusinessRegistered extends StatefulWidget {
  const BusinessRegistered({Key? key}) : super(key: key);

  @override
  State<BusinessRegistered> createState() => _ShopRegisterState();
}

class _ShopRegisterState extends State<BusinessRegistered> {
  double sheetSize = .6;
  double maxSize = 1;
  bool showDetails = false;
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController gstNumber = TextEditingController();

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Colors.transparent, actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset("assets/images/xuriti-logo.png"),
          )
        ]),
        body: Container(
          child: Stack(
            children: [
              Positioned(
                  bottom: h10p * 5.5,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: CenterWidget(),
                  ))),
              DraggableScrollableSheet(
                initialChildSize: sheetSize,
                minChildSize: sheetSize,
                maxChildSize: maxSize,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView(
                        controller: scrollController,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 18),
                            child: Center(
                                child: Text(
                              "Company Registered",
                              style: TextStyles.textStyle3,
                            )),
                          ),
                          Consumer<CompanyDetailsManager>(
                              builder: (context, params, child) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Container(
                                    height: h10p * 3,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 0.5,
                                              blurRadius: 3)
                                        ]),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 24, horizontal: 18),
                                    width: maxWidth,
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Company Name : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(

                                                      "${params.companyinfo?.company!.companyName}",
                                                      style:
                                                      TextStyles.textStyle16),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Address : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            //  SizedBox(width: w10p * ,)
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                   "${params.companyinfo?.company!.address}" ,
                                                      //maxLines: 2,
                                                      softWrap: true,
                                                      style:
                                                      TextStyles.textStyle16),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "PAN No : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Text(
                                                "${params.companyinfo?.company!.pan}" ,
                                                           style: TextStyles.textStyle16),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "District : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Text(
                                                "${params.companyinfo?.company!.district}",
                                                style: TextStyles.textStyle16),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "State : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Text(
                                                "${params.companyinfo?.company!.state![0]}",
                                                style: TextStyles.textStyle16),
                                            SizedBox(
                                              width: w10p * .2,
                                            ),
                                            Text(
                                                "(${params.companyinfo?.company!.state![1]})",
                                                style: TextStyles.textStyle16),
                                            const SizedBox(
                                              width: 18,
                                            ),
                                            const Text(
                                              "Pincode : ",
                                              style: TextStyles.textStyle17,
                                            ),
                                            Text(
                                                "${params.companyinfo?.company!.pinCode}" ,
                                                style: TextStyles.textStyle16),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                );
                              }),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, companyList);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, ),
                                    width : w10p * 8.7,
                                    child: const Center(
                                        child: Text("Continue to App",
                                            style: TextStyles.textStyle5)),
                                    decoration: BoxDecoration(
                                        color: Colours.primary,
                                        borderRadius: BorderRadius.circular(7)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
