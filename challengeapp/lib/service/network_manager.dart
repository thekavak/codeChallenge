import 'package:challengeapp/constant/application_constant.dart';
import 'package:challengeapp/model/api_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ApiiServices{

  static Future<ShrtcodeModel> purchaseHistory(String url) async {
    try {
      var endpoint = 'shorten?url=${url.toString()}';
      final response = await http.get(
        Uri.https(ApplicationConstants.API_URL, endpoint));
      if (response.statusCode == 200) {
        print(response.body);
        return ShrtcodeModel.fromJson(json.decode(response.body));
      } else {
        throw json.decode(response.body);
      }

    } catch (error) {
      throw error;
    }
  }

}