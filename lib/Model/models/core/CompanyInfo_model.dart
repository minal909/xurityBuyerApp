class CompanyInfo {
  Company? company;
  bool? status;
  String? code;

  CompanyInfo({this.company, this.status, this.code});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}

class Company {
  String? gstin;
  String? companyName;
  String? address;
  String? district;
  List<String>? state;
  String? pinCode;
  String? adminMobile;
  String? adminEmail;
  String? pan;
  String? cin;
  String? tan;

  Company(
      {this.gstin,
      this.companyName,
      this.address,
      this.district,
      this.state,
      this.pinCode,
      this.adminMobile,
      this.adminEmail,
      this.pan,
      this.cin,
      this.tan});

  Company.fromJson(Map<String, dynamic> json) {
    gstin = json['gstin'];

    companyName = json['companyName'];
    address = json['address'];

    district = json['district'];

    if (json['state'] is List) {
      state = json['state'].cast<String>();
    } else {
      state = ["", ""];
    }

    pinCode = json['pinCode'];
    adminMobile = json['admin_mobile'];
    adminEmail = json['admin_email'];
    pan = json['pan'];
    cin = json['cin'];
    tan = json['tan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gstin'] = this.gstin;
    data['companyName'] = this.companyName;
    data['address'] = this.address;
    data['district'] = this.district;
    data['state'] = this.state;
    data['pinCode'] = this.pinCode;
    data['admin_mobile'] = this.adminMobile;
    data['admin_email'] = this.adminEmail;
    data['pan'] = this.pan;
    data['cin'] = this.cin;
    data['tan'] = this.tan;
    return data;
  }
}

class CompanyInfoV2 {
  Company? company;
  bool? status;
  int? code;

  CompanyInfoV2({this.company, this.status, this.code});

  CompanyInfoV2.fromJson(Map<String, dynamic> json) {
    company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
    status = json['status'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }
}

class CompanyV2 {
  String? gstin;
  String? companyName;
  bool? defaultFlag;
  String? uid;

  String? adminMobile;
  String? adminEmail;
  String? pan;

  CompanyV2({
    this.gstin,
    this.companyName,
    this.uid,
    this.defaultFlag,
    this.adminMobile,
    this.adminEmail,
    this.pan,
  });

  CompanyV2.fromJson(Map<String, dynamic> json) {
    gstin = json['gstin'];
    uid = json['userID'];
    pan = json['pan'];
    defaultFlag = json['consent_gst_defaultFlag'];
    companyName = json['companyName'];

    adminMobile = json['admin_mobile'];
    adminEmail = json['admin_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gstin'] = this.gstin;
    data['companyName'] = this.companyName;
    data['consent_gst_defaultFlag'] = this.defaultFlag;
    data['userID'] = this.uid;

    data['admin_mobile'] = this.adminMobile;
    data['admin_email'] = this.adminEmail;
    data['pan'] = this.pan;

    return data;
  }
}
