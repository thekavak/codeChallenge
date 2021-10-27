import 'package:challengeapp/constant/application_constant.dart';
import 'package:challengeapp/model/api_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<ShrtcodeModel> getShortenUrl(String url) async {
    try {
      var endpoint = 'v2/shorten?url=${url.toString()}';
      final response =
          await http.get(Uri.https(ApplicationConstants.apiUrl, endpoint));
      if (response.statusCode >= 200 || response.statusCode < 300) {
        return ShrtcodeModel.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }
    } catch (error) {
      throw error;
    }
  }
}
