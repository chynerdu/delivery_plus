import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:flutter/material.dart';

class SWbutton extends StatelessWidget {
  final Function onPressed;
  final String title;
  SWbutton({required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: CustomColors.ButtonColor),
        child: MaterialButton(
            splashColor: CustomColors.ButtonColorHover,
            highlightColor: CustomColors.ButtonColorHover,
            onPressed: () {
              onPressed();
              FocusScope.of(context).unfocus();
            },
            child: Text('$title',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 18,
                    fontWeight: FontWeight.w500))));
  }
}

class SWIconbutton extends StatelessWidget {
  final bool? isDisabled;
  final Function onPressed;
  final Widget icon;
  SWIconbutton({required this.onPressed, required this.icon, this.isDisabled});

  Widget build(BuildContext context) {
    return Container(
        // width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isDisabled == true
                ? CustomColors.ButtonColor.withOpacity(0.2)
                : CustomColors.ButtonColor),
        child: MaterialButton(
            disabledColor: CustomColors.ButtonColor.withOpacity(0.2),
            splashColor: CustomColors.ButtonColorHover,
            highlightColor: CustomColors.ButtonColorHover,
            onPressed: () {
              isDisabled == true ? null : onPressed();
            },
            child: Align(alignment: Alignment.center, child: icon)));
  }
}

class SWSuttonSmall extends StatelessWidget {
  final Function onPressed;

  final String title;
  SWSuttonSmall({required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: CustomColors.ButtonColor),
        child: MaterialButton(
            splashColor: CustomColors.ButtonColorHover,
            highlightColor: CustomColors.ButtonColorHover,
            onPressed: () {
              onPressed();
            },
            child: Text('$title',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 12,
                    fontWeight: FontWeight.w500))));
  }
}

class SWSuttonSmallDisbaled extends StatelessWidget {
  final Function onPressed;
  final String title;
  SWSuttonSmallDisbaled({required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: MaterialButton(
            disabledColor: CustomColors.ButtonColor.withOpacity(0.2),
            onPressed: null,
            child: Text('$title',
                style: TextStyle(
                    color: Color(0xff000000).withOpacity(0.3),
                    fontSize: 12,
                    fontWeight: FontWeight.w500))));
  }
}

class SWSuttonGreenSmallDisbaled extends StatelessWidget {
  final Function onPressed;
  final String title;
  SWSuttonGreenSmallDisbaled({required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: MaterialButton(
            disabledColor: Colors.green.withOpacity(0.6),
            onPressed: null,
            child: Text('$title',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontSize: 12,
                    fontWeight: FontWeight.w500))));
  }
}

class SWBorderedButton extends StatelessWidget {
  final Color? color;
  final Function onPressed;
  final String title;
  SWBorderedButton({this.color, required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: OutlinedButton(
            style: ButtonStyle(
                enableFeedback: true,
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: color ?? Color(0xffFFD004)))),
            onPressed: () {
              onPressed();
            },
            child: Text('$title',
                style: TextStyle(
                    color: color ?? Color(0xff333333),
                    fontSize: 12,
                    fontWeight: FontWeight.w500))));
  }
}

class SWBorderedButtonBig extends StatelessWidget {
  final Color? color;
  final Function onPressed;
  final String title;
  SWBorderedButtonBig(
      {this.color, required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        height: 55,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: OutlinedButton(
            style: ButtonStyle(
                enableFeedback: true,
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: color ?? Color(0xff8A6D03)))),
            onPressed: () {
              onPressed();
            },
            child: Text('$title',
                style: TextStyle(
                    color: color ?? Color(0xff8A6D03),
                    fontSize: 18,
                    fontWeight: FontWeight.w700))));
  }
}

class SWBorderedButtonWithIcon extends StatelessWidget {
  final Color? color;
  final Function onPressed;
  final String title;
  final Icon icon;
  SWBorderedButtonWithIcon(
      {this.color,
      required this.onPressed,
      required this.icon,
      required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: OutlinedButton(
            style: ButtonStyle(
                enableFeedback: true,
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: color ?? Color(0xffFFD004)))),
            onPressed: () {
              onPressed();
            },
            child: Row(children: [
              icon,
              SizedBox(width: 4),
              Text('$title',
                  style: TextStyle(
                      color: color ?? Color(0xff333333),
                      fontSize: 12,
                      fontWeight: FontWeight.w500))
            ])));
  }
}
