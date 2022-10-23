import 'package:flutter/material.dart';

import '../screens/LoginPage.dart';

class KFieldWidget extends StatefulWidget {
  const KFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.validator,
    this.autoValidateMode,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final int? maxLength;

  @override
  State<KFieldWidget> createState() => _KFieldWidgetState();
}

class _KFieldWidgetState extends State<KFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        maxLength: widget.maxLength,
        autovalidateMode: widget.autoValidateMode,
        validator: widget.validator,
        style: TextStyle(color: primaryColor),
        textAlign: TextAlign.center,
        cursorHeight: 25,
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
        cursorWidth: 1,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          label: Text(
            widget.labelText,
            style: TextStyle(color: primaryColor),
          ),
          hintText: widget.hintText,
          fillColor: primaryColor,
          focusColor: primaryColor,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: primaryColor, width: 1.25)),
          enabledBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: primaryColor)),
        ),
      ),
    );
  }
}