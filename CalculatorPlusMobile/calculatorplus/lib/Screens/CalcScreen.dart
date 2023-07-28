
import 'package:flutter/material.dart';
import 'package:calculatorplus/colors.dart';
import 'package:provider/provider.dart';
import '../Providers/User.dart';
import '../Services/historyChecker.dart';
import '../Services/calcSender.dart';
import '../Storage/checkSign.dart';

class CalcScreen extends StatefulWidget {
  const CalcScreen({Key? key}) : super(key: key);
  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  //Variables
  double? firstnumber;
  double? secondnumber;
  var input = '';
  String output='';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  @override
  void initState() {
    if(context.read<User>().uid==null) {
      checkSign(context);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (context.read<User>().output!=null) {
      output=context.watch<User>().output!;
    }
    else {
      output='';
    }
    onButtonClick(value) {
      final user = context.read<User>();
      if (value == 'C') {
        firstnumber = null;
        secondnumber = null;
        operation = '';
        input = '';
        context.read<User>().output = '';
      } else if (value == 'H') {
        historyCheck(user.uid, context);
      } else if (value == '<') {
        if (input.isNotEmpty) {
          if (input.substring(input.length - 1, input.length) == ' ') {
            input = input.substring(0, input.length - 2);
          } else {
            input = input.substring(0, input.length - 1);
          }
        }
      } else if (value == '=') {
        context.read<User>().output=null;
        if (input.isNotEmpty) {
          List<String> parts = input.split(" ");


          if (parts.length==3) {
            firstnumber =
                double.parse(parts[0]);
            operation = parts[1];
            secondnumber =
                double.parse(parts[2]);
          }else{
            return;
          }

          sendToDotNet(
              firstnumber!, secondnumber!, operation, user.uid!, user.name!);

          hideInput = true;
          outputSize = 52.0;
        }
      } else if (value == '*' || value == '/' || value == '-' || value == '+') {
        if (input == '' ||
            input.substring(input.length) == '*' ||
            input.substring(input.length) == '/' ||
            input.substring(input.length) == '-' ||
            input.substring(input.length) == '+') {
          return;
        } else {
          if (!(input.contains('+') ||
              input.contains('-') ||
              input.contains('*') ||
              input.contains('/'))) {
            firstnumber = double.parse(input);
            operation = value;
            input = '$input $value ';
            hideInput = false;
            outputSize = 34.0;
          } else {
            return;
          }
        }
      } else {
        input = input + value;
        hideInput = false;
        outputSize = 34.0;
      }
      setState(() {});
    }

    Widget button({text, tColor = Colors.white, buttonBGcolor = buttonColor}) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
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
              )),
        ),
      );
    }

    final dsize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Calculator+",
          style: TextStyle(
            color: orangecolor,
          ),
        ),
        backgroundColor: operatorcolor,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert,color: orangecolor,),
            onSelected: (value){
              switch (value){
                case 'resign':
                  delSign(context);
                  print('deleting user.');
                  Navigator.of(context).pushNamed('/sign');
                  break;
                case 'deletechat':
                  print('deleting the chat messages');
                  setState(() {
                    context.read<User>().chatlist.clear();
                  });
                  break;
              }

            },
            itemBuilder: (BuildContext context2) =>
            <PopupMenuItem> [
              const PopupMenuItem(
                value: 'resign',
                  child: Text('Resign'),
              ),
              const PopupMenuItem(
                value: 'deletechat',
                child: Text('Delete Chat'),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          dsize.width > 1280
              ? Container(
                  width: dsize.width / 3,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: orangecolor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: operatorcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: const Text(
                                "History:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: orangecolor,
                                  fontSize: 56,
                                ),
                              )),
                          Container(
                            alignment: Alignment.center,
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    context.read<User>().historylist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final item =
                                      context.watch<User>().historylist[index];
                                  return InkWell(
                                    splashColor: Colors.white,
                                    onTap: (){print("object");},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 50),
                                      child: Text(
                                        "${item.input1.toStringAsFixed(0)} "
                                            "${item.operation} "
                                            "${item.input2.toStringAsFixed(0)} = "
                                            "${item.result?.toStringAsFixed(0)}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          Container(
            width: dsize.width > 1280
                ? dsize.width / 3
                : dsize.width > 640
                    ? dsize.width / 2
                    : dsize.width,
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
                          output.endsWith(".0")?output.substring(0,output.length-2):output,
                          style: TextStyle(
                            fontSize: outputSize,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          hideInput ? '' : input,
                          style: const TextStyle(
                            fontSize: 48,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    )),
                Row(children: [
                  button(
                      text: 'C',
                      buttonBGcolor: operatorcolor,
                      tColor: orangecolor),
                  button(
                      text: '<',
                      buttonBGcolor: operatorcolor,
                      tColor: orangecolor),
                  button(
                      text: 'H',
                      buttonBGcolor: operatorcolor,
                      tColor: orangecolor),
                  button(
                      text: '/',
                      buttonBGcolor: operatorcolor,
                      tColor: orangecolor),
                ]),
                Row(children: [
                  button(text: '7'),
                  button(text: '8'),
                  button(text: '9'),
                  button(
                      text: '*',
                      tColor: orangecolor,
                      buttonBGcolor: operatorcolor),
                ]),
                Row(children: [
                  button(text: '4'),
                  button(text: '5'),
                  button(text: '6'),
                  button(
                      text: '-',
                      tColor: orangecolor,
                      buttonBGcolor: operatorcolor),
                ]),
                Row(children: [
                  button(text: '1'),
                  button(text: '2'),
                  button(text: '3'),
                  button(
                      text: '+',
                      tColor: orangecolor,
                      buttonBGcolor: operatorcolor),
                ]),
                Row(children: [
                  button(
                      text: '%',
                      tColor: orangecolor,
                      buttonBGcolor: operatorcolor),
                  button(text: '0'),
                  button(text: '.'),
                  button(text: '=', buttonBGcolor: orangecolor),
                ]),
              ],
            ),
          ),
          dsize.width > 640
              ? Container(
                  width: dsize.width > 1280
                      ? dsize.width / 3
                      : dsize.width > 640
                          ? dsize.width / 2
                          : 0,
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: orangecolor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: operatorcolor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 30),
                              child: const Text(
                                "Chat:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: orangecolor,
                                  fontSize: 56,
                                ),
                              )),
                          Container(
                            child: ListView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: context.watch<User>().chatlist.length,
                              itemBuilder: (BuildContext context, int index) {
                                final user = context.read<User>();
                                final item = user.chatlist[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 50),
                                  child: Text(
                                    "${item.name}: "
                                    "${item.input1.toStringAsFixed(0)} "
                                    "${item.operation} "
                                    "${item.input2.toStringAsFixed(0)} = "
                                    "${item.result?.toStringAsFixed(0)}",
                                    style: TextStyle(
                                      color: user.uid == item.id
                                          ? Colors.blue
                                          : Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
