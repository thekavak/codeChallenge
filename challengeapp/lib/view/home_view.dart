import 'dart:convert';
import 'dart:io';

import 'package:challengeapp/common/helper.dart';
import 'package:challengeapp/constant/styles.dart';
import 'package:challengeapp/core/base/base_state.dart';
import 'package:challengeapp/model/api_model.dart';
import 'package:challengeapp/service/network_manager.dart';
import 'package:challengeapp/widgets/button_bottom.dart';
import 'package:challengeapp/widgets/button_short.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  shortenUrl(String Url) async {
    try {
      Helper.showLoading();

      data = await ApiServices.getShortenUrl(Url.toString());
      if (data!.ok == true) {
        setState(() {
          jsonList.add(data!);
        });

        Navigator.of(context)
            .push(MaterialPageRoute<Null>(
                builder: (BuildContext context) {
                  return DetailPage(dataList: jsonList);
                },
                fullscreenDialog: true))
            .then((value) {
          controller.clear();
        });
        Helper.hideLoading();
      } else {
        Helper.hideLoading();
        Helper.showToastFunc(stringConstant.somethinqError, context,ThemeText.bottomBoxColor, ThemeText.buttomTextOpenSans);
      }
    } catch (e) {
      Helper.hideLoading();
      Helper.showToastFunc(stringConstant.apiError, context,  ThemeText.bottomBoxColor, ThemeText.buttomTextOpenSans);
      throw e;
    }
  }

  isValueUrl() async {
    if (controller.text.isEmpty) {
      setState(() {
        flag = false;
      });
    } else {
      if (!controller.text.isUrl()) {
        Helper.showToastFunc(stringConstant.urlFormat, context,
            ThemeText.bottomBoxColor, ThemeText.buttomTextOpenSans);
      } else {
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
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              buildLogoContainer(context),
              buildImageContainer(context),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0,
        right: 0,
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
