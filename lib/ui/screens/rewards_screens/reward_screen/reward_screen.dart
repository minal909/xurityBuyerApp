import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:xuriti/ui/routes/router.dart';

import '../../../../logic/view_models/reward_manager.dart';
import '../../../../models/core/reward_model.dart';
import '../../../../models/helper/service_locator.dart';
import '../../../theme/constants.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _OnboardState();
}

class _OnboardState extends State<RewardScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    RewardModel? rewardData = getIt<RewardManager>().rewards;
    List<Widget> listScreens = [
      const LevelOneList(),
      const LevelTwoList(),
      const LevelThreeList(),
    ];
    List<Map<String, String>> listHeading = [
      {
        "heading": "Level 1 Rewards",
        "image": "assets/images/home_images/level1.png",
      },
      {
        "heading": "Level 2 Rewards",
        "image": "assets/images/home_images/level2.png",
      },
      {
        "heading": "Level 3 Rewards",
        "image": "assets/images/home_images/level3.png",
      },
    ];
    // List<Widget> levelContainer = [
    //   LevelContainerOne(),
    //   LevelContainerTwo(),
    //   LevelContainerThree()
    // ];

    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;

      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Image.asset(
              "assets/images/xuriti-logo.png",
              width: 75,
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.all(15),
                child:
                    SvgPicture.asset("assets/images/home_images/menu-bars.svg"),
              )
            ]),
        body: Container(
            width: maxWidth,
            height: maxHeight,
            decoration: const BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            // child:

            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 18, right: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                    "assets/images/home_images/arrow-back.svg")),
                            const SizedBox(
                              width: 8,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Rewards",
                                    style: TextStyles.textStyle41)),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, allRewards);
                          },
                          child: Container(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 12),
                              child: Text("View All Rewards",
                                  style: TextStyles.textStyle42),
                            ),
                            decoration: BoxDecoration(
                                color: Colours.pumpkin,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      height: 140,
                      width: maxWidth,
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          Rewards currentReward =
                              rewardData!.data!.rewards![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 9.0, vertical: 8),
                            child: Stack(children: [
                              Container(
                                margin: const EdgeInsets.all(2),
                                width: w10p * 9,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(currentReward
                                                    .status ==
                                                "CLAIMED"
                                            ? "assets/images/completed-reward.png"
                                            : currentReward.status ==
                                                    "UNCLAIMED"
                                                ? "assets/images/home_images/bgimage1.png"
                                                : currentReward.status ==
                                                        "LOCKED"
                                                    ? "assets/images/home_images/bgimage2.png"
                                                    : "assets/images/home_images/bgimage2.png")),
                                    borderRadius: BorderRadius.circular(28),
                                    color: Colours.white,
                                    // border: Border.all(color: Colours.black,width: 0.5),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 0.1,
                                          blurRadius: 1,
                                          offset: Offset(
                                            0,
                                            1,
                                          )),
                                      // BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 1,
                                      //     offset: Offset(1,1,))
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 18),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text("Xuriti Rewards",
                                                  style:
                                                      TextStyles.textStyle104),
                                              Text(
                                                  "Level ${currentReward.level}",
                                                  style: currentReward.status ==
                                                          "CLAIMED"
                                                      ? TextStyles.textStyle46
                                                      : TextStyles.textStyle38),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text("15",
                                                  style: currentReward.status ==
                                                          "CLAIMED"
                                                      ? TextStyles.textStyle105
                                                      : TextStyles.textStyle39),
                                              Text("/15",
                                                  style: currentReward.status ==
                                                          "CLAIMED"
                                                      ? TextStyles.textStyle106
                                                      : TextStyles.textStyle38),
                                            ],
                                          ),
                                        ],
                                      ),
                                      currentReward.status == "CLAIMED"
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0),
                                              child: LinearPercentIndicator(
                                                  padding: EdgeInsets.all(
                                                      0), //leaner progress bar
                                                  animation: true,
                                                  animationDuration: 1000,
                                                  lineHeight: 15,
                                                  percent: 100 / 100,
                                                  progressColor:
                                                      Colours.pumpkin,
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.3)),
                                            )
                                          : currentReward.status == "UNCLAIMED"
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 18.0),
                                                  child: LinearPercentIndicator(
                                                      padding: EdgeInsets.all(
                                                          0), //leaner progress bar
                                                      animation: true,
                                                      animationDuration: 1000,
                                                      lineHeight: 15,
                                                      percent: 50 / 100,
                                                      progressColor:
                                                          Colours.pumpkin,
                                                      backgroundColor: Colors
                                                          .grey
                                                          .withOpacity(0.3)),
                                                )
                                              : currentReward.status == "LOCKED"
                                                  ? Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 18.0),
                                                      child:
                                                          LinearPercentIndicator(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      0), //leaner progress bar
                                                              animation: true,
                                                              animationDuration:
                                                                  1000,
                                                              lineHeight: 15,
                                                              percent: 0 / 100,
                                                              progressColor:
                                                                  Colours
                                                                      .pumpkin,
                                                              backgroundColor:
                                                                  Colors.grey
                                                                      .withOpacity(
                                                                          0.3)),
                                                    )
                                                  : Container(),
                                         Text(
                                          currentReward.status == "CLAIMED"
                                              ? "Level Completed"
                                              : currentReward.status ==
                                                      "UNCLAIMED"
                                                  ? "Complete 9 transactions to next reward"
                                                  : currentReward.status ==
                                                          "LOCKED"
                                                      ? "Locked 🔒"
                                                      : "",
                                          style:
                                              currentReward.status == "CLAIMED"
                                                  ? TextStyles.textStyle107
                                                  : TextStyles.textStyle40)
                                    ],
                                  ),
                                ),
                              ),
                              currentReward.status == "CLAIMED"
                                  ? Positioned(
                                      top: h10p * 0.5,
                                      left: w10p * 2.5,
                                      child: Container(
                                        height: h10p * 0.4,
                                        width: w10p * 2.5,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: Colours.pumpkin,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "View Rewards",
                                            style: TextStyles.textStyle47,
                                          ),
                                        ),
                                      ))
                                  : Container(),
                              currentReward.status == "CLAIMED"
                                  ? Positioned(
                                      top: h10p * 0.63,
                                      right: w10p * 0.67,
                                      child: SvgPicture.asset(
                                          "assets/images/leading-star.svg"),
                                    )
                                  : currentReward.status == "UNCLAIMED"
                                      ? Positioned(
                                          top: h10p * 0.69,
                                          right: w10p * 3.4,
                                          child: SvgPicture.asset(
                                              "assets/images/leading-star.svg"),
                                        )
                                      : currentReward.status == "LOCKED"
                                          ? Positioned(
                                              top: h10p * 0.7,
                                              right: w10p * 3.5,
                                              child: SvgPicture.asset(
                                                  "assets/images/reward-lockedImage.svg"),
                                            )
                                          : Container(),
                            ]),
                          );
                        },
                        itemCount: 3,
                        // rewards.data!.rewards!.length,
                        loop: false,
                        viewportFraction: 0.8,
                        scale: 0.99,
                        onIndexChanged: (value) {
                          setState(() {
                            currentIndex = value;
                          });
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("${listHeading[currentIndex]["image"]}"),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "${listHeading[currentIndex]["heading"]}",
                          style: TextStyles.textStyle43,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: maxWidth,
                      child: listScreens[currentIndex],
                    ),
                  )
                ],
              ),
            )),
      );
    });
  }
}

