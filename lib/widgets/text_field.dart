import 'package:flutter/material.dart';

class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final IconButton? suffixIcon;

  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    this.suffixIcon,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();

}
  class _TextFieldInputState extends State<TextFieldInput> {

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: Divider.createBorderSide(context),
    );

    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        fillColor: Color.fromARGB(120, 0, 0, 0),
        hintText: widget.hintText,
        suffixIcon: widget.suffixIcon,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(10),
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPass,
    );
  }
}