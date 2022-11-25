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
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: TextFormField(
        toolbarOptions: const ToolbarOptions(
          copy: true,
          cut: true,
          paste: false,
          selectAll: false,
        ),
        maxLength: widget.maxLength,
        autovalidateMode: widget.autoValidateMode,
        validator: widget.validator,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
        cursorHeight: 24,
        keyboardType: TextInputType.emailAddress,
        controller: widget.controller,
        cursorWidth: 2,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 17.0, horizontal: 14.0),
          label: Text(
            widget.labelText,
            style: const TextStyle(color: Colors.white38),
          ),
          hintText: widget.hintText,
          fillColor: primaryColor,
          focusColor: primaryColor,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 1.25)),
          enabledBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.white38)),
        ),
      ),
    );
  }
}
