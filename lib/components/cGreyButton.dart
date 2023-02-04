import 'package:flutter/material.dart';

class CGreyButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  CGreyButton({required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Color(0xff4D545A)),
        child: MaterialButton(
            onPressed: () {
              onPressed();
            },
            child: Text('$title',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                    fontWeight: FontWeight.w500))));
  }
}
