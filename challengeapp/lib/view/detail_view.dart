import 'dart:core';

import 'package:challengeapp/common/helper.dart';
import 'package:challengeapp/constant/styles.dart';
import 'package:challengeapp/core/base/base_state.dart';
import 'package:challengeapp/model/api_model.dart';
import 'package:challengeapp/service/network_manager.dart';
import 'package:challengeapp/widgets/button_bottom.dart';
import 'package:challengeapp/widgets/button_short.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:regexpattern/src/regex_extension.dart';

class DetailPage extends StatefulWidget {
  List<ShrtcodeModel>? dataList;

  DetailPage({Key? key, required this.dataList}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with BaseState {
  final TextEditingController controller = TextEditingController();
  bool flag = true;
  ShrtcodeModel? data;

  @override
  void initState() {
    super.initState();
  }

  copyItem(ShrtcodeModel e) async {
    setState(() {
      e.result!.copied = true;
    });
    Clipboard.setData(ClipboardData(text: e.result!.fullShareLink)).then((_) {
      Helper.showToastFunc(stringConstant.copied, context,
          ThemeText.bottomBoxColor, ThemeText.buttomTextOpenSans);
    });

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      e.result!.copied = false;
    });
  }


  shortenUrl(String Url) async {
    try {
      Helper.showLoading();

      data = await ApiServices.getShortenUrl(Url.toString());
      if (data!.ok == true) {
        setState(() {
          widget.dataList!.add(data!);
        });
          controller.clear();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeText.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: getBody(),
    );
  }

  Widget getBody() {
    return Stack(children: <Widget>[
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height ,
          padding: EdgeInsets.only(
              bottom: (MediaQuery.of(context).size.height * 0.30)),
          child: Column(
            children: [
              buildPageTitle(context),
              widget.dataList!.isEmpty == true
                  ? buildEmptyList()
                  : Column(
                      children: widget.dataList!.reversed
                          .map((e) {
                      return buildItemBox(context, e);
                    }).toList()),
            ],
          ),
        ),
      ),
      Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 0,
        right: 0,
        child: BottomButton(
          flag: flag,
          controller: controller,
          onPress: isValueUrl,
        ),
      ),
    ]);
  }

  Container buildPageTitle(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding:
          EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.05)),
      child: Text(
        stringConstant.urlListText.toString(),
        textAlign: TextAlign.center,
        style: ThemeText.urlListOpenSans,
      ),
    );
  }

  Center buildEmptyList() {
    return Center(
      child: Text(
        stringConstant.urlListEmptyText.toString(),
        textAlign: TextAlign.center,
        style: ThemeText.urlListEmptyOpenSans,
      ),
    );
  }

  Padding buildItemBox(BuildContext context, ShrtcodeModel e) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: ThemeText.whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Text(
                    e.result!.originalLink!,
                    style: ThemeText.urlListOpenSans.copyWith(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.dataList!.removeAt(widget.dataList!.indexOf(e));
                    });
                  },
                  child: Container(
                    child: SvgPicture.asset(
                      stringConstant.delIconPath,
                      width: 15,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  e.result!.fullShortLink!,
                  style: ThemeText.urlListOpenSans
                      .copyWith(fontSize: 20, color: ThemeText.buttonColor),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: ButtonShort(
                    buttonText: e.result!.copied == false
                        ? stringConstant.copy
                        : stringConstant.copied,
                    color: e.result!.copied == false
                        ? ThemeText.buttonColor
                        : ThemeText.bottomBoxColor,
                    heightSize: 40,
                    onPress: () => copyItem(e),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
