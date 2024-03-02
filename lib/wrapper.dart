import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/logic/view_models/auth_manager.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/screens/starting_screens/company_list.dart';
import 'package:xuriti/ui/screens/starting_screens/company_register_screen.dart';

import 'logic/view_models/transaction_manager.dart';
import 'models/core/get_company_list_model.dart';
import 'models/helper/service_locator.dart';

class OktWrapper extends StatefulWidget {
  const OktWrapper({Key? key}) : super(key: key);

  @override
  State<OktWrapper> createState() => _OktWrapperState();
}

class _OktWrapperState extends State<OktWrapper> {
  bool isLoading = true;
  bool isSuccess = false;
  bool isSessionExpired = false;

  @override
  void didChangeDependencies() async {
    String? id = await getIt<SharedPreferences>().getString("id");
    String? token = await getIt<SharedPreferences>().getString("token");

    List<GetCompany> clist = await getIt<TransactionManager>().getCompanyList(
      id,
      token,
      context,
      (bool value) {
        isSessionExpired = value;
      },
    );

    if (isSessionExpired) {
      await getIt<AuthManager>().logOut();
      getIt<SharedPreferences>().clear();
      await getIt<SharedPreferences>().setString('onboardViewed', 'true');

      Navigator.pushNamed(context, getStarted);
      Fluttertoast.showToast(
          webPosition: "center", msg: "Session Timeout, please try again");
    } else {
      if (clist.length > 0) {
        isLoading = false;
        isSuccess = false;
        Navigator.pushNamedAndRemoveUntil(
            context, companyList, (Route<dynamic> route) => false);
      } else {
        isLoading = false;
        isSuccess = true;
        Navigator.pushNamedAndRemoveUntil(
            context, companyRegisterScreen, (Route<dynamic> route) => false);
      }
    }

    // UserDetails? user = getIt<AuthManager>().userDetails;
    // // if (user != null) {
    //   String? userId = user.user!.sId;
    //   String? token = user.token;
    //   // var company =
    //       // await getIt<AuthManager>().fetchCompanyDetails(userId, token);
    //   if (company == null || company == "failed") {
    //     isLoading = false;
    //     isSuccess = false;
    //     Navigator.pushNamed(context, businessRegister);
    //   } else {
    //     isLoading = false;
    //     isSuccess = true;
    //     Navigator.pushNamed(context, landing);
    //   }
    // }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoading == true)
        ? Center()
        : (isSuccess == true)
            ? CompanyList()
            : CompanyRegisterScreen();
  }
}
