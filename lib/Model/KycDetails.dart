// To parse this JSON data, do
//
//     final KYCDetails = KYCDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

KYCDetails KYCDetailsFromJson(String str) =>
    KYCDetails.fromJson(json.decode(str));

String KYCDetailsToJson(KYCDetails data) => json.encode(data.toJson());

class KYCDetails {
  KYCDetails({
    required this.data,
    required this.status,
  });

  Data data;
  bool status;

  factory KYCDetails.fromJson(Map<String, dynamic> json) => KYCDetails(
        data: Data.fromJson(json["data"]),
        status: json["status"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
      };
}

class Data {
  Data({
    required this.pan,
    required this.aadhar,
    required this.mobile,
    required this.faceMatch,
    required this.address,
    required this.bankStatement,
    required this.business,
    required this.financial,
    required this.gst,
    required this.ownership,
    required this.partnership,
    required this.vintage,
    required this.storeImages,
  });

  Pan pan;
  Aadhar aadhar;
  Mobile mobile;
  FaceMatch faceMatch;
  Address address;
  Banking bankStatement;
  Business business;
  Financial financial;
  Gst gst;
  Business ownership;
  Partnership partnership;
  Vintage vintage;
  StoreImage storeImages;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pan: Pan.fromJson(json["pan"] ?? ""),
        aadhar: Aadhar.fromJson(json["aadhar"] ?? ""),
        mobile: Mobile.fromJson(json["mobile"] ?? ""),
        faceMatch: FaceMatch.fromJson(json["faceMatch"] ?? ""),
        address: Address.fromJson(json["address"] ?? ""),
        bankStatement: Banking.fromJson(json["bankStatement"] ?? ""),
        business: Business.fromJson(json["business"] ?? ""),
        financial: Financial.fromJson(json["financial"] ?? ""),
        gst: Gst.fromJson(json["gst"] ?? ""),
        ownership: Business.fromJson(json["ownership"] ?? ""),
        partnership: Partnership.fromJson(json["partnership"] ?? ""),
        vintage: Vintage.fromJson(json["vintage"] ?? ""),
        storeImages: StoreImage.fromJson(json["storeImages"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "pan": pan.toJson(),
        "aadhar": aadhar.toJson(),
        "mobile": mobile.toJson(),
        "faceMatch": faceMatch.toJson(),
        "address": address.toJson(),
        "bankStatement": bankStatement.toJson(),
        "business": business.toJson(),
        "financial": financial.toJson(),
        "gst": gst.toJson(),
        "ownership": ownership.toJson(),
        "partnership": partnership.toJson(),
        "vintage": vintage.toJson(),
        "storeImages": storeImages.toJson(),
      };
}

class KycStatus {
  KycStatus({
    required this.panStatus,
    required this.aadharStatus,
    required this.mobileStatus,
    required this.faceMatchStatus,
    required this.addressStatus,
    required this.bankStatementStatus,
    required this.businessStatus,
    required this.financialStatus,
    required this.gstStatus,
    required this.ownershipStatus,
    required this.partnershipStatus,
    required this.vintageStatus,
    required this.storeImagesStatus,
  });

  String panStatus;
  String aadharStatus;
  String mobileStatus;
  String faceMatchStatus;
  String addressStatus;
  String bankStatementStatus;
  String businessStatus;
  String financialStatus;
  String gstStatus;
  String ownershipStatus;
  String partnershipStatus;
  String vintageStatus;
  String storeImagesStatus;

  factory KycStatus.fromJson(Map<String, dynamic> json) => KycStatus(
        panStatus: json['pan']?['status'] ?? 'Unknown', //'Pending',
        aadharStatus: json['aadhar']?['status'] ?? 'Unknown', //'Pending',
        mobileStatus: json['mobile']?['status'] ?? 'Unknown', //'Pending',
        faceMatchStatus: json['faceMatch']?['status'] ?? 'Unknown', //'Pending',
        addressStatus: json['address']?['status'] ?? 'Unknown', //'Pending',
        bankStatementStatus:
            json['bankStatement']?['status'] ?? 'Unknown', //'Pending',
        businessStatus: json['business']?['status'] ?? 'Unknown', //'Pending',
        financialStatus: json['financial']?['status'] ?? 'Unknown', //'Pending',
        gstStatus: json['gst']?['status'] ?? 'Unknown', //'Pending',
        ownershipStatus: json['ownership']?['status'] ?? 'Unknown', //'Pending',
        partnershipStatus:
            json['partnership']?['status'] ?? 'Unknown', //'Pending',
        vintageStatus: json['vintage']?['status'] ?? 'Unknown', //'Pending',
        storeImagesStatus:
            json['storeImages']?['status'] ?? 'Unknown', //'Pending',
      );

