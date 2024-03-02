class SellerInfo {
  bool? status;
  String? totalOutstanding;
  String? totalInterest;
  String? payableAmount;
  String? totalDiscount;
  String? totalGst;

  SellerInfo(
      {this.status,
      this.totalOutstanding,
      this.totalInterest,
      this.payableAmount,
      this.totalDiscount,
      this.totalGst});

  SellerInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalOutstanding = json['total_outstanding'].toString();
    totalInterest = json['total_interest'].toString();
    payableAmount = json['paybaleAmount'].toString();
    totalDiscount = json['total_discount'].toString();
    totalGst = json['total_gst'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['totalOutstanding'] = totalOutstanding;
    data['totalInterest'] = totalInterest;
    data['paybaleAmount'] = payableAmount;
    data['totalDiscount'] = totalDiscount;
    data['totalGst'] = totalGst;
    return data;
  }
}
