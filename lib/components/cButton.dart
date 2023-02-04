import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:flutter/material.dart';

class CBlueButtonWithIcon extends StatelessWidget {
  final Widget icon;

  final Widget title;
  final Function onpressed;

  CBlueButtonWithIcon({
    required this.icon,
    required this.title,
    required this.onpressed,
  });
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff2077C8), Color(0xff0096C7)])),
        child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 4),
            onPressed: onpressed(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [icon, SizedBox(width: 10), title],
            )));
  }
}

class CWhiteButtonWithIcon extends StatelessWidget {
  final Widget icon;

  final Widget title;
  final Function onpressed;

  CWhiteButtonWithIcon({
    required this.icon,
    required this.title,
    required this.onpressed,
  });
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xff4D545A).withOpacity(0.3),
        ),
        child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 4),
            onPressed: onpressed(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [icon, SizedBox(width: 10), title],
            )));
  }
}

class CButtonOneIcon extends StatelessWidget {
  const CButtonOneIcon(
      {this.key,
      this.color = CustomColors.ButtonColor,
      this.borderColor = CustomColors.ButtonColor,
      this.icon,
      required this.text,
      this.textColor = Colors.black,
      @required this.onPressed,
      this.disabled = false})
      : super(key: key);
  final Color color;
  final Widget? icon;
  final Color borderColor;
  final String text;
  final Color textColor;
  final Key? key;

  final Function()? onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: disabled == true ? CustomColors.DisabledColor : color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: disabled == true ? Colors.transparent : borderColor,
            width: 1,
            style: BorderStyle.solid),
      ),
      child: TextButton(
          onPressed: disabled == true ? null : onPressed,

          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   side: BorderSide(
          //       color: disabled == true ? Colors.transparent : borderColor,
          //       width: 1,
          //       style: BorderStyle.solid),
          // ),
          // disabledColor: disabled == true ? CustomColors.DisabledColor : color,
          child: Container(
            child: Container(
                // padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                icon != null
                    ? Container(
                        padding: EdgeInsets.only(left: 12, top: 2), child: icon)
                    : Container()
              ],
            )),
          )),
    );
  }
}
