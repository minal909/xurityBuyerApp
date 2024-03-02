class KycModel {
  String? panNo; //a
  String? addressDocType; //a
  String? addressDocNumber; //a
  String? ownershipDocType;
  String? ownershipDocNumber;
  String? businessDocType; //a
  String? businessDocNumber; //a
  String? vintageProof; //a
  String? panCard; //a
  String? addressFile; //a
  String? businessProof;
  List<String>? gstDetails; //a
  String? propertyOwnership;
 List<String> ? bankStatementDetails; //a
  String? partnershipDetails; //a
  List<String>? financialDetails;
  String? userID;
  String? companyId;
  List<String>? storeImages;
  List<String>? chequeImages;

  KycModel(
      {this.panNo,
      this.addressDocType,
      this.addressDocNumber,
      this.ownershipDocType,
      this.ownershipDocNumber,
      this.businessDocType,
      this.businessDocNumber,
      this.vintageProof,
      this.panCard,
      this.addressFile,
      this.businessProof,
      this.gstDetails,
      this.propertyOwnership,
     this.bankStatementDetails,
      this.partnershipDetails,
      this.financialDetails,
      this.userID,
      this.companyId,
      this.storeImages,
      this.chequeImages});

  KycModel.fromJson(Map<String, dynamic> json) {
    panNo = json['panNo'];
    addressDocType = json['addressDocType'];
    addressDocNumber = json['addressDocNumber'];
    ownershipDocType = json['ownershipDocType'];
    ownershipDocNumber = json['ownershipDocNumber'];
    businessDocType = json['businessDocType'];
    businessDocNumber = json['businessDocNumber'];
    vintageProof = json['vintageProof'];
    panCard = json['panCard'];
    addressFile = json['addressFile'];
    businessProof = json['businessProof'].toString();
    gstDetails = json['gstDetails'];
    propertyOwnership = json['propertyOwnership'];
    bankStatementDetails = json['bankStatementDetails'];
    partnershipDetails = json['partnershipDetails'];
    financialDetails = json['financialDetails'];
    userID = json['userID'];
    companyId = json['companyId'];
    storeImages = json['storeImages'];
    chequeImages = json['chequeImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['panNo'] = this.panNo;
    data['addressDocType'] = this.addressDocType;
    data['addressDocNumber'] = this.addressDocNumber;
    data['ownershipDocType'] = this.ownershipDocType;
    data['ownershipDocNumber'] = this.ownershipDocNumber;
    data['businessDocType'] = this.businessDocType;
    data['businessDocNumber'] = this.businessDocNumber;
    data['vintageProof'] = this.vintageProof;
    data['panCard'] = this.panCard;
    data['addressFile'] = this.addressFile;
    data['businessProof'] = this.businessProof;
    data['gstDetails'] = this.gstDetails;
    data['propertyOwnership'] = this.propertyOwnership;
    data['bankStatementDetails'] = this.bankStatementDetails;
    data['partnershipDetails'] = this.partnershipDetails;
    data['financialDetails'] = this.financialDetails;
    data['userID'] = this.userID;
    data['companyId'] = this.companyId;
    data['storeImages'] = this.storeImages;
    data['chequeImages'] = this.chequeImages;
    return data;
  }
}
