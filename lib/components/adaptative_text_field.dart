import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptaviteTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final TextInputType keyboardType;

 const AdaptaviteTextField({
    this.labelText,
    this.controller,
    this.onSubmitted,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: CupertinoTextField(
            placeholder: labelText,
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            padding: EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 12,
            ),
          ),
        )
        : TextField(
            decoration: InputDecoration(
              labelText: labelText,
            ),
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
          );
  }
}
