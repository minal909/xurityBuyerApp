// class SellerList {
//   bool? status;
//
//   List<Seller>? seller;
//
//
//
//   SellerList({this.status, this.seller});
//
//   SellerList.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//
//     if (json['seller'] != null) {
//       seller = <Seller>[];
//
//       Map<String, dynamic> temp = {};
//       json['seller'].forEach((v) {
//         temp = {};
//         if ( v['seller'] != null &&
//             v['seller']['_id'] != null &&
//             v['seller']['company_name'] != null
//         ) {
//           temp['sellerId'] = v['seller']['_id'];
//           temp['sellerCompanyName'] = v['seller']['company_name'];
//           temp['sellerCompanyAddress'] = v['seller']['address'];
//           temp['sellerCompanyGstNo'] = v['seller']['gstin'];
//           temp['sellerCompanyAvailCredit'] = v['seller']['avail_credit'];
//           temp['sellerCompanyCreditLimit'] = v['seller']['creditLimit'];
//           temp['sellerCompanyState'] = v['seller']['state'];
//           seller!.add(Seller.fromJson(temp));
//         }
//       });
//     }
//
//
//   }
//
//
// }
//
// class Seller {
//   String? sellerId;
//   String? sellerCompanyName;
//   String? sellerCompanyAddress;
//   String? sellerCompanyGstNo;
//   int? sellerCompanyAvailCredit;
//   int? sellerCompanyCreditLimit;
//   String? sellerCompanyState;
//
//   Seller({
//     this.sellerId,
//     this.sellerCompanyName,
//     this.sellerCompanyAddress,
//     this.sellerCompanyAvailCredit,
//     this.sellerCompanyCreditLimit,
//     this.sellerCompanyGstNo,
//     this.sellerCompanyState
//
//   });
//
//   Seller.fromJson(Map<String, dynamic> json) {
//     sellerId = json['sellerId'];
//     sellerCompanyName = json['sellerCompanyName'];
//     sellerCompanyAddress = json['sellerCompanyAddress'];
//     sellerCompanyAvailCredit = json['sellerCompanyAvailCredit'];
//     sellerCompanyCreditLimit = json['sellerCompanyCreditLimit'];
//     sellerCompanyGstNo = json['sellerCompanyGstNo'];
//     sellerCompanyState = json['sellerCompanyState'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "sellerId": sellerId,
//       "sellerCompanyName": sellerCompanyName,
//       "sellerCompanyAddress": sellerCompanyAddress,
//       "sellerCompanyAvailCredit": sellerCompanyAvailCredit,
//       "sellerCompanyCreditLimit": sellerCompanyCreditLimit,
//       "sellerCompanyGstNo": sellerCompanyGstNo,
//       "sellerCompanyState": sellerCompanyState,
//     };
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

class SellerList {
  bool? status;
  List<MSeller>? seller;

  SellerList({this.status, this.seller});

