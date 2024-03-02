// class CreditLimit {
//   bool? status;
//   Company? company;
//
//   CreditLimit({this.status, this.company});
//
//   CreditLimit.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     company =
//     json['company'] != null ? new Company.fromJson(json['company']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     if (this.company != null) {
//       data['company'] = this.company!.toJson();
//     }
//     return data;
//   }
// }
//
// class Company {
//   String? sId;
//   String? gstin;
//   String? companyName;
//   String? address;
//   String? district;
//   String? state;
//   int? pincode;
//   int? companyMobile;
//   String? companyEmail;
//   String? pan;
//   String? cin;
//   String? tan;
//   String? status;
//   CreatedBy? createdBy;
//   String? createdAt;
//   String? updatedAt;
//   String? adminMobile;
//   String? adminEmail;
//   String? adminName;
//   String? creditLimit;
//   String? availCredit;
//   String? optimizecredit;
//   int? iV;
//   String? presignedurl;
//
//   Company(
//       {this.sId,
//         this.gstin,
//         this.companyName,
//         this.address,
//         this.district,
//         this.state,
//         this.pincode,
//         this.companyMobile,
//         this.companyEmail,
//         this.pan,
//         this.cin,
//         this.tan,
//         this.status,
//         this.createdBy,
//         this.createdAt,
//         this.updatedAt,
//         this.adminMobile,
//         this.adminEmail,
//         this.adminName,
//         this.creditLimit,
//         this.availCredit,
//         this.optimizecredit,
//         this.iV,
//         this.presignedurl});
//
//   Company.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     gstin = json['gstin'];
//     companyName = json['company_name'];
//     address = json['address'];
//     district = json['district'];
//     state = json['state'];
//     pincode = json['pincode'];
//     companyMobile = json['company_mobile'];
//     companyEmail = json['company_email'];
//     pan = json['pan'];
//     cin = json['cin'];
//     tan = json['tan'];
//     status = json['status'];
//     createdBy = json['createdBy'] != null
//         ? new CreatedBy.fromJson(json['createdBy'])
//         : null;
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     adminMobile = json['admin_mobile'];
//     adminEmail = json['admin_email'];
//     adminName = json['admin_name'];
//     creditLimit = json['creditLimit'];
//     availCredit = json['avail_credit'];
//     optimizecredit = json['optimizecredit'];
//     iV = json['__v'];
//     presignedurl = json['presignedurl'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['gstin'] = this.gstin;
//     data['company_name'] = this.companyName;
//     data['address'] = this.address;
//     data['district'] = this.district;
//     data['state'] = this.state;
//     data['pincode'] = this.pincode;
//     data['company_mobile'] = this.companyMobile;
//     data['company_email'] = this.companyEmail;
//     data['pan'] = this.pan;
//     data['cin'] = this.cin;
//     data['tan'] = this.tan;
//     data['status'] = this.status;
//     if (this.createdBy != null) {
//       data['createdBy'] = this.createdBy!.toJson();
//     }
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['admin_mobile'] = this.adminMobile;
//     data['admin_email'] = this.adminEmail;
//     data['admin_name'] = this.adminName;
//     data['creditLimit'] = this.creditLimit;
//     data['avail_credit'] = this.availCredit;
//     data['optimizecredit'] = this.optimizecredit;
//     data['__v'] = this.iV;
//     data['presignedurl'] = this.presignedurl;
//     return data;
//   }
// }
//
// class CreatedBy {
//   String? sId;
//   String? name;
//   String? email;
//   String? password;
//   int? mobileNumber;
//   String? gid;
//   String? referralCode;
//   String? firstName;
//   String? lastName;
//   String? userRole;
//   String? profilePic;
//   String? status;
//   bool? active;
//   bool? softDelete;
//   bool? flag;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//   CreatedBy(
//       {this.sId,
//         this.name,
//         this.email,
//         this.password,
//         this.mobileNumber,
//         this.gid,
//         this.referralCode,
//         this.firstName,
//         this.lastName,
//         this.userRole,
//         this.profilePic,
//         this.status,
//         this.active,
//         this.softDelete,
//         this.flag,
//         this.createdAt,
//         this.updatedAt,
//         this.iV});
//
//   CreatedBy.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     mobileNumber = json['mobile_number'];
//     gid = json['gid'];
//     referralCode = json['referral_code'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     userRole = json['user_role'];
//     profilePic = json['profile_pic'];
//     status = json['status'];
//     active = json['active'];
//     softDelete = json['soft_delete'];
//     flag = json['flag'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['mobile_number'] = this.mobileNumber;
//     data['gid'] = this.gid;
//     data['referral_code'] = this.referralCode;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['user_role'] = this.userRole;
//     data['profile_pic'] = this.profilePic;
//     data['status'] = this.status;
//     data['active'] = this.active;
//     data['soft_delete'] = this.softDelete;
//     data['flag'] = this.flag;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
