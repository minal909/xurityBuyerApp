class BussinessDetails {
  String? gstin;
  String? dealerName;
  String? companyName;
  String? address;
  String? district;
  List<String>? state;
  String? pinCode;
  String? companyMobile;
  String? companyEmail;
  String? pan;
  String? cin;
  String? tan;
  String? industryType;
  String? annualTurnover;
  String? userID;
  String? adminMobile;
  String? adminEmail;

  BussinessDetails(
      {this.gstin,
        this.dealerName,
        this.companyName,
        this.address,
        this.district,
        this.state,
        this.pinCode,
        this.companyMobile,
        this.companyEmail,
        this.pan,
        this.cin,
        this.tan,
        this.industryType,
        this.annualTurnover,
        this.userID,
        this.adminMobile,
        this.adminEmail,
      });

  BussinessDetails.fromJson(Map<String, dynamic> json) {
    gstin = json['gstin'];
    dealerName = json['dealerName'];
    companyName = json['companyName'];
    address = json['address'];
    district = json['district'];
    state = json['state'].cast<String>();
    pinCode = json['pinCode'];
    companyMobile = json['companyMobile'];
    companyEmail = json['companyEmail'];
    pan = json['pan'];
    cin = json['cin'];
    tan = json['tan'];
    industryType = json['industryType'];
    annualTurnover = json['annual_Turnover'];
    userID = json['id'];
    adminMobile = json['adminMobile'];
    adminEmail = json['adminEmail'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gstin'] = this.gstin;
    data['dealerName'] = this.dealerName;
    data['companyName'] = this.companyName;
    data['address'] = this.address;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pinCode'] = this.pinCode;
    data['companyMobile'] = this.companyMobile;
    data['companyEmail'] = this.companyEmail;
    data['pan'] = this.pan;
    data['cin'] = this.cin;
    data['tan'] = this.tan;
    data['industryType'] = this.industryType;
    data['annual_Turnover'] = this.annualTurnover;
    data['id'] = this.userID;
    data['adminMobile'] = this.adminMobile;
    data['admin'] = this.adminMobile;

    return data;
  }
}