// class LevelContainerOne extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       double maxHeight = constraints.maxHeight;
//       double maxWidth = constraints.maxWidth;
//       double h1p = maxHeight * 0.01;
//       double h10p = maxHeight * 0.1;
//       double w10p = maxWidth * 0.1;
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 8),
//         child: Stack(children: [
//           Container(
//             margin: const EdgeInsets.all(2),
//             width: w10p * 9,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.fill,
//                     image: AssetImage(
//                       "assets/images/completed-reward.png",
//                     )),
//                 borderRadius: BorderRadius.circular(28),
//                 color: Colours.white,
//                 // border: Border.all(color: Colours.black,width: 0.5),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Colors.grey,
//                       spreadRadius: 0.1,
//                       blurRadius: 1,
//                       offset: Offset(
//                         0,
//                         1,
//                       )),
//                   // BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 1,
//                   //     offset: Offset(1,1,))
//                 ]),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("Xuriti Rewards",
//                               style: TextStyles.textStyle104),
//                           Text("Level 1", style: TextStyles.textStyle46),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Text("15", style: TextStyles.textStyle105),
//                           Text("/15", style: TextStyles.textStyle106),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                     child: LinearPercentIndicator(
//                         padding: EdgeInsets.all(0), //leaner progress bar
//                         animation: true,
//                         animationDuration: 1000,
//                         lineHeight: 15,
//                         percent: 100 / 100,
//                         progressColor: Colours.pumpkin,
//                         backgroundColor: Colors.grey.withOpacity(0.3)),
//                   ),
//                   const Text(
//                     "Level Completed",
//                     style: TextStyles.textStyle107,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               top: h10p * 3.4,
//               left: w10p * 2.8,
//               child: Container(
//                 height: h10p * 1.8,
//                 width: w10p * 3.5,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4),
//                   color: Colours.pumpkin,
//                 ),
//                 child: Center(
//                   child: Text(
//                     "View Rewards",
//                     style: TextStyles.textStyle47,
//                   ),
//                 ),
//               )),
//           Positioned(
//             top: h10p * 3.8,
//             right: w10p * 1,
//             child: SvgPicture.asset("assets/images/leading-star.svg"),
//           )
//         ]),
//       );
//     });
//   }
// }
//
// class LevelContainerTwo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       double maxHeight = constraints.maxHeight;
//       double maxWidth = constraints.maxWidth;
//       double h1p = maxHeight * 0.01;
//       double h10p = maxHeight * 0.1;
//       double w10p = maxWidth * 0.1;
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 8),
//         child: Stack(children: [
//           Container(
//             margin: const EdgeInsets.all(2),
//             width: w10p * 9,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.fitWidth,
//                     image:
//                         AssetImage("assets/images/home_images/bgimage1.png")),
//                 borderRadius: BorderRadius.circular(28),
//                 color: Colours.white,
//                 // border: Border.all(color: Colours.black,width: 0.5),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Colors.grey,
//                       spreadRadius: 0.1,
//                       blurRadius: 1,
//                       offset: Offset(
//                         0,
//                         1,
//                       )),
//                   // BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 1,
//                   //     offset: Offset(1,1,))
//                 ]),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("Xuriti Rewards",
//                               style: TextStyles.textStyle37),
//                           Text("Level 2", style: TextStyles.textStyle38),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Text("21", style: TextStyles.textStyle39),
//                           Text("/30", style: TextStyles.textStyle38),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                     child: LinearPercentIndicator(
//                         padding: EdgeInsets.all(0), //leaner progress bar
//                         animation: true,
//                         animationDuration: 1000,
//                         lineHeight: 15,
//                         percent: 50 / 100,
//                         progressColor: Colours.pumpkin,
//                         backgroundColor: Colors.grey.withOpacity(0.3)),
//                   ),
//                   const Text(
//                     "Complete 9 transactions to next reward",
//                     style: TextStyles.textStyle40,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: h10p * 4.3,
//             right: w10p * 3.9,
//             child: SvgPicture.asset("assets/images/leading-star.svg"),
//           )
//         ]),
//       );
//     });
//   }
// }
//
// class LevelContainerThree extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraints) {
//       double maxHeight = constraints.maxHeight;
//       double maxWidth = constraints.maxWidth;
//       double h1p = maxHeight * 0.01;
//       double h10p = maxHeight * 0.1;
//       double w10p = maxWidth * 0.1;
//       return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 8),
//         child: Stack(children: [
//           Container(
//             margin: const EdgeInsets.all(2),
//             width: w10p * 9,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.fitWidth,
//                     image:
//                         AssetImage("assets/images/home_images/bgimage2.png")),
//                 borderRadius: BorderRadius.circular(28),
//                 color: Colours.white,
//                 // border: Border.all(color: Colours.black,width: 0.5),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Colors.grey,
//                       spreadRadius: 0.1,
//                       blurRadius: 1,
//                       offset: Offset(
//                         0,
//                         1,
//                       )),
//                   // BoxShadow(color: Colors.grey,spreadRadius: 0.5,blurRadius: 1,
//                   //     offset: Offset(1,1,))
//                 ]),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text("Xuriti Rewards",
//                               style: TextStyles.textStyle37),
//                           Text("Level 3", style: TextStyles.textStyle38),
//                         ],
//                       ),
//                       Row(
//                         children: const [
//                           Text("0", style: TextStyles.textStyle39),
//                           Text("/50", style: TextStyles.textStyle38),
//                         ],
//                       ),
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                     child: LinearPercentIndicator(
//                         padding: EdgeInsets.all(0), //leaner progress bar
//                         animation: true,
//                         animationDuration: 1000,
//                         lineHeight: 15,
//                         percent: 0 / 100,
//                         progressColor: Colours.pumpkin,
//                         backgroundColor: Colors.grey.withOpacity(0.3)),
//                   ),
//                   const Text(
//                     "Locked 🔒",
//                     style: TextStyles.textStyle40,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//             top: h10p * 4.5,
//             right: w10p * 4.5,
//             child: SvgPicture.asset("assets/images/reward-lockedImage.svg"),
//           )
//         ]),
//       );
//     });
//   }
// }

class LevelOneList extends StatelessWidget {
  const LevelOneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Rewards> levelOneReward = Provider.of<RewardManager>(context).levelOneReward;
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return ListView.builder(
          itemCount: levelOneReward.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, singleReward);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colours.lightGrey,
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 18, horizontal: w1p * 2.5),
                        child: Column(
                          children: [
                            Container(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8),
                                child: Text("Xuriti Rewards",
                                    style: TextStyles.textStyle45),
                              ),
                              decoration: BoxDecoration(
                                  color: Colours.peach,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                             Text(
                                levelOneReward[index].reward ?? '',
                                style: TextStyles.textStyle44),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colours.black80,
                                    borderRadius: BorderRadius.circular(5)),
                                child:  Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 15),
                                  child: Text(levelOneReward[index].status ?? '',
                                      style: TextStyles.textStyle46),
                                ))
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Image.asset(
                            "assets/images/home_images/rewards.png"),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}

