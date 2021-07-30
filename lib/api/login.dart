import 'dart:convert';
import 'package:family_buy/models/response_model.dart';
import 'package:http/http.dart' as http;

import 'package:family_buy/common/api.dart';

Future checkAuth() async {
  try {
    Uri url = Uri.parse('$serverIp');
    final http.Response response = await http.get(url);
    Response complitedResponse;
    if (response.statusCode == 200) {
      ResponseSuccess responseSuccess =
          ResponseSuccess(body: json.decode(response.body));
      complitedResponse =
          Response(body: responseSuccess, status: response.statusCode);
    } else {
      ResponseFailure responseFailure =
          ResponseFailure(body: json.decode(response.body));
      complitedResponse =
          Response(body: responseFailure, status: response.statusCode);
    }
    return complitedResponse;
  } catch (e) {
    final ResponseFailure responseFailure =
        ResponseFailure(error: e.toString());
    return Response(body: responseFailure, status: null);
  }
}
