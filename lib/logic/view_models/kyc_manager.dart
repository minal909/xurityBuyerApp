import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/core/kyc_model.dart';
import 'package:xuriti/models/core/mobile_verification_model.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/models/services/dio_service.dart';

class KycManager extends ChangeNotifier {
  KycModel kycModel = KycModel();
  //AadhaarCard adhar = new AadhaarCard();

  MobileVerificationModel mobileVerificationModel = MobileVerificationModel();

  String mobile = '';
  dynamic otpReferenceId = '';
  bool? flag;
  dynamic captcha;

  var companyId = getIt<SharedPreferences>().getString('companyId');

  dynamic userID = getIt<SharedPreferences>().getString('id');

  var captchasessionId;
  Future<File?> getImage({required BuildContext context}) async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }

    return null;
    // if (image == null) {
    //   Map<String, dynamic> errorMessage = {
    //     'msg': 'Image selection failed',
    //     'status': false
    //   };
    //   return errorMessage;
    // } else {
    //   final imageTemp = File(image.path);
    //   print('camera image path ---- $imageTemp');

    //   Map<String, dynamic> successMessage = {
    //     'msg': 'Image selected successfully',
    //     'File': imageTemp,
    //     'status': true
    //   };
    //   return successMessage;
    //   // return imageTemp
    //   //     .where((element) => (element?.length ?? 0) != 0)
    //   //     .map((e) => File(e!))
    //   //     .toList();
    // }
  }

  Future<List<File?>?> selectFile(bool? flag) async {
    print('KYC MANAGER --- $companyId');

    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    print("filepath:----$result");
    if (result == null) {
      // Map<String, dynamic> errorMessage = {
      //   'msg': 'File selection failed',
      //   'status': false
      // };
      // return errorMessage;
      return null;
    } else {
      // final path = result.files.single.
      //
      return result.paths
          .where((element) => (element?.length ?? 0) != 0)
          .map((e) => File(e!))
          .toList();
    }
  }

  Future<List<File?>?> selectPdfFile(bool? flag) async {
    print('KYC MANAGER --- $companyId');

    final result =
        await FilePicker.platform.pickFiles(allowMultiple: flag ?? false);
    print("filepath:----$result");
    if (result == null) {
      // Map<String, dynamic> errorMessage = {
      //   'msg': 'File selection failed',
      //   'status': false
      // };
      // return errorMessage;
      return null;
    } else {
      // final path = result.files.single.
      //
      return result.paths
          .where((element) => (element?.length ?? 0) != 0)
          .map((e) => File(e!))
          .toList();
    }
  }

  Future uploadFile({required File? file}) async {
    if (file == null) {
      Map<String, dynamic> errorMessage = {
        'msg': 'File upload failed',
        'status': false
      };
      return errorMessage;
    } else {
      //final fileName = basename(file.path);
      //final destination = 'files/$fileName';
    }
  }

  storePanCardDetails(String panNo, {required String filePath}) async {
    dynamic panfile = filePath;
    String pan_no = panNo;
    // kycModel.panCard = filePath;
    // kycModel.panNo = panNo;
    String url = "/kyc/document-verify/pan-ocr";
    String verifyPanUrl = "/kyc/document-verify/pan";
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');

    final panNumberRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
    if ((panfile != "") &&
        pan_no.isNotEmpty &&
        pan_no != '' &&
        panNumberRegex.hasMatch(panNo)) {
      var body = new Map<String, dynamic>();
      body['company_id'] = compId;
      body['pan_number'] = pan_no;
      FormData formData = FormData.fromMap(body);

      // pan ocr
      var ocr = new Map<String, dynamic>();
      ocr['company_id'] = compId;
      ocr['pan'] = await MultipartFile.fromFile(panfile);
      FormData panocr = FormData.fromMap(ocr);

      dynamic responseData =
          await getIt<DioClient>().pan_captured_data(url, panocr, token);
      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status'] == true) {
          dynamic verifyresponseData = await getIt<DioClient>()
              .verify_pan(verifyPanUrl, formData, token);
          if (verifyresponseData['status'] == true) {
            Map<String, dynamic> successMessage = {
              'msg': 'PAN Details saved successfully',
              'error': false
            };
            return successMessage;
          } else {
            Map<String, dynamic> errorMessage = {
              'msg': 'Enter all mandatory fields',
              'error': true
            };
            return errorMessage;
          }
        } else {
          Map<String, dynamic> errorMassage = {
            'msg': 'Unable to capture data, Please try again',
            'error': true
          };
          print("error:--$errorMassage");
          return errorMassage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Unable to proceed, please try again later.',
        };
        print("error:--$errorMessage");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMassage = {
        'msg': 'Please upload PAN image and enter valid PAN number',
        'error': true
      };
      print("errorMassage:---$errorMassage");
      return errorMassage;
    }
  }

  generateAdharOtp(String? uid, String security_code) async {
    print("security_code----$security_code");
    // kycModel.uid = filePath;
    // kycModel.ownershipDocNumber = docNo;
    // kycModel.ownershipDocType = docType;
    String url = "/kyc/ekyc-verifyCaptcha";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');

    // Map<String, dynamic> data = kycModel.toJson();
    if (uid != null &&
        security_code.isNotEmpty &&
        int.tryParse(uid) != null &&
        uid.length == 12) {
      var map = new Map<String, dynamic>();

      // map['companyId'] = companyId;

      Map data = {
        'uid': uid,
        'security_code': security_code,
        'sessionId': this.captchasessionId
      };

      // FormData formData = FormData.fromMap(map);

      dynamic responseData =
          await getIt<DioClient>().aadhaar_otp(url, data, token);
      print("a otp $responseData");
      if (responseData != null && responseData.runtimeType != String) {
        print(responseData);
        if (responseData['status'] == true) {
          Map<String, dynamic> successMessage = {
            'msg': 'OTP sent to registered Mobile No.',
          };
          return successMessage;
        } else {
          Map<String, dynamic> errorMessage = {
            'msg': 'Enter all mandatory fields',
          };
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Unable to proceed, please try again later.',
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please enter valid Document number',
      };
      return errorMessage;
    }
  }

  storeOwnershipProof(String? docNo, String? docType,
      {required String filePath}) async {
    kycModel.propertyOwnership = filePath;
    kycModel.ownershipDocNumber = docNo;
    kycModel.ownershipDocType = docType;
    String url = "/entity/onboard";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');

    // Map<String, dynamic> data = kycModel.toJson();
    final allowedDocCharacters = RegExp(r'^[a-zA-Z0-9_-]*$');
    if (docNo != null &&
        docNo != '' &&
        docType != null &&
        filePath.isNotEmpty &&
        allowedDocCharacters.hasMatch(docNo)) {
      var map = new Map<String, dynamic>();

      map['companyId'] = compId;
      map['ownershipDocType'] = docType;
      map['ownershipDocNumber'] = docNo;
      map['propertyOwnership'] = await MultipartFile.fromFile(filePath);

      FormData formData = FormData.fromMap(map);

      dynamic responseData =
          await getIt<DioClient>().postFormData(url, formData, token);

      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status'] == true) {
          Map<String, dynamic> successMessage = {
            'msg': 'Details saved successfully',
            'error': false
          };
          return successMessage;
        } else {
          Map<String, dynamic> errorMessage = {
            'msg': 'Enter all mandatory fields',
            'error': true
          };
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Enter all mandatory fields',
          'error': true
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please upload Document image and enter valid Document number',
        'error': true
      };
      return errorMessage;
    }
  }

  storeAadhaarProof(
    String adhaarUID,
  ) {
    // kycModel.frontImage = filePath;
    // kycModel.backImage = filePath2;
    // kycModel.adhaarUID = adhaarUID;
  }

  storeBusinessProof(String? docNo, String? docType,
      {required String filePath}) async {
    kycModel.businessProof = filePath;
    kycModel.businessDocNumber = docNo;
    kycModel.businessDocType = docType;
    String url = "/entity/onboard";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');
    print('CompId ---------------------------------------------->$compId');
    // Map<String, dynamic> data = kycModel.toJson();
    final allowedDocCharacters = RegExp(r'^[a-zA-Z0-9_-]*$');
    if (docNo != null &&
        docNo != '' &&
        docType != null &&
        filePath.isNotEmpty &&
        allowedDocCharacters.hasMatch(docNo)) {
      var map = new Map<String, dynamic>();
      print('    1   ///////////');
      map['companyId'] = compId;
      map['businessDocType'] = docType;
      map['businessDocNumber'] = docNo;
      map['BusinessProof'] = await MultipartFile.fromFile(filePath);

      FormData formData = FormData.fromMap(map);
      print('     2  ///////////');
      dynamic responseData =
          await getIt<DioClient>().postFormData(url, formData, token);

      print('     err?//???  ///////////$responseData');

      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status'] == true) {
          print('     3  ///////////');
          Map<String, dynamic> successMessage = {
            'msg': 'Details saved successfully',
            'error': false
          };
          print("errorMassage:---non");
          return successMessage;
        } else {
          Map<String, dynamic> errorMessage = {
            'msg': 'Enter all mandatory fields',
            'error': true
          };
          print("errorMassage:---$errorMessage");
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Unable to proceed, please try again later.',
        };
        print("errorMassage:---$errorMessage");
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please upload Document image and enter valid Document number',
        'error': true
      };
      print("errorMassage:---$errorMessage");
      return errorMessage;
    }
  }

  storeAddressProof(String docNo, String docType, {required String filePath}) {
    kycModel.addressFile = filePath;
    kycModel.addressDocNumber = docNo;
    kycModel.addressDocType = docType;
  }

  storeVintageProof({required String filePath}) async {
    if (filePath == "") {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please upload image',
        'error': true
      };
      return errorMessage;
    }
    kycModel.vintageProof = filePath;
    String url = "/entity/onboard";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');

    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();

    map['companyId'] = compId;
    map['VintageProof'] = await MultipartFile.fromFile(filePath);
    FormData formData = FormData.fromMap(map);

    dynamic responseData =
        await getIt<DioClient>().postFormData(url, formData, token);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'Details saved successfully',
          'error': false
        };
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Enter all mandatory fields',
          'error': true
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      return errorMessage;
    }
  }

  storeFirmDetails({required String filePath}) async {
    if (filePath == "") {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please upload image',
        'error': true
      };
      return errorMessage;
    }
    kycModel.partnershipDetails = filePath;
    String url = "/entity/onboard";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');

    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();

    map['companyId'] = compId;
    // map['companyId'] = compId;
    map['PartnershipDetails'] = await MultipartFile.fromFile(filePath);

    FormData formData = FormData.fromMap(map);

    dynamic responseData =
        await getIt<DioClient>().postFormData(url, formData, token);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'Details saved successfully',
          'error': false
        };
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Enter all mandatory fields',
          'error': true
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      return errorMessage;
    }
  }

  storeBankDetails(
      {required List<String> bankStatementImage,
      required String password}) async {
    if (!(bankStatementImage.isNotEmpty || bankStatementImage.length <= 3)) {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please give atleast 1 pdf and not more than 3 images',
        'error': true
      };
      print("failed ");
      return errorMessage;
    }

    kycModel.bankStatementDetails = bankStatementImage;
    String url = "/entity/onboard";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();
    dynamic companyId = getIt<SharedPreferences>().getString('companyId');
    ;
    List uploadPdf = [];

    map['companyId'] = companyId;
    for (var file in bankStatementImage) {
      var multipartFile = await MultipartFile.fromFile(file,
          contentType: new MediaType('application', 'pdf'));
      uploadPdf.add(multipartFile);
    }

    map['BankStatementDetails'] = uploadPdf;

    // map['BankStatementDetails'] = await MultipartFile.fromFile(

    //     contentType: new MediaType('application', 'pdf'),);
    map['bankStatementPassword'] = password;

    FormData formData = FormData.fromMap(map);

    dynamic responseData =
        await getIt<DioClient>().postFormData(url, formData, token);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'Details saved successfully',
          'error': false
        };
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Enter all mandatory fields',
          'error': true
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      return errorMessage;
    }
  }

  chequeImages({required List<String> filePath}) async {
    if (!(filePath.isNotEmpty || filePath.length <= 3)) {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please give atleast 1 image and not more than 3 images',
        'error': true
      };
      print("failed ");
      return errorMessage;
    }
    kycModel.chequeImages = filePath;
    String url = "/entity/onboard";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');
    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();
    List uploadImages = [];
    // map['_id'] = userID;
    map['companyId'] = compId;
    map['userID'] = userID;
    int indexCounter = 0;
    // for (; indexCounter < filePath.length;) {
    //   print(filePath);
    for (var file in filePath) {
      var multipartFile = await MultipartFile.fromFile(file);
      uploadImages.add(multipartFile);
    }
    print(uploadImages);
    // }

    map["ChequeImages"] = uploadImages;

    FormData formData = FormData.fromMap(map);
    print(map);
    dynamic responseData =
        await getIt<DioClient>().postFormData(url, formData, token);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'Details saved successfully',
          'error': false
        };
        print("success ");
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Enter all mandatory fields',
          'error': true
        };
        print("failed ");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      print("failed ");
      return errorMessage;
    }
  }

  // storeBankDetails({required String bankStatementImage}) async {
  //   if (bankStatementImage == "") {
  //     Map<String, dynamic> errorMessage = {
  //       'msg': 'Please upload image',
  //       'error': true
  //     };
  //     return errorMessage;
  //   }
  //   kycModel.bankStatementDetails = bankStatementImage;
  //   String url = "/entity/onboard";
  //   print(url);
  //   String? compId = getIt<SharedPreferences>().getString('CompanyId');
  //   String? token = getIt<SharedPreferences>().getString('token');
  //   // Map<String, dynamic> data = kycModel.toJson();
  //   var map = new Map<String, dynamic>();

  //   map['companyId'] = compId;
  //   map['BankStatementDetails'] =
  //       await MultipartFile.fromFile(bankStatementImage);

  //   FormData formData = FormData.fromMap(map);

  //   dynamic responseData =
  //       await getIt<DioClient>().postFormData(url, formData, token);
  //   print('KYCMANAGER------------------------------------->$compId');
  //   if (responseData != null && responseData.runtimeType != String) {
  //     if (responseData['status'] == true) {
  //       Map<String, dynamic> successMessage = {
  //         'msg': 'Details saved successfully',
  //         'error': false
  //       };
  //       return successMessage;
  //     } else {
  //       Map<String, dynamic> errorMessage = {
  //         'msg': 'Enter all mandatory fields',
  //         'error': true
  //       };
  //       return errorMessage;
  //     }
  //   } else {
  //     Map<String, dynamic> errorMessage = {
  //       'msg': 'Unable to proceed, please try again later.',
  //     };
  //     return errorMessage;
  //   }
  // }

  storeGstDetails(
      {
      //   required List<String> gstImage,
      // required List<String> financialDetailsImage,
      required List<String> filePath,
      required List<String> filePath1}) async {
    if (filePath.isEmpty || filePath1.isEmpty) {
      Map<String, dynamic> errorMessage = {
        'msg': 'atleast 1 image is needed for both categories',
        'error': true
      };
      print("failed ");
      return errorMessage;
    }
    kycModel.financialDetails = filePath;
    kycModel.gstDetails = filePath1;
    String url = "/entity/onboard";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');
    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();
    List uploadImages = [];
    List uploadImages1 = [];
    map['_id'] = userID;
    map['companyId'] = compId;
    map['userID'] = userID;
    int indexCounter = 0;
    // for (; indexCounter < filePath.length;) {
    //   print(filePath);
    for (var file in filePath) {
      var multipartFile = await MultipartFile.fromFile(file);
      uploadImages.add(multipartFile);
    }
    for (var file in filePath1) {
      var multipartFile = await MultipartFile.fromFile(file);
      uploadImages1.add(multipartFile);
    }
    print(uploadImages);
    // }

    map["FinancialDetails"] = uploadImages;
    map["GstDetails"] = uploadImages1;

    FormData formData = FormData.fromMap(map);
    print(map);
    dynamic responseData =
        await getIt<DioClient>().postFormData(url, formData, token);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'Details saved successfully',
          'error': false
        };
        print("success ");
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Enter all mandatory fields',
          'error': true
        };
        print("failed ");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      print("failed ");
      return errorMessage;
    }
  }

  // storeFinancial_and_Details(String? companyId, File front, File back) async {
  //   String url = "/entity/onboard";
  //   String? token = getIt<SharedPreferences>().getString('token');
  //   KycModel kycModel = KycModel();
  //   //Map<String, dynamic> data = kycModel.toJson();

  //   var map = new Map<String, dynamic>();

  //   map['companyId'] = companyId;
  //   map['front'] = await MultipartFile.fromFile(front as dynamic);
  //   map['back'] = await MultipartFile.fromFile(back as dynamic);

  //   FormData formData = FormData.fromMap(map);

  //   dynamic responseData =
  //       await getIt<DioClient>().aadhaar_captured_data(url, formData, token);
  //   if (responseData != null && responseData.runtimeType != String) {
  //     if (responseData['status'] == true) {
  //       Map<String, dynamic> successMessage = {
  //         'msg': 'Details saved successfully',
  //       };
  //       return successMessage;
  //     } else {
  //       Map<String, dynamic> errorMessage = {
  //         'msg': 'Somthing wents wrong',
  //       };
  //       return errorMessage;
  //     }
  //   } else {
  //     Map<String, dynamic> errorMessage = {
  //       'msg': 'Unable to proceed, please try again later.',
  //     };
  //     return errorMessage;
  //   }
  //   // throw Exception();
  // }

  generateOTP(String mobile) async {
    if (int.tryParse(mobile) == null || mobile.length != 10) {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please enter valid 10 digit number with no special characters',
      };
      print('OTP : $errorMessage');
      return errorMessage;
    }
    String url = "/kyc/phone-verification/request-otp";
    String? token = getIt<SharedPreferences>().getString('token');
    KycModel kycModel = KycModel();
    // MobileVerificationModel mobileVerificationModel = MobileVerificationModel();
    // //Map<String, dynamic> data = kycModel.toJson();
    //  mobileVerificationModel.mobileNumber = mobile;

    Map data = {'mobile_number': mobile};
    this.mobile = mobile;

    dynamic responseData =
        await getIt<DioClient>().mobile_verfication(url, data, token);

    print('Response Data : ------> $responseData');
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        var rest = responseData["data"];
        this.otpReferenceId = rest['referenceId'];

        print('Referenece ID : ${otpReferenceId}');
        Map<String, dynamic> successMessage = {
          'msg': 'OTP send successfully',
        };
        print('OTP : $successMessage');
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Somthing went wrong',
        };
        print('OTP : $errorMessage');
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      print('OTP : $errorMessage');
      return errorMessage;
    }
  }

  verifyOTP(
    String otp,
  ) async {
    String url = "/kyc/phone-verification/verify-otp";
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');
    KycModel kycModel = KycModel();

    Map data = {
      'mobile_number': this.mobile,
      'company_id': compId,
      'otp': otp,
      'referenceId': this.otpReferenceId
    };

    dynamic responseData =
        await getIt<DioClient>().otp_verfication(url, data, token);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'OTP verified successfully',
          'error': false
        };
        print('OTP : $successMessage');
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Somthing wents wrong',
          'error': true
        };
        print('msg: $errorMessage');
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
        'error': true
      };
      print('msg: $errorMessage');
      return errorMessage;
    }
  }

  adhaarDetails(String? companyId, File frontFile, File backFile) async {
    String url = "/kyc/document-verify/aadhaar";
    String front = frontFile.path;
    String back = backFile.path;
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');
    KycModel kycModel = KycModel();
    //Map<String, dynamic> data = kycModel.toJson();

    var map = new Map<String, dynamic>();

    map['company_id'] = compId;
    map['front'] = await MultipartFile.fromFile(front);
    // await MultipartFile.fromFile(front as String);
    map['back'] = await MultipartFile.fromFile(back);
    // await MultipartFile.fromFile(back as String);
    FormData formData = FormData.fromMap(map);
    dynamic responseData =
        await getIt<DioClient>().aadhaar_captured_data(url, formData, token);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'Details saved successfully',
        };
        return responseData;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Something went wrong',
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      return errorMessage;
    }
    // throw Exception();
  }

  storeImages({required List<String> filePath}) async {
    if (!(filePath.isNotEmpty || filePath.length <= 3)) {
      Map<String, dynamic> errorMessage = {
        'msg': 'Please give atleast 1 image and not more than 3 images',
        'error': true
      };
      print("failed ");
      return errorMessage;
    }
    kycModel.storeImages = filePath;
    String url = "/entity/onboard";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');
    String? compId = getIt<SharedPreferences>().getString('companyId');
    // Map<String, dynamic> data = kycModel.toJson();
    var map = new Map<String, dynamic>();
    List uploadImages = [];
    // map['_id'] = userID;
    map['companyId'] = compId;
    map['userID'] = userID;
    int indexCounter = 0;
    // for (; indexCounter < filePath.length;) {
    //   print(filePath);
    for (var file in filePath) {
      var multipartFile = await MultipartFile.fromFile(file);
      uploadImages.add(multipartFile);
    }
    print(uploadImages);
    // }

    map["StoreImages"] = uploadImages;

    FormData formData = FormData.fromMap(map);
    print(map);
    dynamic responseData =
        await getIt<DioClient>().postFormData(url, formData, token);
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'Details saved successfully',
          'error': false
        };
        print("success ");
        return successMessage;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Enter all mandatory fields',
          'error': true
        };
        print("failed ");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      print("failed ");
      return errorMessage;
    }
  }

  getCaptcha() async {
    String url = "/kyc/ekyc-getcaptcha";
    String? token = getIt<SharedPreferences>().getString('token');
    KycModel kycModel = KycModel();
    //Map<String, dynamic> data = kycModel.toJson();

    var map = new Map<String, dynamic>();

    dynamic responseData =
        await getIt<DioClient>().getCaptcha(url, token: token);
    //adhar = responseData;
    if (responseData != null && responseData.runtimeType != String) {
      if (responseData['status'] == true) {
        print("Response Data : $responseData");
        this.captchasessionId = responseData['sessionId'];
        Map<String, dynamic> successMessage = {
          //'msg': 'cDetails saved successfully',
        };
        return responseData;
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Somthing wents wrong',
        };
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Unable to proceed, please try again later.',
      };
      return errorMessage;
    }
  }

  verifyAdharOtp(String? otp) async {
    print("OTP----$otp");

    String url = "/kyc/ekyc-verifyOtp";
    print(url);
    String? token = getIt<SharedPreferences>().getString('token');

    if (otp != null) {
      var map = new Map<String, dynamic>();

      Map data = {'otp': otp, 'sessionId': this.captchasessionId};

      dynamic responseData =
          await getIt<DioClient>().aadhaar_otp_verify(url, data, token);
      print("a otp $responseData");
      if (responseData != null && responseData.runtimeType != String) {
        if (responseData['status'] == true) {
          Map<String, dynamic> successMessage = {
            'msg': 'OTP Verified',
            'error': false
          };
          return successMessage;
        } else {
          Map<String, dynamic> errorMessage = {
            'msg': 'Enter all mandatory fields',
            'error': true
          };
          print("otp $errorMessage");
          return errorMessage;
        }
      } else {
        Map<String, dynamic> errorMessage = {
          'msg': 'Unable to proceed, please try again later.',
        };
        print("otp $errorMessage");
        return errorMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg':
            'Please capture Adhar image, enter valid Adhar number and enter otp',
        'error': true
      };
      return errorMessage;
    }
  }

  getKycSubmission() async {
    print('----------->In Get_Kyc_Submission ------------------>');
    kycModel.userID = await getIt<SharedPreferences>().getString('id');
    print('=========>${kycModel.userID}');
    kycModel.companyId =
        await getIt<SharedPreferences>().getString('companyId');

    // if (kycModel.panCard != null &&
    //     kycModel.propertyOwnership != null &&
    //     kycModel.ownershipDocNumber != null &&
    //     kycModel.businessProof != null &&
    //     kycModel.ownershipDocType != null &&
    //     kycModel.vintageProof != null &&
    //     kycModel.addressFile != null &&
    //     kycModel.gstDetails != null &&
    //     kycModel.businessDocType != null &&
    //     kycModel.businessDocNumber != null &&
    //     kycModel.addressDocNumber != null &&
    //     kycModel.businessDocType != null &&
    //     kycModel.bankStatementDetails != null &&
    //     kycModel.panNo != null &&
    //     kycModel.financialDetails != null &&
    //     kycModel.userID != null &&
    //     kycModel.companyId != null)
    if (kycModel.businessProof != null &&
        kycModel.businessDocType != null &&
        kycModel.businessDocNumber != null &&
        kycModel.userID != null &&
        kycModel.companyId != null) {
      String url = "/entity/onboard";
      print(url);
      String? token = getIt<SharedPreferences>().getString('token');
      Map<String, dynamic> data = kycModel.toJson();
      print('Data : ${data}');
      FormData formData = FormData.fromMap({
        // 'panNo': data['panNo'],
        // 'addressDocType': data['addressDocType'],
        // 'addressDocNumber': data['addressDocNumber'],
        // 'ownershipDocType': data['ownershipDocType'],
        // 'ownershipDocNumber': data['ownershipDocNumber'],
        'businessDocType': data['businessDocType'],
        'businessDocNumber': data['businessDocNumber'],

        // 'vintageProof': data['vintageProof'],
        // 'panCard': await MultipartFile.fromFile(data['panCard'],
        //     filename: 'panCard.png'),
        // 'addressFile': await MultipartFile.fromFile(data['addressFile'],
        //     filename: 'addressFile.png'),
        'BusinessProof': await MultipartFile.fromFile(data['businessProof'],
            filename: 'BusinessProof.png'),
        // 'GstDetails': await MultipartFile.fromFile(data['gstDetails'],
        //     filename: 'GstDetails.png'),
        // 'propertyOwnership': await MultipartFile.fromFile(
        //     data['propertyOwnership'],
        //     filename: 'propertyOwnership.png'),
        // 'VintageProof': await MultipartFile.fromFile(data['vintageProof'],
        //     filename: 'VintageProof.png'),
        // 'BankStatementDetails': await MultipartFile.fromFile(
        //     data['bankStatementDetails'],
        //     filename: 'BankStatementDetails.png'),
        // 'PartnershipDetails': await MultipartFile.fromFile(
        //     data['partnershipDetails'],
        //     filename: 'PartnershipDetails.png'),
        // 'FinancialDetails': await MultipartFile.fromFile(
        //     data['financialDetails'],
        //     filename: 'FinancialDetails.png'),
        // 'FinancialDetails': await MultipartFile.fromFile(
        //     data['financialDetails'],
        //     filename: 'FinancialDetails.png'),
        // 'FinancialDetails': await MultipartFile.fromFile(
        //     data['financialDetails'],
        //     filename: 'FinancialDetails.png'),
        'userID': data['userID'],
        'companyId': data['companyId']
      });
      dynamic responseData =
          await getIt<DioClient>().postFormData(url, formData, token);
      print('Form Data-->>>>---->${formData}----->>>>>---->');
      print('-->>>>---->${responseData}----->>>>>---->');
      if (responseData['status'] == true) {
        Map<String, dynamic> successMessage = {
          'msg': 'Details saved successfully',
        };
        return successMessage;
      }
    } else {
      Map<String, dynamic> errorMessage = {
        'msg': 'Enter all mandatory fields',
      };
      return errorMessage;
    }
  }
}
