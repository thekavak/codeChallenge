import 'package:challengeapp/constant/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class ButtonShort extends StatefulWidget {
  const ButtonShort(
      {Key? key,
      this.onPress,
      required this.heightSize,
      required this.color,
      required this.buttonText})
      : super(key: key);

  final String? buttonText;
  final VoidCallback? onPress;
  final double? heightSize;
  final Color? color;

  @override
  _ButtonShortState createState() => _ButtonShortState();
}

class _ButtonShortState extends State<ButtonShort> {
  @override
  Widget build(BuildContext context) {
   /// I added the Bounce library, it shrinks and grows on click - for animation
    return Bounce(
      duration:const Duration(milliseconds: 110),
      onPressed: widget.onPress == null ? () {} : widget.onPress!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widget.heightSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.color,
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