  SellerList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['seller'] != null) {
      seller = <MSeller>[];
      json['seller'].forEach((v) {
        seller!.add(new MSeller.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.seller != null) {
      data['seller'] = this.seller!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MSeller {
  // BillDetails? billDetails;
  String? sId;
  String? invoiceNumber;
  double? outstandingAmount;
  // List<Null>? itemizedData;
  String? invoiceStatus;
  String? extraCreditFlag;
  String? invoiceFile;
  // bool? emandateRaised;
  String? invoiceType;
  // bool? nbfcFlag;
  String? buyerGst;
  String? sellerGst;
  String? lastPaymentDate;
  String? createdAt;
  String? updatedAt;
  // int? iV;
  String? buyer;
  String? invoiceAmount;
  String? invoiceDate;
  String? invoiceDueDate;
  Seller? seller;

  MSeller(
      {
      // this.billDetails,
      this.sId,
      this.invoiceNumber,
      this.outstandingAmount,
      // this.itemizedData,
      this.invoiceStatus,
      this.extraCreditFlag,
      this.invoiceFile,
      // this.emandateRaised,
      this.invoiceType,
      // this.nbfcFlag,
      this.buyerGst,
      this.sellerGst,
      this.lastPaymentDate,
      this.createdAt,
      this.updatedAt,
      // this.iV,
      this.buyer,
      this.invoiceAmount,
      this.invoiceDate,
      this.invoiceDueDate,
      this.seller});

  MSeller.fromJson(Map<String, dynamic> json) {
    // billDetails = json['bill_details'] != null
    //     ? new BillDetails.fromJson(json['bill_details'])
    //     : null;
    sId = json['_id'];
    invoiceNumber = json['invoice_number'];
    outstandingAmount = json['outstanding_amount'].toDouble();
    // if (json['itemized_data'] != null) {
    //   itemizedData = <Null>[];
    //   json['itemized_data'].forEach((v) {
    //     itemizedData!.add(new Null.fromJson(v));
    //   });
    // }
    invoiceStatus = json['invoice_status'];
    extraCreditFlag = json['extra_credit_flag'];
    invoiceFile = json['invoice_file'];
    // emandateRaised = json['emandate_raised'];
    invoiceType = json['invoice_type'];
    // nbfcFlag = json['nbfc_flag'];
    buyerGst = json['buyer_gst'];
    sellerGst = json['seller_gst'];
    lastPaymentDate = json['last_payment_date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // iV = json['__v'];
    buyer = json['buyer'];
    invoiceAmount = json['invoice_amount'];
    invoiceDate = json['invoice_date'];
    invoiceDueDate = json['invoice_due_date'];
    seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    // json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.billDetails != null) {
    //   data['bill_details'] = this.billDetails!.toJson();
    // }
    data['_id'] = this.sId;
    data['invoice_number'] = this.invoiceNumber;
    data['outstanding_amount'] = this.outstandingAmount;
    // if (this.itemizedData != null) {
    //   data['itemized_data'] =
    //       this.itemizedData!.map((v) => v.toJson()).toList();
    // }
    data['invoice_status'] = this.invoiceStatus;
    data['extra_credit_flag'] = this.extraCreditFlag;
    data['invoice_file'] = this.invoiceFile;
    // data['emandate_raised'] = this.emandateRaised;
    data['invoice_type'] = this.invoiceType;
    // data['nbfc_flag'] = this.nbfcFlag;
    data['buyer_gst'] = this.buyerGst;
    data['seller_gst'] = this.sellerGst;
    data['last_payment_date'] = this.lastPaymentDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    // data['__v'] = this.iV;
    data['buyer'] = this.buyer;
    data['invoice_amount'] = this.invoiceAmount;
    data['invoice_date'] = this.invoiceDate;
    data['invoice_due_date'] = this.invoiceDueDate;
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    return data;
  }
}

class BillDetails {
  GstSummary? gstSummary;
  DiscountSummary? discountSummary;
  TaxSummary? taxSummary;

  BillDetails({this.gstSummary, this.discountSummary, this.taxSummary});

  BillDetails.fromJson(Map<String, dynamic> json) {
    gstSummary = json['gst_summary'] != null
        ? new GstSummary.fromJson(json['gst_summary'])
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

class Seller {
  String? sId;
  String? gstin;
  String? companyName;
  String? address;
  String? district;
  String? state;
  bool? eNachMandate;
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
  int? creditLimit;
  String? availCredit;
  // double? optimizecredit;
  dynamic kyc;
  bool? kycDocumentUpload;
  int? iV;
  String? presignedurl;
  String? annualTurnover;
  String? industryType;
  String? interest;

  Seller(
      {this.sId,
      this.gstin,
      this.companyName,
      this.address,
      this.district,
      this.state,
      this.eNachMandate,
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
      this.kyc,
      this.kycDocumentUpload,
      this.iV,
      this.presignedurl,
      this.annualTurnover,
      this.industryType,
      this.interest});

  Seller.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gstin = json['gstin'];
    companyName = json['company_name'];
    address = json['address'];
    district = json['district'];
    state = json['state'];
    eNachMandate = json['eNachMandate'];
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
    creditLimit = json['creditLimit'];

    availCredit = json['avail_credit'].toString();
    // optimizecredit = json['optimizecredit'];
    kyc = json['kyc'];
    kycDocumentUpload = json['kyc_document_upload'];
    iV = json['__v'];
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
    data['eNachMandate'] = this.eNachMandate;
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
    data['kyc'] = this.kyc;
    data['kyc_document_upload'] = this.kycDocumentUpload;
    data['__v'] = this.iV;
    data['presignedurl'] = this.presignedurl;
    data['annual_turnover'] = this.annualTurnover;
    data['industry_type'] = this.industryType;
    data['interest'] = this.interest;
    return data;
  }
}
