import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../theme/constants.dart';
import '../../invoices_screens/Inv_transaction.dart';

//  InvTransactions(transType: '${widget.transType}',transAmount: '${widget.transAmount}',transDate: '${widget.transAmount}',
//                                     amountCleared: '${widget.amountCleared}', interest: '${widget.interest}',discount: '${widget.discount}',remarks: '${widget.remarks}', );
class TransInv extends StatefulWidget {
  final invTransaction;
  String companyName;
  String amount;
  String invoiceDate;
  String invoiceNumber;

  TransInv({
    required this.invTransaction,
    required this.companyName,
    required this.amount,
    required this.invoiceDate,
    required this.invoiceNumber,
  });

  @override
  State<TransInv> createState() => _TransInvState();
}

class _TransInvState extends State<TransInv> {
  @override
  Widget build(BuildContext context) {
    // DateTime dd = new DateFormat("dd-MM-yyyy").parse(widget.dueDate);
    // var inputDate = DateTime.parse(dd.toString());

    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    // String outputDate = outputFormat.format(inputDate);

    // DateTime.parse(widget.dueDate); //invoice due date

    DateTime id =
        DateTime.tryParse(widget.invoiceDate) ?? DateTime.now(); //invoice date
    var inputDate = DateTime.parse(id.toString());
    var oFormat = DateFormat('MM/dd/yyyy hh:mm a');
    String outputDate = oFormat.format(inputDate);

    DateTime currentDate = DateTime.now();

    // String dueDate = DateFormat("dd-MMM-yyyy").format(dd);
    String invDate = DateFormat("dd-MMM-yyyy").format(id).toString();
    final invdt = [invDate];
    String newLineInvDt() {
      StringBuffer sb = new StringBuffer();
      for (String line in invdt) {
        sb.write(line + "\n");
      }
      return sb.toString();
    }

    String amount = (double.tryParse(widget.amount) ?? 0).toStringAsFixed(2);
    final company12 = [widget.companyName];
    // [widget.companyName];

    String getNewLineString() {
      StringBuffer sb = new StringBuffer();
      for (String line in company12) {
        sb.write(line + "\n");
      }
      return sb.toString();
    }

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: w10p * .5, vertical: 10),
        // child: Expandable(
        //     collapsed: ExpandableButton(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InvTransactions(
                        invtr: [widget.invTransaction],
                        invcDate: '${widget.invoiceDate}',
                        invoiceNo: '${widget.invoiceNumber}',
                        seller: '${widget.companyName}',
                      )),
            );
          },
          child: Card(
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Color.fromARGB(255, 245, 233, 219),
                  color: Colours.offWhite),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.invoiceNumber,
                        style: TextStyles.textStyle6,
                      ),
                      // SizedBox(
                      //   width: maxWidth * 0.3,
                      //   height: maxHeight * 0.05,
                      //   child:
                      Container(
                        width: maxWidth * 0.55,
                        child: Text(
                          getNewLineString(),
                          maxLines: 2,
                          style: TextStyles.textStyle00,
                        ),
                      ),

                      // ),

                      // SizedBox(
                      //   width: 6,
                      // ),
                      // SvgPicture.asset(
                      //     "assets/images/home_images/arrow-circle-right.svg"),
                    ],
                  ),

                  // SizedBox(
                  //   width: 10,
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invoice Date",
                        style: TextStyles.textStyle6,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        newLineInvDt(),
                        maxLines: 2,
                        style: TextStyles.textStyle00,
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 5,
                  // )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
