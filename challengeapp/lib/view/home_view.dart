import 'package:challengeapp/constant/styles.dart';
import 'package:challengeapp/core/base/base_state.dart';
import 'package:challengeapp/widgets/button_short.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with BaseState {
  TextEditingController _controller = TextEditingController();
  bool flag = true; 

  void checkValue() {
    if (_controller.text.isEmpty) {
      setState(() {
        flag = false;
      });
    } else {
      setState(() {
        flag = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ThemeText.backgroundColor,
      body: SingleChildScrollView(
        child: buildSafeArea(context),
      ),
    );
  }

  GestureDetector buildSafeArea(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(children: <Widget>[
        buildLogoContainer(context),
        buildImageContainer(context),
        buildBottomButtons(context),
      ]),
    );
  }

  Container buildBottomButtons(BuildContext context) {
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
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextField(
                  controller: _controller,
                  scrollPadding: EdgeInsets.only(bottom: 40),
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: flag
                        ? stringConstant.textFieldHint.toString()
                        : stringConstant.missingText.toString(),
                    hintStyle: flag
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
                    onPress: checkValue,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Container buildImageContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.53,
      child: Column(
        children: [
          Container(
            child: SvgPicture.asset(
              stringConstant.illustrationPath,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
            ),
          ),
          Text(
            stringConstant.letsGetStarted.toString(),
            style: ThemeText.letsGetTextOpenSans,
          ),
          Text(
            stringConstant.letsGetStartedDesc.toString(),
            textAlign: TextAlign.center,
            style: ThemeText.letsGetTextDescOpenSans,
          )
        ],
      ),
    );
  }

  Container buildLogoContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
      child: Container(
        padding:
            EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.1)),
        child: SvgPicture.asset(
          stringConstant.logoPath,
          width: 150,
        ),
      ),
    );
  }
}
