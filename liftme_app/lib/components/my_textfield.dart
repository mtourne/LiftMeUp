import 'package:flutter/material.dart';
import '../constants.dart';


class MyTextField extends StatelessWidget {
    final controller;
    final String hintText;
    final bool obscureText;

    const MyTextField({
        super.key,
        required this.controller,
        required this.hintText,
        this.obscureText = false,
    });

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: kColorSwatch.shade100,
                    filled: true,
                    hintText: hintText,
                ),
            ),
        );
    }
}