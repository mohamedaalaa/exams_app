import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'colors.dart';
import 'constants.dart';

Widget text(
  String? text, {
  var fontSize = textSizeLargeMedium,
  Color? textColor,
  var fontFamily,
  var isCentered = false,
  var maxLine = 3,
  var latterSpacing = 0.5,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
  bool isBold = false,
  double? wordSpacing,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    // maxLines: isLongText ? null : maxLine,
    maxLines: maxLine,
    softWrap: true,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      wordSpacing: wordSpacing ?? 0,
      fontFamily: fontFamily,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontSize: fontSize,
      color: textColor ?? textColorPrimary,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Widget roundedButton1(
    {required String label,
    required double btnWidth,
    required Function onTap,
    int? textSize}) {
  return SizedBox(
    width: btnWidth,
    child: OutlinedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(blueAccentColor),
        overlayColor: MaterialStateProperty.all(whiteColor),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        side: MaterialStateProperty.all(
          BorderSide.lerp(
              const BorderSide(
                style: BorderStyle.solid,
                color: blueAccentColor,
                width: 2.0,
              ),
              const BorderSide(
                style: BorderStyle.solid,
                color: blueAccentColor,
                width: 2.0,
              ),
              50.0),
        ),
      ),
      child: Text(label,
          style: boldTextStyle(color: whiteColor, size: textSize ?? 18)),
    ),
  );
}

Widget roundedButton(
    {required String label,
    double? btnWidth,
    required Function onTap,
    int? textSize}) {
  return (btnWidth == null)
      ? OutlinedButton(
          onPressed: () {
            onTap();
          },
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(blueAccentColor),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0))),
            side: MaterialStateProperty.all(
              BorderSide.lerp(
                  const BorderSide(
                    style: BorderStyle.solid,
                    color: blueAccentColor,
                    width: 2.0,
                  ),
                  const BorderSide(
                    style: BorderStyle.solid,
                    color: blueAccentColor,
                    width: 2.0,
                  ),
                  50.0),
            ),
          ),
          child: Text(label,
              style:
                  boldTextStyle(color: buttonsTextColor, size: textSize ?? 18)),
        )
      : SizedBox(
          width: btnWidth,
          child: OutlinedButton(
            onPressed: () {
              onTap();
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(blueAccentColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
              side: MaterialStateProperty.all(
                BorderSide.lerp(
                    const BorderSide(
                      style: BorderStyle.solid,
                      color: blueAccentColor,
                      width: 2.0,
                    ),
                    const BorderSide(
                      style: BorderStyle.solid,
                      color: blueAccentColor,
                      width: 2.0,
                    ),
                    50.0),
              ),
            ),
            child: Text(label,
                style: boldTextStyle(
                    color: buttonsTextColor, size: textSize ?? 18)),
          ),
        );
}

Widget appButton(
    {required String label,
    required Widget widget,
    double? btnWidth,
    required Function onTap,
    int? textSize,
    Color? backgroundColor}) {
  return ConstrainedBox(
    constraints: (btnWidth != null)
        ? BoxConstraints.tightFor(width: btnWidth, height: 45)
        : const BoxConstraints.tightFor(height: 45),
    child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(backgroundColor ?? blueAccentColor),
          overlayColor: MaterialStateProperty.all(backgroundColor),
        ),
        onPressed: () {
          onTap();
        },
        child: widget
        //Text(label, style: boldTextStyle(color: white, size: textSize ?? 18)),
        ),
  );
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> displayMessage(
    String text, BuildContext context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    elevation: 1,
    backgroundColor: blackColor,
    content: Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  ));
}

class Dot extends StatelessWidget {
  final double? radius;
  final Color color;
  const Dot({Key? key, this.radius, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

Widget loadingRow() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Dot(
        color: blueAccentColor,
        radius: 15,
      ),
      5.width,
      const Dot(
        color: blueAccentColor,
        radius: 15,
      ),
      5.width,
      const Dot(
        color: blueAccentColor,
        radius: 15,
      ),
      5.width,
    ],
  );
}

Widget stepper(int num, int pageNum) {
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
          (num) => Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                radius: num == pageNum ? 15 : 10,
                backgroundColor: num == pageNum ? blueAccentColor : grey,
              )
              /*Container(
                  width: 15,
                  height: num == pageNum ? 25 : 15,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(num == pageNum ? 25 : 15),
                      color: num == pageNum ? blueAccentColor : Colors.black38),
                ),*/
              )));
}
