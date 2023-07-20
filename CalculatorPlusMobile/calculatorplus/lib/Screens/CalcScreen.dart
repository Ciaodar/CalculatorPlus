import 'package:flutter/material.dart';
import 'package:calculatorplus/colors.dart';
import '../Services/historyChecker.dart';
import '../Services/calcSender.dart';



class CalcScreen extends StatefulWidget {
  const CalcScreen({Key? key}) : super(key: key);

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  //Variables
  double? firstnumber;
  double? secondnumber;
  String? id='64b3f50f2b0cd7d0071d33f0';
  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;






  onButtonClick(value) {
    if (value == 'AC') {
      firstnumber=null;
      secondnumber=null;
      operation='';
      input = '';
      output = '';
    } else if( value =='H'){
      //historyCheck(id);
    } else if (value == '<') {
      if (input.isNotEmpty) {
        if(input.substring(input.length-1,input.length)==' '){
          input = input.substring(0, input.length - 2);
        }
        else {
          input = input.substring(0, input.length - 1);
        }


      }
    }
    else if (value == '=') {
      if (input.isNotEmpty) {
        List<String> parts = input.split(" "); // Split the string by space

        firstnumber = double.parse(parts[0]); // Convert the first part to a double
        operation = parts[1]; // Get the operation as a String
        secondnumber = double.parse(parts[2]); // Convert the second part to a double

        //sendToDotNet(firstnumber!,secondnumber!,operation);

        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52.0;
      }
    }else if ( value == '*' || value == '/' || value == '-' || value == '+') {
      if(input==''||input.substring(input.length) == '*' || input.substring(input.length) == '/' || input.substring(input.length) == '-' || input.substring(input.length) == '+'){
        return;
      }
      else {
        if(!(input.contains('+')||input.contains('-')||input.contains('*')||input.contains('/'))) {
          firstnumber = double.parse(input);
          operation = value;
          input = '$input $value ';
          hideInput = false;
          outputSize = 34.0;
        }
        else{
          return;
        }
      }
    }
    else {
      input = input + value;
      hideInput = false;
      outputSize = 34.0;
    }
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    final dsize=MediaQuery.of(context).size;
    var reverserow=false;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text(
          "Calculator+",
          style: TextStyle(
            color: orangecolor,
          ),
        ),
        backgroundColor: operatorcolor,
        actions: [
          Container(margin: const EdgeInsets.only(right: 50), child: IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert,color: orangecolor,))),
        ],
      ),
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Placeholder(),
          Container(
            width: dsize.width/3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Input and output area
                Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          hideInput ? '' : input,
                          style: const TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          output,
                          style: TextStyle(
                            fontSize: outputSize,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    )
                ),
                Row(children: [
                  button(
                      text: 'AC', buttonBGcolor: operatorcolor, tColor: orangecolor),
                  button(
                      text: '<', buttonBGcolor: operatorcolor, tColor: orangecolor),
                  button( text: 'H', buttonBGcolor: operatorcolor, tColor: orangecolor),
                  button(
                      text: '/', buttonBGcolor: operatorcolor, tColor: orangecolor),
                ]),
                Row(children: [
                  button(text: '7'),
                  button(text: '8'),
                  button(text: '9'),
                  button(
                      text: '*', tColor: orangecolor, buttonBGcolor: operatorcolor),
                ]),
                Row(children: [
                  button(text: '4'),
                  button(text: '5'),
                  button(text: '6'),
                  button(
                      text: '-', tColor: orangecolor, buttonBGcolor: operatorcolor),
                ]),
                Row(children: [
                  button(text: '1'),
                  button(text: '2'),
                  button(text: '3'),
                  button(
                      text: '+', tColor: orangecolor, buttonBGcolor: operatorcolor),
                ]),
                Row(children: [
                  button(
                      text: '%', tColor: orangecolor, buttonBGcolor: operatorcolor),
                  button(text: '0'),
                  button(text: '.'),
                  button(text: '=', buttonBGcolor: orangecolor),
                ]),
              ],
            ),
          ),
          Placeholder(),
        ],
      ),
    );
  }
  Widget button({text, tColor = Colors.white, buttonBGcolor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.all(22),
              backgroundColor: buttonBGcolor,
            ),
            onPressed: () => onButtonClick(text),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: tColor,
                fontWeight: FontWeight.bold,
              ),
            )
        ),
      ),
    );
  }
}
