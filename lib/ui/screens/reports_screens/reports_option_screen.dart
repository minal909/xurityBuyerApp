import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xuriti/ui/routes/router.dart';

import '../../theme/constants.dart';

class ReportsOptionScreen extends StatelessWidget {
  const ReportsOptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colours.black,
          automaticallyImplyLeading: false,
          flexibleSpace: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 12.0),
                child: Image.asset(
                  "assets/images/xuriti1.png",
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgPicture.asset("assets/images/arrowLeft.svg"),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Reports",
                        style: TextStyles.textStyle75,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 250,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, transactionalStatement);
                    },
                    child: Center(
                      child: Container(
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colours.tangerine),
                        child: Center(
                          child: Text(
                            // "Transactional Statement",
                            " Transactional Ledger",
                            style: TextStyles.textStyle85,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, ledgerInvoiceScreen);
                    },
                    child: Center(
                      child: Container(
                        height: 60,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colours.tangerine),
                        child: Center(
                          child: Text(
                            // "Transactional Ledger",
                            "Transactional Statement",
                            style: TextStyles.textStyle85,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
        ));
  }
}
