import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

userSender(String username, String id){
  http.post(
    Uri.parse('https://calculatornetnode.azurewebsites.net/api/User'),
    body: convert.jsonEncode({
      'userId':id,
      'username':username
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}
