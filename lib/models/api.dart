import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class Api {
  String url = 'http://10.2.2.203:8080/identityiq/ui/rest/workItems/';
  String auth = "Basic c2FpbHBvaW50Lm1hbmFnIDpNM3gxY2gzbSMyMDE5";
  List data;
  Future<String> makeRequest() async {
    final response = await http.get(
      Uri.decodeFull(url),
      headers: {
        HttpHeaders.authorizationHeader: auth,
      },
    );

    if (response.statusCode == 200) {
      // se o servidor retornar um response OK, vamos fazer o parse no JSON
      setState(() {
        final extractdata = json.decode(response.body);
        data = extractdata["objects"];
      });
    } else {
      // se a responsta não for OK , lançamos um erro
      throw Exception('Failed to load post');
    }
  }

  void setState(Null Function() param0) {
    makeRequest();
  }
}
