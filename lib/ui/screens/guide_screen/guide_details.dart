import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme/constants.dart';

class AllGuideDetails extends StatefulWidget {
  const AllGuideDetails({Key? key}) : super(key: key);

  @override
  State<AllGuideDetails> createState() => _AllGuideDetailsState();
}

class _AllGuideDetailsState extends State<AllGuideDetails> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Scaffold(

        body: Column(
          children: [
            Stack(children: [
              Container(
                height: h10p * 4,
                width: maxWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                    ),
                    color: Colours.tangerine,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/guideImages/guide-details.png",
                      ),
                      fit: BoxFit.fill,
                    )),
                // child: Image.asset("assets/images/guideImages/guide-details.png",),
              ),
              Positioned(
                  top: h10p * .3,
                  left: w10p * .4,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                            "assets/images/guideImages/guide-back-arrow.png"),
                        SizedBox(
                          width: w10p * .4,
                        ),
                        Text(
                          "Back",
                          style: TextStyles.textStyle108,
                        )
                      ],
                    ),
                  )),
              Positioned(
                  bottom: h1p * 3,
                  right: w10p * .8,
                  child: CircleAvatar(
                    backgroundColor: Colours.white,
                    radius: 3,
                  )),
              Positioned(
                  bottom: h1p * 3,
                  right: w10p * .3,
                  child: CircleAvatar(
                    backgroundColor: Colours.white,
                    radius: 3,
                  )),
              Positioned(
                  bottom: h1p * 3,
                  right: w10p * 1.2,
                  child: Container(
                    height: h1p * .5,
                    width: w10p * .6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colours.tangerine,
                    ),
                  )),
              Positioned(
                  bottom: h1p * 3,
                  right: w10p * 2,
                  child: CircleAvatar(
                    backgroundColor: Colours.white,
                    radius: 3,
                  ))
            ]),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: w10p * .7,left:w10p * .1),
                  child: Column(
                    children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: currentIndex ==0?
                        Colours.tangerine :Colours.white,
                            width:2 ))
                      ),
                      child:InkWell(
                      onTap: (){
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: RotatedBox(

                          quarterTurns: -1,
                          child: RichText(

                            text: TextSpan(
                                text: 'Basic Info',
                                style: currentIndex == 0?
                                TextStyles.textStyle114:
                                TextStyles.textStyle113
                            ),
                          ),
                        ),
                      ),
                    ),
                    ),
                      SizedBox(height: h10p * 1.9,),
                      Container(
                        decoration: BoxDecoration(
                            border: Border(left: BorderSide(color: currentIndex ==1?
                            Colours.tangerine :Colours.white,
                                width:2 ))
                        ),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              currentIndex = 1;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: RotatedBox(
                              quarterTurns: -1,
                              child: RichText(
                                text: TextSpan(
                                    text: 'Terms & Conditions',
                                    style: currentIndex == 1?
                                    TextStyles.textStyle114:
                                    TextStyles.textStyle113

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h10p * 6,
                  width: w10p * 8,
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Guide title here",
                            style: TextStyles.textStyle109,
                          ),
                          SizedBox(
                            height: h1p * 2,
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                            style: TextStyles.textStyle110,
                          ),
                          SizedBox(
                            height: h1p * 2,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/images/guideImages/agronomy1.svg"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(" item title",
                                      style: TextStyles.textStyle34),
                                  SizedBox(
                                    height: h1p * .5,
                                  ),
                                  Text(" # value",
                                      style: TextStyles.textStyle111),
                                ],
                              ),
                              SizedBox(
                                width: w10p * 1.5,
                              ),
                              SizedBox(
                                height: h1p * .5,
                              ),
                              SvgPicture.asset(
                                  "assets/images/guideImages/percent.svg"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("item title",
                                      style: TextStyles.textStyle34),
                                  SizedBox(
                                    height: h1p * .5,
                                  ),
                                  Text("# value",
                                      style: TextStyles.textStyle111),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h1p * 2.5,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  "assets/images/guideImages/contract.svg"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(" item title",
                                      style: TextStyles.textStyle34),
                                  SizedBox(
                                    height: h1p * .5,
                                  ),
                                  Text(" # value",
                                      style: TextStyles.textStyle111),
                                ],
                              ),
                              SizedBox(
                                width: w10p * 1.5,
                              ),
                              SizedBox(
                                height: h1p * .5,
                              ),
                              SvgPicture.asset(
                                  "assets/images/guideImages/box.svg"),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(" item title",
                                      style: TextStyles.textStyle34),
                                  SizedBox(
                                    height: h1p * .5,
                                  ),
                                  Text(" # value",
                                      style: TextStyles.textStyle111),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          Container(
                              height: h1p * .1,
                              width: w10p * 7.1,
                              color: Colours.warmGrey75),
                          SizedBox(
                            height: h1p * 3,
                          ),
                          Text(
                              "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.\n \nNemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.\n \nNeque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
                              style: TextStyles.textStyle112),
                          SizedBox(
                            height: h1p * 6,
                          ),
                          SizedBox(
                            height: h1p * 5,
                          ),
                          Container(
                            width: w10p * 3.5,
                            height: h10p * .5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colours.tangerine,
                            ),
                            child: Center(
                                child: Text(
                              "Call to Action",
                              style: TextStyles.subHeading,
                            )),
                          ),
                          SizedBox(
                            height: h1p * 4,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
