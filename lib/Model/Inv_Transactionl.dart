// To parse this JSON data, do
//
//     final invoiceTransaction = invoiceTransactionFromJson(jsonString);

import 'dart:convert';

InvoiceTransaction invoiceTransactionFromJson(String str) =>
    InvoiceTransaction.fromJson(json.decode(str));

String invoiceTransactionToJson(InvoiceTransaction data) =>
    json.encode(data.toJson());

class InvoiceTransaction {
  InvoiceTransaction({
    required this.status,
    required this.transcations,
  });

  bool status;
  List<Transcation> transcations;

  factory InvoiceTransaction.fromJson(Map<String, dynamic> json) =>
      InvoiceTransaction(
        status: json["status"] ?? false,
        transcations: json["transcations"] == null
            ? List<Transcation>.from(
                json["transcations"]?.map((x) => Transcation.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "transcations": List<dynamic>.from(transcations.map((x) => x.toJson())),
      };
}

class Transcation {
  Transcation({
    required this.id,
    required this.count,
    required this.details,
  });

  String id;
  int count;
  List<Detail> details;

  factory Transcation.fromJson(Map<String, dynamic> json) => Transcation(
        id: json["_id"] ?? '',
        count: json["count"] ?? 0,
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.seller,
    required this.invoiceNumber,
    required this.invoiceDate,
    required this.transactionType,
    required this.transactionAmount,
    required this.transactionDate,
    required this.remark,
    this.discount,
    this.interest,
    required this.amount,
    this.transactionId,
    this.gstPaid,
    this.totalGst,
  });

  Seller? seller;
  String invoiceNumber;
  String? invoiceDate;
  TransactionType? transactionType;
  String transactionAmount;
  String? transactionDate;
  Remark? remark;
  double? discount;
  double? interest;
  double amount;
  String? transactionId;
  int? gstPaid;
  int? totalGst;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        seller: sellerValues.map[json["seller"] ?? ''],
        invoiceNumber: json["invoice_number"] ?? '',
        invoiceDate: json["invoice_date"],
        transactionType:
            transactionTypeValues.map[json["transaction_type"] ?? ''],
        transactionAmount: json["transaction_amount"] ?? '',
        transactionDate: json["transaction_date"] ?? '',
        remark: remarkValues.map[json["remark"] ?? ''],
        discount: json["discount"]?.toDouble() ?? 0.0,
        interest: json["interest"]?.toDouble() ?? 0.0,
        amount: json["amount"]?.toDouble() ?? 0.0,
        transactionId: json["transactionId"] ?? '',
        gstPaid: json["gst_paid"] ?? 0,
        totalGst: json["total_gst"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "seller": sellerValues.reverse[seller],
        "invoice_number": invoiceNumber,
        "invoice_date": invoiceDate,
        "transaction_type": transactionTypeValues.reverse[transactionType],
        "transaction_amount": transactionAmount,
        "transaction_date": transactionDate,
        "remark": remarkValues.reverse[remark],
        "discount": discount,
        "interest": interest,
        "amount": amount,
        "transactionId": transactionId,
        "gst_paid": gstPaid,
        "total_gst": totalGst,
      };
}

enum Remark { DISCOUNT_APPLIED, GST_PAID, CREDIT_NOTE, INTEREST_PAID }

final remarkValues = EnumValues({
  "Credit Note": Remark.CREDIT_NOTE,
  "Discount Applied": Remark.DISCOUNT_APPLIED,
  "GST Paid": Remark.GST_PAID,
  "Interest Paid": Remark.INTEREST_PAID
});

enum Seller { AVISHEK_TEST_SELLER }

final sellerValues =
    EnumValues({"AVISHEK TEST SELLER": Seller.AVISHEK_TEST_SELLER});

enum TransactionType { CR, DR }

final transactionTypeValues =
    EnumValues({"Cr": TransactionType.CR, "Dr": TransactionType.DR});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