class LevelTwoList extends StatelessWidget {
  const LevelTwoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Rewards> levelTwoReward = Provider.of<RewardManager>(context).levelTwoReward;

    List<Map<String, String>> list = [
      {
        "title": "Free Credit Period Extention\nof 7 Days for upto ₹ 75,000/-",
        "subtitle": "Xuriti Rewards",
        "image": "assets/images/home_images/rewards.png"
      },
      {
        "title": "Dinner vouchers for 5K +\nmovie vouchers for 2 pax",
        "subtitle": "Entertainment",
        "image": "assets/images/home_images/cinema.png"
      },
      {
        "title": "3 Star hotel stay for\n2 pax x 2 nights",
        "subtitle": "Travel",
        "image": "assets/images/home_images/entertainment.png"
      },
    ];
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return ListView.builder(
          itemCount: levelTwoReward.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: w1p * 2.5, vertical: 9),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, singleReward);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colours.lightGrey,
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 18),
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8),
                                child: Text("Xuriti Rewards",
                                    style: TextStyles.textStyle45),
                              ),
                              decoration: BoxDecoration(
                                  color: Colours.peach,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            Text(levelTwoReward[index].reward ?? '',
                                style: TextStyles.textStyle44),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colours.black80,
                                    borderRadius: BorderRadius.circular(5)),
                                child:  Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 15),
                                  child: Text(levelTwoReward[index].status ?? '',
                                      style: TextStyles.textStyle46),
                                ))
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Image.asset("assets/images/home_images/rewards.png"),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}

