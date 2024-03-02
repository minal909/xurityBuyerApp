import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:xuriti/ui/theme/constants.dart';

class LevelContainer extends StatelessWidget {
  final int index;
  LevelContainer(this.index);
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> list = [
      {"level": "1", "bgimage": ""},
      {"level": "2", "bgimage": "assets/images/home_images/bgimage1.png"},
      {"level": "3", "bgimage": "assets/images/home_images/bgimage2.png"}
    ];
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;
      double h1p = maxHeight * 0.01;
      double h10p = maxHeight * 0.1;
      double w10p = maxWidth * 0.1;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 8),
        child: Container(
          margin: const EdgeInsets.all(2),
          width: 250,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage("${list[index]["bgimage"]}")),
              borderRadius: BorderRadius.circular(28),
              color: Colours.white,
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.1,
                    blurRadius: 1,
                    offset: Offset(
                      0,
                      1,
                    )),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Xuriti Rewards",
                            style: TextStyles.textStyle37),
                        Text("Level ${list[index]["level"]}",
                            style: TextStyles.textStyle38),
                      ],
                    ),
                    Row(
                      children: const [
                        Text("0", style: TextStyles.textStyle39),
                        Text("/50", style: TextStyles.textStyle38),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: LinearPercentIndicator(
                      padding: EdgeInsets.all(0), //leaner progress bar
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 15,
                      percent: 70 / 100,
                      progressColor: Colors.amber,
                      backgroundColor: Colors.grey.withOpacity(0.3)),
                ),
                const Text(
                  "Level Completed",
                  style: TextStyles.textStyle40,
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
