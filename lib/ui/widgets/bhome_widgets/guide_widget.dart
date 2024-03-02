import 'package:flutter/material.dart';
import 'package:xuriti/ui/routes/router.dart';

import '../../theme/constants.dart';

class GuideWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;

  const GuideWidget({
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    List<String> guideTitle = [
      "Save More",
      "Get Rewarded",
      "Extend Credit",
    ];
    List<String> guideSimage = [
      "assets/images/guideImages/guide-simage1.png",
      "assets/images/guideImages/guide-simage2.png",
      "assets/images/guideImages/guide-simage3.png",
    ];
    List<String> guideImage = [
      "assets/images/guideImages/guide-image1.png",
      "assets/images/guideImages/guide-image2.png",
      "assets/images/guideImages/guide-image3.png",
    ];
    List<String> guideSubTitle = [
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
    ];
    double h1p = maxHeight * 0.01;
    double h10p = maxHeight * 0.1;
    double w10p = maxWidth * 0.1;
    return Container(
      height: h10p * 3.6,
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: w10p * .2),
            child: Container(
              width: w10p * 5,
              height: h10p * 3.6,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        // Navigator.pushNamed(context, allGuideScreen);
                      },
                      child: Container(
                        // height: h10p * 2.7,
                        width: w10p * 5,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colours.pumpkin,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w10p * .5, vertical: h10p * .2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        guideTitle[index],
                                        style: TextStyles.subHeading,
                                      ),
                                      const Text(
                                        "Rp 5.000.000",
                                        style: TextStyles.subValue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(guideImage[index]),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: w10p * .5, vertical: h1p * 2),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    " \n \n",
                                    style: TextStyles.guideSubTitle,
                                  )),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {},
                                          child: Image.asset(
                                              "assets/images/guideArrow.png")),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0, right: 0, child: Image.asset(guideSimage[index])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