class LevelThreeList extends StatelessWidget {
  const LevelThreeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Rewards> levelThreeReward = Provider.of<RewardManager>(context).levelThreeReward;

    List<Map<String, String>> list = [
      {
        "title": "Free Credit Period Extention\nof 7 Days for upto ₹ 75,000/-",
        "subtitle": "Xuriti Rewards",
        "image": "assets/images/home_images/rewards.png"
      },
      {
        "title": "4 Star hotel stay for  2 pax x 4 nights",
        "subtitle": "Travel",
        "image": "assets/images/home_images/entertainment2.png"
      },
    ];
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return ListView.builder(
          itemCount: levelThreeReward.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: w1p * 2.5, vertical: 9),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, singleReward);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colours.lightGrey,
                      borderRadius: BorderRadius.circular(7)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 18),
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 8),
                                child: Text("Xuriti Rewards",
                                    style: TextStyles.textStyle45),
                              ),
                              decoration: BoxDecoration(
                                  color: Colours.peach,
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            Text(levelThreeReward[index].reward ?? '',
                                style: TextStyles.textStyle44),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colours.black80,
                                    borderRadius: BorderRadius.circular(5)),
                                child:  Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 15),
                                  child: Text(levelThreeReward[index].status ?? '',
                                      style: TextStyles.textStyle46),
                                ))
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Image.asset("assets/images/home_images/rewards.png"),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    });
  }
}
