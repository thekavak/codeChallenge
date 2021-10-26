import 'package:flutter/material.dart';

class StringConstant {
  static StringConstant instance = StringConstant._init();

  StringConstant._init();

  final String letsGetStarted = 'Let\'s Get Started!';
  final String letsGetStartedDesc = 'Paste your fisrt link into \nthe field to shorten it';
  final String textFieldHint = 'Shorten a link here...';
  final String buttonText = 'SHORTEN IT!.';
  final String missingText = 'Please add a link here';

  final String logoPath = 'assets/images/logo.svg';
  final String illustrationPath = 'assets/images/illustration.svg';
  final String shapePath = 'assets/images/shape.svg';

}
