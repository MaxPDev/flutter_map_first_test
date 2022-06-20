import 'dart:convert';

import 'package:http/http.dart';
import 'package:fr_piscadev_osmtest/models/overpass_query.dart';
import 'package:xml/xml.dart';

class OverpassAPI {

  //todo variable global
  static String _apiUrl = 'overpass-api.de';
  static String _path = '/api/interpreter';

  OverpassAPI() {
    print("OverpassAPI Constructor");
  }

  /**
   * Execute la réquete
   * en récupérant le body [requestBody]
   */
  static Future<String> fetch(String requestBody) async {
    Request request = Request('GET', Uri.https(_apiUrl, _path));
    request.bodyFields = _bodyToMap(requestBody);

    String responseText;

    try {
      StreamedResponse response = await Client()
        .send(request)
        .timeout(const Duration(seconds: 5));
      
      responseText = await response.stream.bytesToString();
    }
        catch (exception) {
      print(exception);
      return Future.error(exception);
    }

    var responseJson;

    try {
      responseJson = jsonDecode(responseText);
      print(responseJson);
      return responseJson;
    }
    catch (exception) {
      String error = '';
      final document = XmlDocument.parse(responseText);
      final paragraphs = document.findAllElements("p");

      paragraphs.forEach((element) {
        if (element.text.trim() == '') {
          return;
        }

        error += '${element.text.trim()}';
      });

      return Future.error(error);
    }

    // if (responseJson['elements'] == null) {
    //   return [];
    // }
  }

  static Map<String, String>_bodyToMap(requestBody) {
    return <String, String> {
      'data': requestBody
    };
  }


}