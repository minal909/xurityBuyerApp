// import 'package:xuriti/models/core/user_details.dart';
//
// import 'credit_limit_model.dart';
//
// class UserInformation {
//   String? userId;
//   String? userName;
//   String? userEmail;
//   String? userPassword;
//   String? userMobileNumber;
//   String? gid;
//   String? firstName;
//   String? lastName;
//   String? userRole;
//   String? profilePic;
//   String? companyId;
//   String? companyGstNo;
//   String? companyName;
//   String? companyAddress;
//   String? companyDistrict;
//   String? companyState;
//   int? companyPincode;
//   int? companyMobile;
//   String? companyEmail;
//   String? pan;
//   String? cin;
//   String? tan;
//   String? companyStatus;
//   String? creditLimit;
//   String? availCredit;
//   String? optimizecredit;
//   String? presignedurl;
//
//   UserInformation({
//     this.userId,
//     this.userName,
//     this.userEmail,
//     this.userPassword,
//     this.userMobileNumber,
//     this.gid,
//     this.firstName,
//     this.lastName,
//     this.userRole,
//     this.profilePic,
//     this.companyId,
//     this.companyGstNo,
//     this.companyName,
//     this.companyAddress,
//     this.companyDistrict,
//     this.companyState,
//     this.companyPincode,
//     this.companyMobile,
//     this.companyEmail,
//     this.pan,
//     this.cin,
//     this.tan,
//     this.companyStatus,
//     this.creditLimit,
//     this.availCredit,
//     this.optimizecredit,
//     this.presignedurl,
//   });
//
//   UserInformation.fromJson(Map<String, dynamic> data) {
//     userId = data['userId'];
//     userName = data['userName'];
//     userEmail = data['userEmail'];
//     userPassword = data['userPassword'];
//     userMobileNumber = data['userMobileNumber'];
//     gid = data['gid'];
//     firstName = data['firstName'];
//     lastName = data['lastName'];
//     userRole = data['userRole'];
//     profilePic = data['profilePic'];
//     companyId = data['companyId'];
//     companyGstNo = data['companyGstNo'];
//     companyName = data['companyName'];
//     companyAddress = data['companyAddress'];
//     companyDistrict = data['companyDistrict'];
//     companyState = data['companyState'];
//     companyPincode = data['companyPincode'];
//     companyMobile = data['companyMobile'];
//     companyEmail = data['companyEmail'];
//     pan = data['pan'];
//     cin = data['cin'];
//     tan = data['tan'];
//     companyStatus = data['companyStatus'];
//     creditLimit = data['creditLimit'];
//     availCredit = data['availCredit'];
//     optimizecredit = data['optimizecredit'];
//     presignedurl = data['presignedurl'];
//   }
//
//   UserInformation.fromUserDetails(User? user, Company? company){
//     userId = user!.sId;
//     userName = user.name;
//     userEmail = user.email;
//     userPassword = user.password;
//     userMobileNumber = user.mobileNumber;
//     gid = user.gid;
//     firstName = user.firstName;
//     lastName = user.lastName;
//     userRole = user.userRole;
//     profilePic = user.profilePic;
//     if(company!=null){
//       companyId = company.sId;
//       companyGstNo =company.gstin ;
//       companyName =company.companyName ;
//       companyAddress =company.address;
//       companyDistrict = company.district;
//       companyState = company.state;
//       companyPincode =company.pincode ;
//       companyMobile =company.companyMobile ;
//       companyEmail = company.companyEmail;
//       pan = company.pan;
//       cin =company.cin;
//       tan = company.tan;
//       companyStatus = company.status;
//       creditLimit = company.creditLimit;
//       // availCredit =company.availCredit;
//       optimizecredit = company.optimizecredit;
//       presignedurl =company.presignedurl;
//     }
//
//   }
//
//   UserInformation.fromCompanyDetails(Company company){
//     companyId = company.sId;
//     companyGstNo =company.gstin ;
//     companyName =company.companyName ;
//     companyAddress =company.address;
//     companyDistrict = company.district;
//     companyState = company.state;
//     companyPincode =company.pincode ;
//     companyMobile =company.companyMobile ;
//     companyEmail = company.companyEmail;
//     pan = company.pan;
//     cin =company.cin;
//     tan = company.tan;
//     companyStatus = company.status;
//     creditLimit = company.creditLimit;
//     // availCredit =company.availCredit;
//     optimizecredit = company.optimizecredit;
//     presignedurl =company.presignedurl;
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId']=this.userId;
//     data['userName']=this.userName;
//     data['userEmail']=this.userEmail;
//     data['userPassword']=this.userPassword;
//     data['userMobileNumber']=this.userMobileNumber;
//     data['gid']=this.gid;
//     data['firstName']=this.firstName;
//     data['lastName']=this.lastName;
//     data['userRole']=this.userRole;
//     data['profilePic']=this.profilePic;
//     data['companyId']=this.companyId;
//     data['companyGstNo']=this.companyGstNo;
//     data['companyName']=this.companyName;
//     data['companyAddress']=this.companyAddress;
//     data['companyDistrict']=this.companyDistrict;
//     data['companyState']=this.companyState;
//     data['companyPincode']=this.companyPincode;
//     data['companyMobile']=this.companyMobile;
//     data['companyEmail']=this.companyEmail;
//     data['pan']=this.pan;
//     data['cin']=this.cin;
//     data['tan']=this.tan;
//     data['companyStatus']=this.companyStatus;
//     data['creditLimit']=this.creditLimit;
//     data['availCredit']=this.availCredit;
//     data['optimizecredit']=this.optimizecredit;
//     data['presignedurl']=this.presignedurl;
//     return data;
//   }
// }