  static Widget kycStatusToIcon(String? status) {
    switch (status) {
      case 'In-Progress':
        {
          return const Icon(
            Icons.access_time_filled,
            color: Colors.yellow,
          );
        }
      case 'Approved':
        {
          return const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
          );
        }
      case 'Rejected':
        {
          return const Icon(
            Icons.remove_circle,
            color: Colors.red,
          );
        }
      default:
        {
          print('unknown status of kyc');
          return const Icon(
            Icons.circle_outlined,
            color: Colors.black,
          );
        }
    }
  }

  static bool isKycStatusVerified(KycStatus? status) {
    if (status == null) {
      return false;
    } else if (status.panStatus == 'Approved' &&
        status.aadharStatus == 'Approved' &&
        status.mobileStatus == 'Approved' &&
        status.bankStatementStatus == 'Approved' &&
        status.businessStatus == 'Approved' &&
        status.financialStatus == 'Approved' &&
        status.gstStatus == 'Approved' &&
        status.ownershipStatus == 'Approved' &&
        status.partnershipStatus == 'Approved' &&
        status.vintageStatus == 'Approved' &&
        status.storeImagesStatus == 'Approved') {
      return true;
    } else {
      return false;
    }
  }

  Map<String, dynamic> toJson() => {
        "pan": panStatus,
        "aadhar": aadharStatus,
        "mobile": mobileStatus,
        "faceMatch": faceMatchStatus,

        ///check if needed
        "address": addressStatus,

        ///check if needed
        "bankStatement": bankStatementStatus,
        "business": businessStatus,
        "financial": financialStatus,
        "gst": gstStatus,
        "ownership": ownershipStatus,
        "partnership": partnershipStatus,
        "vintage": vintageStatus,
        "storeImages": storeImagesStatus,
      };
}

class Aadhar {
  Aadhar({
    required this.verified,
    required this.status,
    required this.comment,
    required this.holder,
    required this.number,
    required this.address,
    required this.dob,
    required this.gender,
    required this.files,
  });

  bool verified;
  String status;
  String comment;
  String holder;
  String number;
  String address;
  String dob;
  String gender;
  List<String> files;

