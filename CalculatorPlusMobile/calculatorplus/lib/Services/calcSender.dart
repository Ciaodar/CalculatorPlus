import 'package:http/http.dart' as http;
import 'dart:convert';



sendToDotNet(double firn,double secn, String op,String id,String name)async{
  try {
    print('oldum1');
    final response = await http.post(
        Uri.parse('https://calculatornetnode.azurewebsites.net/api/Calculator'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      body:
        jsonEncode({
          "username":name,
          "userId":id,
          "Calculations":
          [{
            "input1":firn,
            "input2":secn,
            "signOperation":op,
          }]
        })
    );
    //print(response.body);
    if(response.statusCode==200){
      print('Calculation request succesfully sent');
    }else{
      print('Calculation request failed. Error code:${response.statusCode}');
    }
  } on Exception catch (e) {
    print('burada error $e');
  }
}