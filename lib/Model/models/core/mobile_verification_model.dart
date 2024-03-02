class MobileVerificationModel {
  String? mobileNumber; //a
  // String? countryCode; //a
  // String? holder; //a
  // String? address;
  // String? email;

  MobileVerificationModel({
    this.mobileNumber,
    // this.countryCode,
    // this.holder,
    // this.address,
    // this.email,
  });

  MobileVerificationModel.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    // countryCode = json['countryCode'];
    // holder = json['holder'];
    // address = json['address'];
    // email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    // data['countryCode'] = this.countryCode;
    // data['holder'] = this.holder;
    // data['address'] = this.address;
    // data['email'] = this.email;
    return data;
  }
}
