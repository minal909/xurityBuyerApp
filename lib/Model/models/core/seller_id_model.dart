

class SellerIdModel {
  bool? status;
  String? errorcode;
  List<SellerListDetails>? sellerListDetails;

  SellerIdModel({
    this.errorcode,
    this.sellerListDetails,
    this.status,
  });
  SellerIdModel.fromJson(Map<String, dynamic> json) {
    if (json['seller_list'] != null) {
      sellerListDetails = <SellerListDetails>[];
      json['seller_list'].forEach((v) {
        sellerListDetails!.add(new SellerListDetails.fromJson(v));
      });
      print(sellerListDetails);
    }
    status = json['status'];
  }
}

class SellerListDetails {
  String? id;
  String? sellerName;

  SellerListDetails({
    this.id,
    this.sellerName,
  });
  SellerListDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    sellerName = json['seller_name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['seller_name'] = this.sellerName;
    print("============= $data");
    return data;
  }
}
