import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../data_exception.dart';
import 'base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  /// GET API FUNCTIONALITY ///

  @override
  Future getApi(String url) async {
    dynamic responseJson;

    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('Please connect to Internet!');
    } on RequestTimeOutException {
      throw RequestTimeOutException('Try Again!');
    }
    return responseJson;
  }



  /// RETURN RESPONSE ///

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      default:
        throw FetchDataCommunicationException(
            'Error accord in communicating ${response.statusCode}');
    }
  }
}
