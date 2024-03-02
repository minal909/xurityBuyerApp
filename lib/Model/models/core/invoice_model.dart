class TotalOutstandingAmount {
  bool? status;
  num? outstaningAmount;

  TotalOutstandingAmount({this.status, this.outstaningAmount});

  TotalOutstandingAmount.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    outstaningAmount = json['total_payable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['total_payable'] = this.outstaningAmount;
    return data;
  }
}

class Invoices {
  List<Invoice>? invoice;

  bool? status;

  Invoices({this.invoice, this.status});

  Invoices.fromJson(Map<String, dynamic> json) {
    if (json['invoice'] != null) {
      invoice = <Invoice>[];
      json['invoice'].forEach((v) {
        invoice!.add(new Invoice.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Invoice {
  BillDetails? billDetails;
  String? sId;
  String? outstandingAmount;
  List<String>? itemizedData;
  String? invoiceStatus;
  // String? extraCreditFlag;
  String? invoiceFile;
  String? invoiceNumber;
  num? paidDiscount;
  num? paidInterest;
  String? createdAt;
  String? updatedAt;
  // int? iV;
  Buyer? buyer;
  String? buyerGst;
  String? invoiceAmount;
  String? invoiceDate;
  String? invoiceDueDate;
  String? invoiceType;
  Buyer? seller;
  String? sellerGst;
  String? nbfcName;
  num? discount;
  num? interest;
  String? payableAmount;

  Invoice(
      {this.billDetails,
      this.sId,
      this.outstandingAmount,
      this.itemizedData,
      this.invoiceStatus,
      // this.extraCreditFlag,
      this.invoiceFile,
      this.invoiceNumber,
      this.createdAt,
      this.updatedAt,
      // this.iV,
      this.buyer,
      this.buyerGst,
      this.paidDiscount,
      this.paidInterest,
      this.invoiceAmount,
      this.invoiceDate,
      this.invoiceDueDate,
      this.invoiceType,
      this.seller,
      this.sellerGst,
      this.nbfcName,
      this.discount,
      this.interest,
      this.payableAmount});

  Invoice.fromJson(Map<String, dynamic> json) {
    billDetails =
        json['bill_details'] != null ? BillDetails.fromJson(json) : null;
    sId = json['_id'];
    outstandingAmount = json['outstanding_amount'].toString();
    itemizedData = (json['itemized_data'] == null)
        ? json['itemized_data']
        : json['itemized_data'].cast<String>();

    invoiceStatus = json['invoice_status'];
    // extraCreditFlag = json['extra_credit_flag'];
    invoiceFile = json['invoice_file'];
    invoiceNumber = json['invoice_number'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
    buyerGst = json['buyer_gst'];
    invoiceAmount = json['invoice_amount'];
    paidDiscount = json['paid_discount'];
    paidInterest = json['paid_interest'];
    invoiceDate = json['invoice_date'];
    invoiceDueDate = json['invoice_due_date'];
    invoiceType = json['invoice_type'];
    seller = json['seller'] != null ? Buyer.fromJson(json['seller']) : null;
    sellerGst = json['seller_gst'];
    nbfcName = json['nbfc_name'];
    discount = json['discount'] ?? 0;
    interest = json['interest'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['outstanding_amount'] = this.outstandingAmount;
    data['itemized_data'] = this.itemizedData;
    data['invoice_status'] = this.invoiceStatus;
    // data['extra_credit_flag'] = this.extraCreditFlag;
    data['invoice_file'] = this.invoiceFile;
    data['invoice_number'] = this.invoiceNumber;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['paid_interest'] = this.paidInterest;
    data['paid_discount'] = this.paidDiscount;
    // data['__v'] = this.iV;
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    data['buyer_gst'] = this.buyerGst;
    data['invoice_amount'] = this.invoiceAmount;
    data['invoice_date'] = this.invoiceDate;
    data['invoice_due_date'] = this.invoiceDueDate;

    data['invoice_type'] = this.invoiceType;
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    data['seller_gst'] = this.sellerGst;
    return data;
  }
}

class Invoice1 {
  Invoice1({
    required this.billDetails,
    required this.id,
    required this.disbursementFlag,
    required this.invoiceNumber,
    required this.outstandingAmount,
    required this.itemizedData,
    required this.invoiceStatus,
    required this.extraCreditFlag,
    required this.invoiceFile,
    required this.emandateRaised,
    required this.invoiceType,
    required this.nbfcFlag,
    required this.buyerGst,
    required this.sellerGst,
    this.lastPaymentDate,
    required this.paidInterest,
    required this.paidDiscount,
    required this.taxPaid,
    required this.userConsentGiven,
    required this.alreadyPaidAmount,
    required this.associateInvoices,
    required this.v,
    required this.buyer,
    required this.invoiceAmount,
    required this.invoiceDate,
    required this.invoiceDueDate,
    required this.nbfcMapped,
    required this.seller,
    required this.totalInvoiceAmount,
    required this.taxUnpaid,
    required this.userComment,
    required this.userConsentMessage,
  });

  BillDetails billDetails;
  String id;
  bool disbursementFlag;
  String invoiceNumber;
  int outstandingAmount;
  List<dynamic> itemizedData;
  String invoiceStatus;
  String extraCreditFlag;
  String invoiceFile;
  bool emandateRaised;
  String invoiceType;
  bool nbfcFlag;
  String buyerGst;
  String sellerGst;
  dynamic lastPaymentDate;
  int paidInterest;
  int paidDiscount;
  int taxPaid;
  bool userConsentGiven;
  int alreadyPaidAmount;

  List<dynamic> associateInvoices;
  int v;
  Buyer buyer;
  String invoiceAmount;
  String? invoiceDate;
  String? invoiceDueDate;
  String nbfcMapped;
  Buyer seller;
  String totalInvoiceAmount;
  int taxUnpaid;
  String userComment;
  String userConsentMessage;

  factory Invoice1.fromJson(Map<String, dynamic> json) => Invoice1(
        billDetails: BillDetails.fromJson(json["bill_details"]),
        id: json["_id"],
        disbursementFlag: json["Disbursement_flag"],
        invoiceNumber: json["invoice_number"],
        outstandingAmount: json["outstanding_amount"],
        itemizedData: List<dynamic>.from(json["itemized_data"].map((x) => x)),
        invoiceStatus: json["invoice_status"],
        extraCreditFlag: json["extra_credit_flag"],
        invoiceFile: json["invoice_file"],
        emandateRaised: json["emandate_raised"],
        invoiceType: json["invoice_type"],
        nbfcFlag: json["nbfc_flag"],
        buyerGst: json["buyer_gst"],
        sellerGst: json["seller_gst"],
        lastPaymentDate: json["last_payment_date"],
        paidInterest: json["paid_interest"],
        paidDiscount: json["paid_discount"],
        taxPaid: json["tax_paid"],
        userConsentGiven: json["userConsentGiven"],
        alreadyPaidAmount: json["already_paid_amount"],
        associateInvoices:
            List<dynamic>.from(json["Associate_invoices"].map((x) => x)),
        v: json["__v"],
        buyer: Buyer.fromJson(json["buyer"]),
        invoiceAmount: json["invoice_amount"],
        invoiceDate: json['invoice_date'],
        invoiceDueDate: json["invoice_due_date"],
        nbfcMapped: json["nbfc_mapped"],
        seller: Buyer.fromJson(json["seller"]),
        totalInvoiceAmount: json["total_invoice_amount"],
        taxUnpaid: json["tax_unpaid"],
        userComment: json["user_comment"],
        userConsentMessage: json["user_consent_message"],
      );

  Map<String, dynamic> toJson() => {
        "bill_details": billDetails.toJson(),
        "_id": id,
        "Disbursement_flag": disbursementFlag,
        "invoice_number": invoiceNumber,
        "outstanding_amount": outstandingAmount,
        "itemized_data": List<dynamic>.from(itemizedData.map((x) => x)),
        "invoice_status": invoiceStatus,
        "extra_credit_flag": extraCreditFlag,
        "invoice_file": invoiceFile,
        "emandate_raised": emandateRaised,
        "invoice_type": invoiceType,
        "nbfc_flag": nbfcFlag,
        "buyer_gst": buyerGst,
        "seller_gst": sellerGst,
        "last_payment_date": lastPaymentDate,
        "paid_interest": paidInterest,
        "paid_discount": paidDiscount,
        "tax_paid": taxPaid,
        "userConsentGiven": userConsentGiven,
        "already_paid_amount": alreadyPaidAmount,
        "Associate_invoices":
            List<dynamic>.from(associateInvoices.map((x) => x)),
        "__v": v,
        "buyer": buyer.toJson(),
        "invoice_amount": invoiceAmount,
        "invoice_date": invoiceDate,
        "invoice_due_date": invoiceDueDate,
        "nbfc_mapped": nbfcMapped,
        "seller": seller.toJson(),
        "total_invoice_amount": totalInvoiceAmount,
        "tax_unpaid": taxUnpaid,
        "user_comment": userComment,
        "user_consent_message": userConsentMessage,
      };
}

class TransactionInvoice {
  // List<TransactionInvoice>? invoice;

  String? transaction_type;
  // List<String>? itemizedData;
  // String? extraCreditFlag;
  String? invoice_number;
  // int? iV;
  String? transaction_date;
  String? invoice_date;
  String? amount;
  String? seller_name;
  String? interest;
  String? discount;

  String? remark;

  String? transaction_amount;

  TransactionInvoice({
    this.transaction_type,
    this.invoice_number,
    this.transaction_date,
    this.invoice_date,
    this.amount,
    // this.extraCreditFlag,
    this.seller_name,
    this.interest,
    this.discount,
    this.remark,
    // this.iV,
    this.transaction_amount,
  });

  TransactionInvoice.fromJson(Map<String, dynamic> json) {
    transaction_type = json['transaction_type'];
    invoice_number = json['invoice_number'].toString();

    transaction_date = json['transaction_date'];
    // extraCreditFlag = json['extra_credit_flag'];
    invoice_date = json['invoice_date'];
    amount = json['amount'];
    seller_name = json['seller_name'];
    interest = json['interest'];

    discount = json['discount'];
    remark = json['remark'];
    transaction_amount = json['transaction_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_type'] = this.transaction_type;
    data['invoice_number'] = this.invoice_number;
    data['transaction_date'] = this.transaction_date;
    data['invoice_date'] = this.invoice_date;
    // data['extra_credit_flag'] = this.extraCreditFlag;
    data['amount'] = this.amount;
    data['seller_name'] = this.seller_name;
    data['interest'] = this.interest;
    data['discount'] = this.discount;
    data['remark'] = this.remark;
    data['transaction_amount'] = this.transaction_amount;
    // data['__v'] = this.iV;
    // if (this.buyer != null) {
    //   data['buyer'] = this.buyer!.toJson();
    // }
    // data['buyer_gst'] = this.buyerGst;
    // data['invoice_amount'] = this.invoiceAmount;
    // data['invoice_date'] = this.invoiceDate;
    // data['invoice_due_date'] = this.invoiceDueDate;

    // data['invoice_type'] = this.invoiceType;
    // if (this.seller != null) {
    //   data['seller'] = this.seller!.toJson();
    // }
    // data['seller_gst'] = this.sellerGst;
    return data;
  }
}

class BillDetails {
  GstSummary? gstSummary;
  DiscountSummary? discountSummary;
  TaxSummary? taxSummary;

  BillDetails({this.gstSummary, this.discountSummary, this.taxSummary});

  BillDetails.fromJson(Map<String, dynamic> json) {
    json = (json['bill_details'] != null &&
            json['bill_details'] is Map<String, dynamic>)
        ? json["bill_details"]
        : new Map<String, dynamic>();
    gstSummary = json['gst_summary'] != null
        ? new GstSummary.fromJson(json['gst_summary']) //
        : null;
    discountSummary = json['discount_summary'] != null
        ? new DiscountSummary.fromJson(json['discount_summary'])
        : null;
    taxSummary = json['tax_summary'] != null
        ? new TaxSummary.fromJson(json['tax_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gstSummary != null) {
      data['gst_summary'] = this.gstSummary!.toJson();
    }
    if (this.discountSummary != null) {
      data['discount_summary'] = this.discountSummary!.toJson();
    }
    if (this.taxSummary != null) {
      data['tax_summary'] = this.taxSummary!.toJson();
    }
    return data;
  }
}

class GstSummary {
  String? cgst;
  String? sgst;
  String? igst;
  String? totalTax;

  GstSummary({this.cgst, this.sgst, this.igst, this.totalTax});

  GstSummary.fromJson(Map<String, dynamic> json) {
    cgst = json['cgst'];
    sgst = json['sgst'];
    igst = json['igst'];
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['igst'] = this.igst;
    data['total_tax'] = this.totalTax;
    return data;
  }
}

class DiscountSummary {
  String? cashDiscount;
  String? specialDiscount;
  String? inBillDiscount;
  String? totalDiscount;

  DiscountSummary(
      {this.cashDiscount,
      this.specialDiscount,
      this.inBillDiscount,
      this.totalDiscount});

  DiscountSummary.fromJson(Map<String, dynamic> json) {
    cashDiscount = json['cash_discount'];
    specialDiscount = json['special_discount'];
    inBillDiscount = json['in_bill_discount'];
    totalDiscount = json['total_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cash_discount'] = this.cashDiscount;
    data['special_discount'] = this.specialDiscount;
    data['in_bill_discount'] = this.inBillDiscount;
    data['total_discount'] = this.totalDiscount;
    return data;
  }
}

class TaxSummary {
  String? tcsBasedValue;
  String? tcsTaxValue;

  TaxSummary({this.tcsBasedValue, this.tcsTaxValue});

  TaxSummary.fromJson(Map<String, dynamic> json) {
    tcsBasedValue = json['tcs_based_value'];
    tcsTaxValue = json['tcs_tax_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tcs_based_value'] = this.tcsBasedValue;
    data['tcs_tax_value'] = this.tcsTaxValue;
    return data;
  }
}

class Buyer {
  String? sId;
  String? gstin;
  String? companyName;
  String? address;
  String? district;
  String? state;
  String? pincode;
  int? companyMobile;
  String? companyEmail;
  String? pan;
  String? cin;
  String? tan;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? adminMobile;
  String? adminEmail;
  String? adminName;
  String? creditLimit;
  String? availCredit;
  // String? optimizecredit;
  // int? iV;
  String? presignedurl;
  String? annualTurnover;
  String? industryType;
  String? interest;

  Buyer(
      {this.sId,
      this.gstin,
      this.companyName,
      this.address,
      this.district,
      this.state,
      this.pincode,
      this.companyMobile,
      this.companyEmail,
      this.pan,
      this.cin,
      this.tan,
      this.status,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.adminMobile,
      this.adminEmail,
      this.adminName,
      this.creditLimit,
      this.availCredit,
      // this.optimizecredit,
      // this.iV,
      this.presignedurl,
      this.annualTurnover,
      this.industryType,
      this.interest});

  Buyer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gstin = json['gstin'];
    companyName = json['company_name'];
    address = json['address'];
    district = json['district'];
    state = json['state'];
    pincode = json['pincode'].toString();
    companyMobile = json['company_mobile'];
    companyEmail = json['company_email'];
    pan = json['pan'];
    cin = json['cin'];
    tan = json['tan'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    adminMobile = json['admin_mobile'];
    adminEmail = json['admin_email'];
    adminName = json['admin_name'];
    json['creditLimit'] == null
        ? ""
        : creditLimit = json['creditLimit'].toString();
    json['avail_credit'] == null
        ? ""
        : availCredit = json['avail_credit'].toString();
    // json['optimizecredit'] == null ? "" :
    // optimizecredit = json['optimizecredit'].toString();
    // iV = json['__v'];
    presignedurl = json['presignedurl'];
    annualTurnover = json['annual_turnover'];
    industryType = json['industry_type'];
    interest = json['interest'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gstin'] = this.gstin;
    data['company_name'] = this.companyName;
    data['address'] = this.address;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['company_mobile'] = this.companyMobile;
    data['company_email'] = this.companyEmail;
    data['pan'] = this.pan;
    data['cin'] = this.cin;
    data['tan'] = this.tan;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['admin_mobile'] = this.adminMobile;
    data['admin_email'] = this.adminEmail;
    data['admin_name'] = this.adminName;
    data['creditLimit'] = this.creditLimit;
    data['avail_credit'] = this.availCredit;
    // data['optimizecredit'] = this.optimizecredit;
    // data['__v'] = this.iV;
    data['presignedurl'] = this.presignedurl;
    data['annual_turnover'] = this.annualTurnover;
    data['industry_type'] = this.industryType;
    data['interest'] = this.interest;
    return data;
  }
}
