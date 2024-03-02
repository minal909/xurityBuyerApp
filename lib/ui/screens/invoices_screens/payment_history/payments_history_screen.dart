import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/payment_history_model.dart';
import 'package:xuriti/util/loaderWidget.dart';
import 'package:xuriti/util/loaderWidget_second.dart';
import '../../../../logic/view_models/trans_history_manager.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../theme/constants.dart';
import '../../../widgets/invoice_loader.dart';
import '../../../widgets/invoice_not_found.dart';
import 'all_payment_history.dart';

class PHistory extends StatefulWidget {
  const PHistory({Key? key}) : super(key: key);

  @override
  State<PHistory> createState() => _PHistoryState();
}

class _PHistoryState extends State<PHistory> {
  TextEditingController _textController = TextEditingController();

  DateTime dateTime = DateTime.now();

  _selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      _textController.text = DateFormat.yMd().format(dateTime);
    }
  }

  String? doc;
  // @override
  //
  // void dispose() {
  //
  //   getIt<TransHistoryManager>().resetFilterDetails();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    String? token = getIt<SharedPreferences>().getString('token');
    String? companyId = getIt<SharedPreferences>().getString('companyId');

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return OrientationBuilder(builder: (context, orientation) {
        bool isPortrait = orientation == Orientation.portrait;
        return Scaffold(
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
          body: ProgressHUD(
            child: Builder(builder: (context) {
              final progress = ProgressHUD.of(context);
              // context.showLoader();
              return FutureBuilder(
                  future: getIt<TransHistoryManager>()
                      .getPaymentHistory(token, companyId),
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // show loading indicator
                      // context.showLoader();
                      // context.getLoaderWidget_2();

                      return InvoiceLoader(
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                        name: 'Payment History',
                      );
                    } else if (snapshot.hasError) {
                      return InvoiceNotFound(
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                        name: 'Payment History',
                        notFoundMssg:
                            'Getting some error while \nloading payment history',
                      );
                    } else if (snapshot.hasData) {
                      context.hideLoader_2();
                      PaymentHistory datas = snapshot.data as PaymentHistory;
                      return Consumer<TransHistoryManager>(
                          builder: (context, params, child) {
                        return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: isPortrait ? 15 : 0),
                            child: Container(
                                width: maxWidth,
                                height: maxHeight,
                                decoration: const BoxDecoration(
                                    color: Colours.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(26),
                                      topRight: Radius.circular(26),
                                    )),
                                child: CustomScrollView(
                                  slivers: [
                                    // SliverToBoxAdapter(
                                    //   child: DownloadReport(
                                    //     maxHeight: maxHeight,
                                    //     maxWidth: maxWidth,
                                    //   ),
                                    // ),
                                    SliverToBoxAdapter(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: h1p * 5,
                                            horizontal: w10p * .8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Payment History",
                                                style: TextStyles.textStyle38),
                                            InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              top: Radius
                                                                  .circular(
                                                                      25)),
                                                    ),
                                                    isScrollControlled: true,
                                                    context: context,
                                                    builder: (context) {
                                                      return Wrap(
                                                        children: [
                                                          Container(
                                                            width: maxWidth,
                                                            height: h10p * 6,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(18),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            h1p *
                                                                                1),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Filter by Seller",
                                                                      style: TextStyles
                                                                          .textStyle38,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: w10p *
                                                                              .3,
                                                                          vertical:
                                                                              h1p * 3),
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            border: Border.all(color: Colours.wolfGrey, width: 1),
                                                                            color: Colours.paleGrey),
                                                                        child: DropdownButton<
                                                                            String>(
                                                                          underline:
                                                                              SizedBox(),
                                                                          isExpanded:
                                                                              true,
                                                                          value:
                                                                              params.sellerData,
                                                                          // icon: SvgPicture.asset("assets/images/dropdown-icon.svg"),
                                                                          // style: TextS,
                                                                          onChanged:
                                                                              (String? newValue) async {
                                                                            await getIt<TransHistoryManager>().filterBySeller(newValue);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          items: params
                                                                              .sellerNameList
                                                                              .map<DropdownMenuItem<String>>((String value) {
                                                                            return DropdownMenuItem<String>(
                                                                              value: value,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: AutoSizeText(
                                                                                  value,
                                                                                  style: TextStyles.textStyle6,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }).toList(),
                                                                          hint:
                                                                              Container(
                                                                            width:
                                                                                150, //and here
                                                                            child:
                                                                                Text(
                                                                              "Please Select Seller",
                                                                              style: TextStyles.textStyle128,
                                                                              textAlign: TextAlign.end,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Filters     ",
                                                    style:
                                                        TextStyles.textStyle38,
                                                  ),
                                                  SvgPicture.asset(
                                                      "assets/images/filterRight.svg"),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                      ((context, index) {
                                        String? companyName = "";
                                        String? invoiceAmount = "";
                                        String? invoiceDate = "";
                                        String? dueDate = "";
                                        String? paymentDate = "";
                                        String? invoiceId = "";
                                        String? sellerId = "";

                                        TrancDetail? fullDetails;
                                        if (params.filtered_list.isNotEmpty) {
                                          // invoiceAmount = params.paymentDetails!
                                          //     .trancDetail![index].orderAmount;

                                          invoiceAmount = params
                                              .filtered_list[index].orderAmount;

                                          companyName = params
                                                  .filtered_list[index]
                                                  .sellerName!
                                                  .isEmpty
                                              ? ""
                                              : params.filtered_list[index]
                                                  .sellerName;

                                          sellerId = params.filtered_list[index]
                                                  .sellerId!.isEmpty
                                              ? ""
                                              : params.filtered_list[index]
                                                  .sellerId;
                                          getIt<SharedPreferences>()
                                              .setString('sellerId', sellerId!);

                                          invoiceDate = params
                                              .filtered_list[index].createdAt;

                                          dueDate = params
                                              .filtered_list[index].createdAt;
                                          paymentDate = params
                                              .filtered_list[index].createdAt;
                                          invoiceId = params
                                                  .filtered_list[index]
                                                  .invoiceNumber!
                                                  .isEmpty
                                              ? ""
                                              : params.filtered_list[index]
                                                  .invoiceNumber;
                                          fullDetails =
                                              params.filtered_list[index];
                                        }
                                        // Seller? seller =
                                        //     data.trancDetail![index].seller;
                                        return AllPaymentHistory(
                                          maxWidth: maxWidth,
                                          maxHeight: maxHeight,
                                          companyName: companyName ?? '',
                                          invoiceAmount: invoiceAmount ?? '',
                                          invoiceDate: invoiceDate ?? '',
                                          dueDate: dueDate ?? '',
                                          paymentDate: paymentDate ?? '',
                                          fullDetails: fullDetails!,
                                          invoiceId: invoiceId ?? '',
                                          sellerId: sellerId,
                                        );
                                      }),
                                      childCount: params.filtered_list.isEmpty
                                          ? 0
                                          : params.filtered_list.length,
                                    )),
                                  ],
                                )));
                      });
                    } else {
                      return InvoiceNotFound(
                        maxHeight: maxHeight,
                        maxWidth: maxWidth,
                        name: 'Payment History',
                        notFoundMssg: 'You have not made any payment yet.',
                      );
                    }
                  });
            }),
          ),
        );
      });
    });
  }
}
