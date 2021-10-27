import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class Helper {
  ///Toast Message
  static showToastFunc(String? message, BuildContext? context, Color color,
      TextStyle? textStyle) {
    showToast(message!,
        context: context!,
        textStyle: textStyle,
        backgroundColor: color,
        animation: StyledToastAnimation.slideFromTopFade,
        reverseAnimation: StyledToastAnimation.slideToTopFade,
        position:
            const StyledToastPosition(align: Alignment.topCenter, offset: 0.0),
        startOffset: const Offset(0.0, -3.0),
        reverseEndOffset: const Offset(0.0, -3.0),
        duration: const Duration(seconds: 4),
        animDuration: const Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn,
        reverseCurve: Curves.fastOutSlowIn);
  }

  static showLoading() {
    EasyLoading.show(maskType: EasyLoadingMaskType.custom);
  }

  static hideLoading() {
    EasyLoading.dismiss();
  }


}
