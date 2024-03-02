import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';

class ResponseScreen extends StatelessWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pas = TextEditingController();
    TextEditingController tempd = TextEditingController();

    String? id =  getIt<SharedPreferences>().getString("id");
    String? token = getIt<SharedPreferences>().getString("token");
    String? temp = getIt<SharedPreferences>().getString("temp");

    emailController.text = id!;
    pas.text = token!;
    tempd.text = temp!;

// Map<String, dynamic> response = getIt<CompanyDetailsManager>().response;
    // String res = response.toString();
    return SafeArea(
      child: Scaffold(
      body: Center(
        child: Column(
          children: [
            TextField(
controller: emailController,
            ),
            TextField(
controller: pas,
            ),
            SizedBox(height: 50,),
            TextField(
              controller: tempd,
            ),

          ],
        ),
      ),
      ),
    );
  }
}
