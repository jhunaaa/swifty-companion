import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';
import 'dart:convert';


var token = "";

Future<bool> getToken() async {
  final apiSecret = dotenv.get("42_SECRET");
  final apiUID = dotenv.get("42_UID");
  final uri = Uri.parse("https://api.intra.42.fr/oauth/token").replace(
    queryParameters: {
      'grant_type': 'client_credentials',
      'client_secret': apiSecret,
      'client_id': apiUID,
    },
  );
  final response = await http.post(uri);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    token = data['access_token'];
  } else {
    return (true);
  }
  return (false);
}

Future<String> getProfile(String name) async {
  if (name.isEmpty) {
    return ("No name entered");
  } else {

    if (token.isEmpty) {
      bool errorToken = await getToken();
      if (errorToken) {
        return ("Error, couldn't get a new token");
      }
      return ("got a new token ! : $token");
    }
    final uri = Uri.parse("https://api.intra.42.fr/v2/users/$name");

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      }
    );

    if (response.statusCode == 200) {
      log(response.body);
    } else if (response.statusCode == 404) {
      return ("User not found");
    } else {
      return ("Got problem with 42 API");
    }

    return ("");
  }
}

// get token 42 = https://api.intra.42.fr/oauth/token
// grant_type = client_credentials
// client_id = UID
// client_secret = SECRET
// get access_token

// get info by login = https://api.intra.42.fr/v2/users/$(searchValue)
// Authorization: Bearer = retour de oauth token