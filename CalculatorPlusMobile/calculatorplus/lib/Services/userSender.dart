import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

userSender(String username, String id)async{
  try {
    final res = await http.post(
      Uri.parse('https://calculatornetnode.azurewebsites.net/api/User'),
      body: convert.jsonEncode({
        'userId':id,
        'username':username
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if(res.statusCode==200){
      print('User has been Sent Successfully');
    }
    else{
      print('Api server error. Code: ${res.statusCode}');
    }
  } on Exception catch (e) {
    print('Error while sending username to api: $e');
  }
}
