import 'package:flutter/material.dart';
///All the string values I use
class StringConstant {
  static StringConstant instance = StringConstant._init();

  StringConstant._init();
  final String letsGetStarted = 'Let\'s Get Started!';
  final String letsGetStartedDesc = 'Paste your fisrt link into \nthe field to shorten it';
  final String textFieldHint = 'Shorten a link here...';
  final String buttonText = 'SHORTEN IT!.';
  final String missingText = 'Please add a link here';
  final String urlListText = 'Your Link History';
  final String urlListEmptyText = 'Your Link History Empty';
  final String urlListEmpty = 'Listeniz Boş';
  final String urlFormat = 'Lütfen Geçerli Url Giriniz!';
  final String apiError = 'Api Hatası Oluştu!';
  final String somethinqError = 'Bir şeyler Yanlış Gitti!';
  final String copy = 'COPY';
  final String copied = 'COPIED!';

  final String logoPath = 'assets/images/logo.svg';
  final String illustrationPath = 'assets/images/illustration.svg';
  final String shapePath = 'assets/images/shape.svg';
  final String delIconPath = 'assets/images/del.svg';

}
