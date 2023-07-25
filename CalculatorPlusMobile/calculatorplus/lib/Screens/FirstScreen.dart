import 'package:calculatorplus/Services/userSender.dart';
import 'package:calculatorplus/Storage/setStorage.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:calculatorplus/colors.dart';

import '../Providers/User.dart';
class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final namecontroller= TextEditingController();
    final dsize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: buttonColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50,bottom: 100),
              alignment: Alignment.center,
              child: const Text(
                "Online Calculator+'a Hoş Geldin.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: orangecolor,
                  fontSize: 72,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: const Text(
                "Bir kullanıcı adı belirler misin?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: orangecolor,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              width: dsize.width/4,
              decoration: BoxDecoration(
                color: operatorcolor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: namecontroller,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: orangecolor,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  alignLabelWithHint: true,
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    color:Colors.white30
                  )
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(22),
                    backgroundColor: buttonColor,
                  ),
                onPressed: (){
                  final id = const Uuid().v1();
                  final user = context.read<User>();
                  user.updateUserInfo(uid: id,name: namecontroller.text,checkedIn: true);
                  setStorage(user);
                  userSender(namecontroller.text, id);
                  Navigator.of(context).pop();
                }, child: const Text(
                'K',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              )
            )
          ],
        ),
      ),
    );
  }
}
