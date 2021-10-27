import 'dart:convert';
import 'dart:io';

import 'package:challengeapp/common/helper.dart';
import 'package:challengeapp/constant/styles.dart';
import 'package:challengeapp/core/base/base_state.dart';
import 'package:challengeapp/model/api_model.dart';
import 'package:challengeapp/service/network_manager.dart';
import 'package:challengeapp/widgets/button_bottom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regexpattern/regexpattern.dart';

import 'detail_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with BaseState {
  final TextEditingController controller = TextEditingController();
  bool flag = true;
  ShrtcodeModel? data;
  List<ShrtcodeModel> jsonList = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  ///At first I wanted to have 2 data in my hand,
  ///I kept it as local json..
  Future<void> readJson() async {
    try {
      final String response = await rootBundle.loadString('assets/list.json');
      final data = await json.decode(response);
      Iterable list = data;
      setState(() {
        jsonList = list.map((i) => ShrtcodeModel.fromJson(i)).toList();
      });
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  ///Api Function
  shortenUrl(String Url) async {
    try {
      ///I started the loading dialog.
      Helper.showLoading();

      data = await ApiServices.getShortenUrl(Url.toString());
      ///If your response from api is data.ok == true
      ///I've added this to my temporary list.
      if (data!.ok == true) {
        setState(() {
          jsonList.add(data!);
        });

        ///I sent the list I have to the listing page as an argument.
        Navigator.of(context)
            .push(MaterialPageRoute<Null>(
            builder: (BuildContext context) {
              return DetailPage(dataList: jsonList);
            },
            fullscreenDialog: true))
            .then((value) {
          ///I cleared the textfield when pressing the back button.
          controller.clear();
        });
        Helper.hideLoading();
      } else {
        Helper.hideLoading();
        /// If there is an error during other operations when the correct result is received from the API

        Helper.showToastFunc(stringConstant.somethinqError, context,ThemeText.bottomBoxColor, ThemeText.buttomTextOpenSans);
      }
    } catch (e) {
      Helper.hideLoading();
      /// I added it against an api network-related problem.

      Helper.showToastFunc(stringConstant.apiError, context,  ThemeText.bottomBoxColor, ThemeText.buttomTextOpenSans);
      throw e;
    }
  }

  ///Flag : 'Please add a link here' to show an error message in red if the box is empty inside
  isValueUrl() async {
    if (controller.text.isEmpty) {
      setState(() {
        flag = false;
      });
    } else {
      ///To find out if the entered value is a Url
      ///I used regex library
      if (!controller.text.isUrl()) {
        Helper.showToastFunc(stringConstant.urlFormat, context,
            ThemeText.bottomBoxColor, ThemeText.buttomTextOpenSans);
      } else {
        ///Here both the url and if it's not empty, send it to the above function.
        await shortenUrl(controller.text);
        setState(() {
          flag = true;
        });
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeText.backgroundColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    return Stack(children: <Widget>[
      GestureDetector(
        onTap: () {
          ///When the keyboard is open, clicking any blank area to close it.
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              ///Creating a Logo
              buildLogoContainer(context),
              ///Creating a Image
              buildImageContainer(context),
            ],
          ),
        ),
      ),
      ///BottomFixed Url textfield part
      Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0,
        right: 0,
        ///Flag: The true false value I sent against being empty
        ///Controller : Controller of the textfield on this page
        ///isValueUrl: my method.
        child: BottomButton(flag: flag,controller: controller,onPress: isValueUrl,),
      ),
    ]);
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
