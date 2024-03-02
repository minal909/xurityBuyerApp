class PaymentHistory {
  List<TrancDetail>? trancDetail;
  bool? status;

  PaymentHistory({this.trancDetail, this.status});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    if (json['trunc_details'] != null) {
      trancDetail = <TrancDetail>[];
      json['trunc_details'].forEach((v) {
        trancDetail!.add(new TrancDetail.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trancDetail != null) {
      data['trunc_details'] = this.trancDetail!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class TrancDetail {
  String? invoiceNumber;
  String? buyerName;
  String? buyerId;
  String? sellerId;
  String? sellerName;
  String? orderStatus;
  String? orderId;
  String? orderAmount;
  String? createdAt;
  String? paymentDate;
  String? paymentMode;
  String? cfOrderId;
  String? sId;

  TrancDetail(
      {this.invoiceNumber,
      this.buyerName,
      this.buyerId,
      this.sellerId,
      this.sellerName,
      this.orderStatus,
      this.orderId,
      this.orderAmount,
      this.createdAt,
      this.paymentDate,
      this.paymentMode,
      this.cfOrderId,
      this.sId});

  TrancDetail.fromJson(Map<String, dynamic> json) {
    invoiceNumber = json['invoice_number'];
    buyerName = json['buyer_name'];
    buyerId = json['buyer_id'];
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    orderStatus = json['order_status'];
    orderId = json['order_id'];
    orderAmount = json['order_amount'];
    paymentDate = json['payment_date'];
    paymentMode = json['payment_mode'];
    createdAt = json['createdAt'];
    cfOrderId = json['cf_order_id'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_number'] = this.invoiceNumber;
    data['buyer_name'] = this.buyerName;
    data['buyer_id'] = this.buyerId;
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['order_status'] = this.orderStatus;
    data['order_id'] = this.orderId;
    data['payment_date'] = this.paymentDate;
    data['payment_mode'] = this.paymentMode;
    data['order_amount'] = this.orderAmount;
    data['createdAt'] = this.createdAt;
    data['cf_order_id'] = this.cfOrderId;
    data['_id'] = this.sId;
    return data;
  }
}
