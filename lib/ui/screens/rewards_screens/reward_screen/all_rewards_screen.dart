import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xuriti/ui/widgets/appbar/app_bar_widget.dart';
import '../../../routes/router.dart';
import '../../../theme/constants.dart';

class AllRewardsScreen extends StatefulWidget {
  const AllRewardsScreen({Key? key}) : super(key: key);

  @override
  State<AllRewardsScreen> createState() => _AllRewardsScreenState();
}

class _AllRewardsScreenState extends State<AllRewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      double w1p = maxWidth * 0.01;
      return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: h10p * .8,
                  flexibleSpace:  AppbarWidget()),
              backgroundColor: Colours.black,
              body: Column(children: [
                SizedBox(
                  height: h1p * .5,
                ),
                Expanded(
                    child: Container(
                        width: maxWidth,
                        decoration: const BoxDecoration(
                            color: Colours.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 15, right: 15),
                          child: ListView(children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      "assets/images/arrowLeft.svg"),
                                  SizedBox(
                                    width: w10p * .2,
                                  ),
                                  const Text(
                                    "All Rewards",
                                    style: TextStyles.textStyle41,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 25, right: 25),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/rewardLevel1.png"),
                                  //SvgPicture.asset("assets/images/rewardLevel1.svg",height: 60,width: 60,)
                                  SizedBox(
                                    width: w10p * .2,
                                  ),
                                  const Text(
                                    "Level 1 Rewards",
                                    style: TextStyles.textStyle43,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: w10p * 3,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 3,
                                color: Colours.peach,
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding:  EdgeInsets.symmetric(vertical: 12,horizontal:w1p * 2.5 ),
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, claimedReward);
                                    },
                                  child: Container(
                                    height: h10p * 1.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colours.offWhite,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                    "assets/images/xuritiRewards.png"),
                                                const Text(
                                                  "Free Credit Period Extention",
                                                  style: TextStyles.textStyle44,
                                                ),
                                                const Text(
                                                  "of 7 Days for upto ₹ 75,000/-",
                                                  style: TextStyles.textStyle44,
                                                ),
                                                Image.asset(
                                                    "assets/images/claimButton.png")
                                              ]),
                                        ),
                                        SizedBox(
                                          width: w10p * .3,
                                        ),

                                        Image.asset(
                                          "assets/images/claimlogo.png",
                                          height: h10p * 1.7,
                                          width: w10p * 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 2.5,
                                color: Colours.peach,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: w10p * 0.63),
                              child: Row(
                                children: [
                                  Image.asset("assets/images/rewardLevel2.png"),
                                  //SvgPicture.asset("assets/images/rewardLevel1.svg",height: 60,width: 60,)
                                  SizedBox(
                                    width: w10p * .2,
                                  ),
                                  const Text(
                                    "Level 2 Rewards",
                                    style: TextStyles.textStyle43,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 3,
                                color: Colours.peach,
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: h10p * 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colours.offWhite,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                "assets/images/xuritiRewards.png"),
                                            const Text(
                                              "Free Credit Period Extention",
                                              style: TextStyles.textStyle44,
                                            ),
                                            const Text(
                                              "of 7 Days for upto ₹ 75,000/-",
                                              style: TextStyles.textStyle44,
                                            ),
                                            SizedBox(
                                              height: h1p * .3,
                                            ),
                                            Container(
                                              height: h1p * 4,
                                              width: w10p * 3.5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colours.pumpkin,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Claim Reward",
                                                  style: TextStyles.textStyle46,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                              "assets/images/claimLevel2.png", width: w10p * 2,height: h10p * 1.7,

                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 2.8,
                                color: Colours.peach,
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: h10p * 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colours.offWhite,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/images/rewardEnt.png",
                                              width: 93,
                                            ),
                                            const Text(
                                              "Dinner vouchers for 5K + ",
                                              style: TextStyles.textStyle44,
                                            ),
                                            const Text(
                                              "movie vouchers for 2 pax",
                                              style: TextStyles.textStyle44,
                                            ),
                                            SizedBox(
                                              height: h1p * .3,
                                            ),
                                            Container(
                                              height: h1p * 4,
                                              width: w10p * 3.5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colours.pumpkin,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Claim Reward",
                                                  style: TextStyles.textStyle46,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/images/claim2.png",
                                            width: w10p * 2,height: h10p * 1.7,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 2.8,
                                color: Colours.peach,
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: h10p * 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colours.offWhite,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/images/rewardEnt.png",
                                              width: 93,
                                            ),
                                            const Text(
                                              "Dinner vouchers for 5K + ",
                                              style: TextStyles.textStyle44,
                                            ),
                                            const Text(
                                              "movie vouchers for 2 pax",
                                              style: TextStyles.textStyle44,
                                            ),
                                            SizedBox(
                                              height: h1p * .3,
                                            ),
                                            Container(
                                              height: h1p * 4,
                                              width: w10p * 3.5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colours.pumpkin,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Claim Reward",
                                                  style: TextStyles.textStyle46,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/images/claimed.png",
                                            width: w10p * 2,height: h10p * 1.7,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 2.8,
                                color: Colours.peach,
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: h10p * 2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colours.offWhite,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/images/rewardEnt.png",
                                              width: 93,
                                            ),
                                            const Text(
                                              "3 Star hotel stay for",
                                              style: TextStyles.textStyle44,
                                            ),
                                            const Text(
                                              "2 pax x 2 nights",
                                              style: TextStyles.textStyle44,
                                            ),
                                            SizedBox(
                                              height: h1p * .3,
                                            ),
                                            Container(
                                              height: h1p * 4,
                                              width: w10p * 2.8,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colours.black80,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Locked 🔓︎",
                                                  style: TextStyles.textStyle46,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/images/claim3.png",
                                            width: w10p * 2,height: h10p * 1.7,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 2.8,
                                color: Colours.peach,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/rewardLevel3.png",
                                    height: 45,
                                    width: 70,
                                  ),
                                  SizedBox(
                                    width: w10p * .2,
                                  ),
                                  const Text(
                                    "Level 3 Rewards",
                                    style: TextStyles.textStyle43,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 3,
                                color: Colours.peach,
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: h10p * 2.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colours.black05,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 26),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                "assets/images/rewardTravel.png",
                                                height: 25,
                                                width: 80),
                                            const Text(
                                              "3 Star hotel stay for",
                                              style: TextStyles.textStyle44,
                                            ),
                                            const Text(
                                              "2 pax x 4 nights",
                                              style: TextStyles.textStyle44,
                                            ),
                                            SizedBox(
                                              height: h1p * .3,
                                            ),
                                            // Image.asset("assets/images/buttonLocked.png",height: 37,width: 120,)
                                            Container(
                                              height: h1p * 4,
                                              width: w10p * 2.8,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colours.black80,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Locked 🔓︎",
                                                  style: TextStyles.textStyle46,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: h1p * 2,
                                          ),
                                          Image.asset(
                                            "assets/images/travelLevel3.png",
                                            width: w10p * 2,height: h10p * 1.7,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: w10p * 8.2, left: w10p * 1),
                              child: Container(
                                height: h1p * 3,
                                color: Colours.peach,
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  height: h10p * 2.1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colours.black05,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 26),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                                "assets/images/xuritirewards2x.png",
                                                // height: 25,
                                                width: 95),
                                            const Text(
                                              "Free Credit Period Extention",
                                              style: TextStyles.textStyle44,
                                            ),
                                            const Text(
                                              "of 7 Days for upto ₹ 75,000/-",
                                              style: TextStyles.textStyle44,
                                            ),
                                            SizedBox(
                                              height: h1p * .3,
                                            ),
                                            // Image.asset("assets/images/buttonLocked.png",height: 37,width: 120,)
                                            Container(
                                              height: h1p * 4,
                                              width: w10p * 2.8,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                color: Colours.black80,
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Locked 🔓︎",
                                                  style: TextStyles.textStyle46,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            height: h1p * 2.5,
                                          ),
                                          Image.asset(
                                            "assets/images/rewardLocked.png",
                                            width: w10p * 2,height: h10p * 1.7,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        )))
              ])));
    });
  }
}