  factory Aadhar.fromJson(Map<String, dynamic> json) => Aadhar(
        verified: json["verified"] ?? "",
        status: json["status"] ?? "",
        comment: json["comment"] ?? "",
        holder: json["holder"] ?? "",
        number: json["number"] ?? "",
        address: json["address"] ?? "",
        dob: json["dob"] ?? "",
        gender: json["gender"] ?? "",
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "status": status,
        "comment": comment,
        "holder": holder,
        "number": number,
        "address": address,
        "dob": dob,
        "gender": gender,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Address {
  Address({
    required this.status,
    this.comment,
    required this.verified,
    required this.files,
  });

  String status;
  String? comment;
  bool verified;
  List<String> files;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        status: json["status"] ?? "",
        comment: json["comment"] ?? "",
        verified: json["verified"] ?? "",
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "comment": comment,
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Business {
  Business({
    required this.documentNumber,
    required this.documentType,
    required this.status,
    required this.verified,
    required this.files,
  });

  String documentNumber;
  String documentType;
  String status;
  bool verified;
  List<String> files;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
        documentNumber: json["documentNumber"] ?? "",
        documentType: json["documentType"] ?? "",
        status: json["status"] ?? "",
        verified: json["verified"] ?? false,
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "documentNumber": documentNumber,
        "documentType": documentType,
        "status": status,
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Ownership {
  Ownership({
    required this.documentNumber,
    required this.documentType,
    required this.status,
    required this.verified,
    required this.files,
  });

  String documentNumber;
  String documentType;
  String status;
  bool verified;
  List<String> files;

  factory Ownership.fromJson(Map<String, dynamic> json) => Ownership(
        documentNumber: json["documentNumber"] ?? "",
        documentType: json["documentType"] ?? "",
        status: json["status"] ?? "",
        verified: json["verified"] ?? "",
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "documentNumber": documentNumber,
        "documentType": documentType,
        "status": status,
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Partnership {
  Partnership({
    required this.status,
    required this.verified,
    required this.files,
  });

  String status;
  bool verified;
  List<String> files;

  factory Partnership.fromJson(Map<String, dynamic> json) => Partnership(
        status: json["status"] ?? "",
        verified: json["verified"] ?? false,
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Vintage {
  Vintage({
    required this.status,
    required this.verified,
    required this.files,
  });

  String status;
  bool verified;
  List<String> files;

  factory Vintage.fromJson(Map<String, dynamic> json) => Vintage(
        status: json["status"] ?? "",
        verified: json["verified"] ?? false,
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class StoreImage {
  StoreImage({
    required this.status,
    required this.verified,
    required this.files,
  });

  String status;
  bool verified;
  List<String> files;

  factory StoreImage.fromJson(Map<String, dynamic> json) => StoreImage(
        status: json["status"] ?? "",
        verified: json["verified"] ?? false,
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Banking {
  Banking({
    required this.status,
    required this.verified,
    required this.files,
  });

  String status;
  bool verified;
  List<String> files;

  factory Banking.fromJson(Map<String, dynamic> json) => Banking(
        status: json["status"] ?? "",
        verified: json["verified"] ?? false,
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Cheque {
  Cheque({
    required this.status,
    required this.verified,
    required this.files,
  });

  String status;
  bool verified;
  List<String> files;

  factory Cheque.fromJson(Map<String, dynamic> json) => Cheque(
        status: json["status"] ?? "",
        verified: json["verified"] ?? false,
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class FaceMatch {
  FaceMatch({
    required this.verified,
    required this.status,
    required this.comment,
    required this.holder,
    required this.matchPercentage,
    required this.message,
    required this.dob,
    required this.files,
  });

  String verified;
  String status;
  String comment;
  String holder;
  String matchPercentage;
  String message;
  String dob;
  List<String> files;

  factory FaceMatch.fromJson(Map<String, dynamic> json) => FaceMatch(
        verified: json["verified"] ?? "",
        status: json["status"] ?? "",
        comment: json["comment"] ?? "",
        holder: json["holder"] ?? "",
        matchPercentage: json["matchPercentage"],
        message: json["message"] ?? "",
        dob: json["dob"] ?? "",
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "status": status,
        "comment": comment,
        "holder": holder,
        "matchPercentage": matchPercentage,
        "message": message,
        "dob": dob,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Financial {
  Financial({
    required this.verified,
    required this.files,
  });

  bool verified;
  List<String> files;

  factory Financial.fromJson(Map<String, dynamic> json) => Financial(
        verified: json["verified"] ?? false,
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Gst {
  Gst({
    required this.verified,
    required this.files,
  });

  bool verified;
  List<String> files;

  factory Gst.fromJson(Map<String, dynamic> json) => Gst(
        verified: json["verified"] ?? false,
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}

class Mobile {
  Mobile({
    required this.verified,
    required this.status,
    required this.comment,
    required this.number,
    required this.countryCode,
    required this.holder,
    required this.address,
    required this.email,
  });

  bool verified;
  String status;
  String comment;
  String number;
  String countryCode;
  String holder;
  String address;
  String email;

  factory Mobile.fromJson(Map<String, dynamic> json) => Mobile(
        verified: json["verified"] ?? "",
        status: json["status"] ?? "",
        comment: json["comment"] ?? "",
        number: json["number"] ?? "",
        countryCode: json["countryCode"] ?? "",
        holder: json["holder"] ?? "",
        address: json["address"] ?? "",
        email: json["email"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "status": status,
        "comment": comment,
        "number": number,
        "countryCode": countryCode,
        "holder": holder,
        "address": address,
        "email": email,
      };
}

class Pan {
  Pan({
    required this.verified,
    required this.status,
    required this.comment,
    required this.holder,
    required this.number,
    required this.files,
  });

  bool verified;
  String status;
  String comment;
  String holder;
  String number;
  List<String> files;

  factory Pan.fromJson(Map<String, dynamic> json) => Pan(
        verified: json["verified"] ?? "",
        status: json["status"] ?? "",
        comment: json["comment"] ?? "",
        holder: json["holder"] ?? "",
        number: json["number"] ?? "",
        files: List<String>.from(json["files"]?.map((x) => x) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "verified": verified,
        "status": status,
        "comment": comment,
        "holder": holder,
        "number": number,
        "files": List<dynamic>.from(files.map((x) => x)),
      };
}
