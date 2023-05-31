import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({this.url});

  final Uri? url;

  Future getData() async {
    if (url == null) {
      return;
    }
    http.Response response = await http.get(url!);

    if (response.statusCode == 200) {
      String data = response.body;
      var jsonData = jsonDecode(data);
      return jsonData;
    } else {
      print(response.statusCode);
    }
  }
}
