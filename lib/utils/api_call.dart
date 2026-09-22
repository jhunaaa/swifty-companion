import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

var token = "";

Future<String> getProfile(String name) async {
  if (name.isEmpty) {
    return ("No name entered");
  } else {
    final apiSecret = dotenv.get("42_SECRET");
    final apiUID = dotenv.get("42_UID");
    if (token.isEmpty) {
      final uri = Uri.parse("https://api.intra.42.fr/oauth/token").replace(
          queryParameters: {
            'grant_type': 'client_credentials',
            'client_secret': apiSecret,
            'client_id': apiUID,
          },
        );
      final response = await http.get(uri);
      log('data: ${response.body}');
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