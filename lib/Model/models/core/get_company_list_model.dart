import 'package:flutter/material.dart';

class GetCompanyList {
  bool? status;
  List<GetCompany>? company;

  GetCompanyList({this.status, this.company});

  GetCompanyList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['company'] != null) {
      company = <GetCompany>[];
      json['company'].forEach((v) {
        company!.add(new GetCompany.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   if (this.company != null) {
  //     data['company'] = this.company!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class GetCompany {
  String? sId;
  String? user;
  int? iV;
  CompanyDetails? companyDetails;
  String? userRole;

  GetCompany(
      {this.sId, this.user, this.iV, this.companyDetails, this.userRole});

  GetCompany.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    iV = json['__v'];
    companyDetails = json['company'] != null
        ? new CompanyDetails.fromJson(json['company'])
        : null;
    userRole = json['userRole'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['_id'] = this.sId;
  //   data['user'] = this.user;
  //   data['__v'] = this.iV;
  //   if (this.companyDetails != null) {
  //     data['company'] = this.companyDetails!.toJson();
  //   }
  //   data['userRole'] = this.userRole;
  //   return data;
  // }
}

class CompanyDetails {
  bool? kyc;
  //String? kyc;
  bool? kycDocumentUpload;
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
  int? iV;
  String? presignedurl;

  CompanyDetails(
      {this.kyc,
      this.kycDocumentUpload,
      this.sId,
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
      this.iV,
      this.presignedurl});

  CompanyDetails.fromJson(Map<String, dynamic> json) {
    kyc = json['kyc'];
    kycDocumentUpload = json['kyc_document_upload'];
    sId = json['_id'];
    gstin = json['gstin'];
    companyName = json['company_name'];
    address = json['address'];
    district = json['district'];
    state = json['state'];
    pincode = json['pincode'];
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
    creditLimit = json['creditLimit'].toString();
    availCredit = json['avail_credit'].toString();
    // optimizecredit = json['optimizecredit'];
    iV = json['__v'];
    presignedurl = json['presignedurl'];
  }

  static Widget companyStatusToIcon(String? status) {
    switch (status) {
      case 'In-Progress':
        {
          return Center(
            child: const Icon(
              Icons.rounded_corner_outlined,
              color: Colors.yellow,
            ),
          );
        }
      case 'Approved':
        {
          return Center(
            child: const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
            ),
          );
        }
      case 'Rejected':
        {
          return Center(
            child: const Icon(
              Icons.cancel_rounded,
              color: Colors.red,
            ),
          );
        }
      case 'Inactive':
        {
          return Center(
            child: const Icon(
              Icons.remove_circle,
              color: Colors.red,
            ),
          );
        }
      case 'Hold':
        {
          return Center(
            child: const Icon(
              Icons.access_time_filled,
              color: Colors.orange,
            ),
          );
        }
      default:
        {
          print('unknown status of kyc');
          return Center(
            child: const Icon(
              Icons.circle_outlined,
              color: Colors.black,
            ),
          );
        }
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['kyc'] = this.kyc;
  //   data['kyc_document_upload'] = this.kycDocumentUpload;
  //   data['_id'] = this.sId;
  //   data['gstin'] = this.gstin;
  //   data['company_name'] = this.companyName;
  //   data['address'] = this.address;
  //   data['district'] = this.district;
  //   data['state'] = this.state;
  //   data['pincode'] = this.pincode;
  //   data['company_mobile'] = this.companyMobile;
  //   data['company_email'] = this.companyEmail;
  //   data['pan'] = this.pan;
  //   data['cin'] = this.cin;
  //   data['tan'] = this.tan;
  //   data['status'] = this.status;
  //   data['createdBy'] = this.createdBy;
  //   data['createdAt'] = this.createdAt;
  //   data['updatedAt'] = this.updatedAt;
  //   data['admin_mobile'] = this.adminMobile;
  //   data['admin_email'] = this.adminEmail;
  //   data['admin_name'] = this.adminName;
  //   data['creditLimit'] = this.creditLimit;
  //   data['avail_credit'] = this.availCredit;
  //   data['optimizecredit'] = this.optimizecredit;
  //   data['__v'] = this.iV;
  //   data['presignedurl'] = this.presignedurl;
  //   return data;
  // }
}
