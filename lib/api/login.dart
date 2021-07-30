import 'dart:convert';
import 'package:family_buy/models/response_model.dart';
import 'package:http/http.dart' as http;

import 'package:family_buy/common/api.dart';

Future checkAuth() async {
  try {
    Uri url = Uri.parse('$serverIp');
    final http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      final ResponseBody body = ResponseBody(
          body: json.decode(response.body), status: response.statusCode);
    } else {}
  } catch (e) {}
}
