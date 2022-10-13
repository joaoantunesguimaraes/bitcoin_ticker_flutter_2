// Nesta versão não está a ser utilizado


import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  // Atributos - Constantes
  final String url;
  // Construtor
  NetworkHelper(this.url);


  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      String data = response.body;
      print('data: $data');
      print('jsonDecode(data): ${jsonDecode(data)}');

      return jsonDecode(data);
    } else {
      print('response.statusCode: ');
      print('response.statusCode: ${response.statusCode}');
    }
  }
}