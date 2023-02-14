import 'dart:convert';

import 'package:http/http.dart' as http;

import '../modal/custam_page.dart';



class API {
  API._();
  static final API api = API._();

  Future<Joke?> fetchCurrency() async {
    String api = "https://api.chucknorris.io/jokes/random";

    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      Map decode = jsonDecode(res.body);

      Joke joke = Joke.fromjson(json: decode);

      return joke;
    }
  }
}