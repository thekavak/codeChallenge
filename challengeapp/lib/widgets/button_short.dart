import 'package:challengeapp/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import 'dart:ui';

class ButtonShort extends StatefulWidget {
  const ButtonShort(
      {Key? key,
      this.onPress,
      required this.buttonText})
      : super(key: key);

  final String? buttonText;
  final VoidCallback? onPress;


  @override
  _ButtonShortState createState() => _ButtonShortState();
}

class _ButtonShortState extends State<ButtonShort> {
  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: Duration(milliseconds: 110),
      onPressed: widget.onPress == null ? () {} : widget.onPress!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: ThemeText.buttonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.buttonText.toString(),
              style: ThemeText.buttomTextOpenSans,
            ),
          ],
        ),
      ),
    );
  }
}