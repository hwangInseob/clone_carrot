import 'package:flutter/material.dart';

class MannerTemperature extends StatelessWidget {
  MannerTemperature({super.key, required this.mannerTemp});

  double mannerTemp;

  getTempLevel() {
    if (mannerTemp <= 20) {
      return 0;
    } else if (mannerTemp > 20 && mannerTemp <= 32) {
      return 1;
    } else if (mannerTemp > 32 && mannerTemp <= 36.5) {
      return 2;
    } else if (mannerTemp > 36.5 && mannerTemp <= 40) {
      return 3;
    } else if (mannerTemp > 40 && mannerTemp <= 50) {
      return 4;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            //매너 progress bar 및 aa.b˚C
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  mannerTemp.toString() + '˚C',
                  style: TextStyle(
                    color: Colors.blue[700],
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 6,
                        width: 50 / 100 * mannerTemp,
                        decoration: BoxDecoration(color: Colors.blue[700]),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  height: 6,
                  width: 50,
                )
              ],
            ),
            SizedBox(
              width: 6,
            ),
            //mannerLevel 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(double.infinity),
              child: Image.asset(
                'assets/images/level-${getTempLevel().toString()}.jpg',
                width: 28,
              ),
            ),
          ],
        ),
        // MannerMeter Text
        Text(
          "Manner Meter",
          style: TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.underline,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
