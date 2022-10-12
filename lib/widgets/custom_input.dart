import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomInput extends StatelessWidget {
  CustomInput({Key? key, required this.title, this.isPassword = false,required this.textController})
      : super(key: key);
  bool isPassword;
  String title;
  TextEditingController textController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: title.text.make(),
        ),
        TextFormField(
          controller: textController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          obscureText: isPassword,
        ),
      ],
    );
  }
}
