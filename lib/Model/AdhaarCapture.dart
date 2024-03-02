// To parse this JSON data, do
//
//     final adhaarCapture = adhaarCaptureFromJson(jsonString);

import 'dart:convert';

AdhaarCapture adhaarCaptureFromJson(String str) =>
    AdhaarCapture.fromJson(json.decode(str));

String adhaarCaptureToJson(AdhaarCapture data) => json.encode(data.toJson());

class AdhaarCapture {
  AdhaarCapture({
    required this.status,
    required this.data,
  });

  bool status;
  Data data;

  factory AdhaarCapture.fromJson(Map<String, dynamic> json) => AdhaarCapture(
        status: json["status"] ?? false,
        data: Data.fromJson(json["data"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.uid,
    required this.vid,
    required this.name,
    required this.dob,
    required this.yob,
    required this.pincode,
    required this.address,
    required this.gender,
    required this.splitAddress,
    required this.uidHash,
    required this.summary,
    required this.validBackAndFront,
    required this.dateOfBirth,
  });

  String uid;
  String vid;
  String name;
  String dob;
  String yob;
  String pincode;
  String address;
  String gender;
  SplitAddress splitAddress;
  String uidHash;
  Summary summary;
  bool validBackAndFront;
  String dateOfBirth;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uid: json["uid"],
        vid: json["vid"],
        name: json["name"],
        dob: json["dob"],
        yob: json["yob"],
        pincode: json["pincode"],
        address: json["address"],
        gender: json["gender"],
        splitAddress: SplitAddress.fromJson(json["splitAddress"]),
        uidHash: json["uidHash"],
        summary: Summary.fromJson(json["summary"]),
        validBackAndFront: json["validBackAndFront"],
        dateOfBirth: json["dateOfBirth"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "vid": vid,
        "name": name,
        "dob": dob,
        "yob": yob,
        "pincode": pincode,
        "address": address,
        "gender": gender,
        "splitAddress": splitAddress.toJson(),
        "uidHash": uidHash,
        "summary": summary.toJson(),
        "validBackAndFront": validBackAndFront,
        "dateOfBirth": dateOfBirth,
      };
}

class SplitAddress {
  SplitAddress({
    required this.district,
    required this.state,
    required this.city,
    required this.pincode,
    required this.country,
    required this.addressLine,
  });

  List<dynamic> district;
  List<List<dynamic>> state;
  List<dynamic> city;
  String pincode;
  List<String> country;
  String addressLine;

  factory SplitAddress.fromJson(Map<String, dynamic> json) => SplitAddress(
        district: List<dynamic>.from(json["district"].map((x) => x)),
        state: List<List<dynamic>>.from(
            json["state"].map((x) => List<dynamic>.from(x.map((x) => x)))),
        city: List<dynamic>.from(json["city"].map((x) => x)),
        pincode: json["pincode"],
        country: List<String>.from(json["country"].map((x) => x)),
        addressLine: json["addressLine"],
      );

  Map<String, dynamic> toJson() => {
        "district": List<dynamic>.from(district.map((x) => x)),
        "state": List<dynamic>.from(
            state.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "city": List<dynamic>.from(city.map((x) => x)),
        "pincode": pincode,
        "country": List<dynamic>.from(country.map((x) => x)),
        "addressLine": addressLine,
      };
}

class Summary {
  Summary({
    required this.number,
    required this.name,
    required this.dob,
    required this.address,
    required this.splitAddress,
    required this.gender,
    required this.guardianName,
    required this.issueDate,
    required this.expiryDate,
    required this.dateOfBirth,
  });

  String number;
  String name;
  String dob;
  String address;
  SplitAddress splitAddress;
  String gender;
  String guardianName;
  String issueDate;
  String expiryDate;
  String dateOfBirth;

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        number: json["number"],
        name: json["name"],
        dob: json["dob"],
        address: json["address"],
        splitAddress: SplitAddress.fromJson(json["splitAddress"]),
        gender: json["gender"],
        guardianName: json["guardianName"],
        issueDate: json["issueDate"],
        expiryDate: json["expiryDate"],
        dateOfBirth: json["dateOfBirth"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "dob": dob,
        "address": address,
        "splitAddress": splitAddress.toJson(),
        "gender": gender,
        "guardianName": guardianName,
        "issueDate": issueDate,
        "expiryDate": expiryDate,
        "dateOfBirth": dateOfBirth,
      };
}
