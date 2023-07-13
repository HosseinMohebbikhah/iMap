// ignore_for_file: file_names, depend_on_referenced_packages, camel_case_types, non_constant_identifier_names, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:imap/Classes/infoPoint.dart';

class getServer {
  dynamic getInfoPoint(double Lat, double Lng) async {
    _request req2Server = _request();
    Map<String, String> headers = {
      //You can get an API_KEY from themohebbikhah.ir site, after registration, it will show you its API_KEY.
      "Api-Key": "API_KEY"
    };
    dynamic resultFromServer = await req2Server.get(
      "LocationServices?func=p2a&lat=${Lat}&lng=${Lng}",
      headers: headers,
    );

    if (resultFromServer['ok']) {
      return infoPoint.fromJson(jsonDecode(resultFromServer['data']));
    }
    return false;
  }
}

class _request {
  final String baseUrl = "https://api.themohebbikhah.ir/v1";

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    var response =
        await http.get(Uri.parse('$baseUrl/$endpoint'), headers: headers);
    if (response.statusCode == 200) {
      return {'ok': true, 'data': json.decode(response.body)['data']};
    } else {
      return {'ok': false};
    }
  }

  Future<dynamic> post(String endpoint, dynamic data,
      {Map<String, String>? headers}) async {
    var response = await http.post(Uri.parse('$baseUrl/$endpoint'),
        body: json.encode(data), headers: headers);
    if (response.statusCode == 200) {
      return {'ok': true, 'data': json.decode(response.body)['data']};
    } else {
      return {'ok': false};
    }
  }
}
