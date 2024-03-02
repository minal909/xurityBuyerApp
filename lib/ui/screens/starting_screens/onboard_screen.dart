import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xuriti/models/helper/service_locator.dart';
import 'package:xuriti/ui/routes/router.dart';
import 'package:xuriti/ui/theme/constants.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Container DotBuild({required Color color}) {
      return Container(
        margin: const EdgeInsets.all(3),
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
      );
    }

    List<String> text1 = [
      "“The question is not what you look at,\nbut what you see.”",
      "beautiful handpicked collection lines \nAquaculture made easy",
      "“The question is not what you look at,\nbut what you see.”"
    ];
    List<String> images = [
      "assets/images/onboard-image-1.png",
      "assets/images/onboard-image-2.png",
      "assets/images/onboard-image-3.png"
    ];

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, getStarted);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset("assets/images/xuriti-logo.png"),
                ),
              )
            ]),
        body: Stack(
          children: [
            Positioned(
              bottom: h10p * 4,
              child: currentIndex == 0
                  ? CenterWidgetOne()
                  : currentIndex == 1
                      ? CenterWidgetTwo()
                      : CenterWidgetThree(),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25))),
                  width: maxWidth,
                  height: h10p * 4,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: w10p * 0.5,
                            left: w10p * 0.5,
                            top: w10p * 0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${currentIndex + 1}/3",
                              style: TextStyles.textStyle13,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                key: Key("onboardscreenkey"),
                                onTap: () {
                                  if (currentIndex >= 2) {
                                    getIt<SharedPreferences>()
                                        .setString('onboardViewed', 'true');
                                    Navigator.pushReplacementNamed(
                                        context, getStarted);
                                  } else {
                                    setState(() {
                                      currentIndex = currentIndex + 1;
                                      _controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.ease);
                                    });
                                  }
                                },
                                child: Image.asset(
                                    "assets/images/arrow-circle.png"))
                          ],
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                            controller: _controller,
                            onPageChanged: (value) {
                              setState(() {
                                currentIndex = value;
                              });
                            },
                            itemCount: text1.length,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Container(
                                  child: Image.asset(images[index]),
                                ),
                              );
                            }),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: h1p * 3, bottom: h1p * 3),
                              child: Text(text1[currentIndex],
                                  style: TextStyles.textStyle10),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: h1p * 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DotBuild(
                                      color: currentIndex == 0
                                          ? Colors.blue
                                          : Colors.black),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18),
                                    child: DotBuild(
                                        color: currentIndex == 1
                                            ? Colors.blue
                                            : Colors.black),
                                  ),
                                  DotBuild(
                                      color: currentIndex == 2
                                          ? Colors.blue
                                          : Colors.black),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      );
    });
  }
}

class CenterWidgetOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              "Payments made \neasy!!",
              style: TextStyles.textStyle11,
            ),
          ),
          Row(
            children: [
              Image.asset("assets/images/polygon.png"),
              const SizedBox(width: 10),
              const Text(
                "Invoice Payments made easy!",
                style: TextStyles.textStyle12,
              )
            ],
          ),
          Row(
            children: [
              Image.asset("assets/images/polygon.png"),
              const SizedBox(width: 10),
              const Text(
                "One Click Payments!",
                style: TextStyles.textStyle12,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CenterWidgetTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              "Maximise your \nSavings",
              style: TextStyles.textStyle11,
            ),
          ),
          Row(
            children: [
              Image.asset("assets/images/polygon.png"),
              const SizedBox(width: 10),
              const Text(
                "Pay Early & Save More",
                style: TextStyles.textStyle12,
              )
            ],
          ),
          Row(
            children: [
              Image.asset("assets/images/polygon.png"),
              const SizedBox(width: 10),
              const Text(
                "Invoice Payments made easy!",
                style: TextStyles.textStyle12,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CenterWidgetThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18),
            child: Text(
              "Get Rewarded on \nevery transaction",
              style: TextStyles.textStyle11,
            ),
          ),
          Row(
            children: [
              Image.asset("assets/images/polygon.png"),
              const SizedBox(width: 10),
              const Text(
                "Invoice Payments made easy!",
                style: TextStyles.textStyle12,
              )
            ],
          ),
          Row(
            children: [
              Image.asset("assets/images/polygon.png"),
              const SizedBox(width: 10),
              const Text(
                "One Click Payments!",
                style: TextStyles.textStyle12,
              )
            ],
          ),
        ],
      ),
    );
  }
}
//   Container(
//   width: MediaQuery.of(context).size.width,
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30),
//               child: Image.asset("assets/images/icon-2.png"),
//             ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: const [
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Text(
//                 "Get Started",
//                 style: TextStyles.textStyle15,
//               ),
//             ),
//           ],
//         ),
//         Row(children: [
//           Expanded(
//             child: InkWell(
//               onTap: (){
//                 final provider = Provider.of<GoogleSignInManager>(context,listen : false);
//                 provider.googleLogin();
//
//                 getIt<GoogleSignInManager>().apiGoogleLogin();
//               },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 child: Center(
//                     child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset("assets/images/google-icon.png"),
//                     const SizedBox(
//                       width: 18,
//                     ),
//                     const Text("Continue with Google",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w700,
//                             fontFamily: "Poppins",
//                             fontStyle: FontStyle.normal,
//                             fontSize: 14.0)),
//                   ],
//                 )),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colours.black, width: 1),
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(7)),
//               ),
//             ),
//           ),
//         ]),
//
//       ],
//     ),
//   ),
// );