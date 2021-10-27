import 'package:challengeapp/constant/styles.dart';
import 'package:challengeapp/core/base/base_state.dart';
import 'package:challengeapp/widgets/button_short.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomButton extends StatefulWidget {
  const BottomButton(
      {Key? key,
      required this.flag,
      required this.onPress,
      required this.controller})
      : super(key: key);

  final bool flag;
  final VoidCallback? onPress;
  final TextEditingController controller;

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> with BaseState {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.30,
      color: ThemeText.bottomBoxColor,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(
              stringConstant.shapePath,
              width: MediaQuery.of(context).size.width * 0.7,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///I used Flag here to change the text and color in the hint part.
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: widget.controller,
                  scrollPadding: EdgeInsets.only(bottom: 40),
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: widget.flag
                        ? stringConstant.textFieldHint.toString()
                        : stringConstant.missingText.toString(),
                    hintStyle: widget.flag
                        ? ThemeText.hintTextOpenSans
                        : ThemeText.hintMissingTextOpenSans,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ButtonShort(
                    buttonText: stringConstant.buttonText,
                    heightSize: 60,
                    color: ThemeText.buttonColor,
                    onPress: widget.onPress,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
