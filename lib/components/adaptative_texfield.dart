import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdaptativeTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String titleLabel;
  final Function(String)? onSubmitted;
  final String? prefix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const AdaptativeTextfield({
    super.key,
    this.inputFormatters,
    this.prefix,
    this.keyboardType,
    required this.titleLabel,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 50,
            margin: const EdgeInsets.only(
              bottom: 10,
            ),
            child: CupertinoTextField(
              controller: controller,
              placeholder: titleLabel,
              onSubmitted: onSubmitted,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              prefix: Text(prefix ?? ''),
            ),
          )
        : TextField(
            onSubmitted: onSubmitted,
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              labelText: titleLabel,
              prefix: Text(prefix ?? ''),
            ),
          );
  }
}
