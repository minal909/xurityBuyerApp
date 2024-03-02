import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:xuriti/util/loaderWidget.dart';

import '../../../logic/view_models/transaction_manager.dart';
import '../../../models/core/invoice_model.dart';
import '../../../models/helper/service_locator.dart';

class BillDetailsWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final String heading;

  BillDetailsWidget(
      {required this.maxWidth, required this.maxHeight, required this.heading});

  @override
  Widget build(BuildContext context) {
    var dio = Dio();
    Invoice? invoice = Provider.of<TransactionManager>(context).currentInvoice;
    // String url = invoice!.invoiceFile ?? '';
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return Scaffold(body: ProgressHUD(child: Builder(builder: (context) {
      final progress = ProgressHUD.of(context);
      return Container(
        width: maxWidth,
        // width: maxWidth,
        height: 200,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: GestureDetector(
              onTap: () async {
                context.showLoader();
                //progress!.show();
                await getIt<TransactionManager>().openFile(
                    url:
                        "https://s29.q4cdn.com/816090369/files/doc_downloads/test.pdf");
                // progress.dismiss();
                context.hideLoader();
                Fluttertoast.showToast(msg: "Opening invoice file");
              },
              child: Image.asset("assets/images/invoiceButton.png")),
        ),
      );
    })));
  }
}
//
