import 'package:flutter/material.dart';

extension LoaderContext on BuildContext {
  void showLoader() {
    showDialog(
        barrierDismissible: false,
        context: this,
        builder: (dialogContext) {
          return Center(
            child: Container(
              // height: MediaQuery.of(this).size.height * 0.1,
              // width: MediaQuery.of(this).size.width * 0.2,
              // decoration: BoxDecoration(
              //   color: Colors.transparent.withOpacity(0.5),
              //   borderRadius: BorderRadius.circular(15),
              //   border: Border(
              //     left: BorderSide(
              //       color: Color.fromARGB(255, 2, 5, 2),
              //     ),
              //     right: BorderSide(
              //       color: Color.fromARGB(255, 2, 5, 2),
              //     ),
              //     top: BorderSide(
              //       color: Color.fromARGB(255, 2, 5, 2),
              //     ),
              //     bottom: BorderSide(
              //       color: Color.fromARGB(255, 2, 5, 2),
              //     ),
              //   ),
              // ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  "assets/images/loaderxuriti-unscreen.gif",
                  height: 70,

                  // "assets/images/Spinner-3-unscreen.gif",
                  //color: Colors.orange,
                ),
              ),
            ),
          );
          // Scaffold(
          //     backgroundColor: Colors.black,
          //     body: Center(
          //       child: CircularProgressIndicator(color: Colors.white),
          //     ));  avishek.singh@xuriti.com
        });
  }

  Widget getLoaderWidget() {
    return Center(
      child: Container(
        // height: MediaQuery.of(this).size.height * 0.1,
        // width: MediaQuery.of(this).size.width * 0.2,
        // decoration: BoxDecoration(
        //   color: Colors.transparent.withOpacity(0.5),
        //   borderRadius: BorderRadius.circular(15),
        //   border: Border(
        //     left: BorderSide(
        //       color: Color.fromARGB(255, 2, 5, 2),
        //     ),
        //     right: BorderSide(
        //       color: Color.fromARGB(255, 2, 5, 2),
        //     ),
        //     top: BorderSide(
        //       color: Color.fromARGB(255, 2, 5, 2),
        //     ),
        //     bottom: BorderSide(
        //       color: Color.fromARGB(255, 2, 5, 2),
        //     ),
        //   ),
        // ),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Image.asset("assets/images/loaderxuriti-unscreen.gif",
                height: 70

                // "assets/images/Spinner-3-unscreen.gif",
                //color: Colors.orange,
                )),
      ),
    );
  }

  void hideLoader() {
    Navigator.pop(this);
  }
}
