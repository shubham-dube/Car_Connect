import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final int maxLines;
  final bool expands;
  final TextInputType keyboardType;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    required this.maxLines,
    required this.expands,
    required this.label,
    required this.initialValue,
    required this.keyboardType,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.blue,
      initialValue: initialValue,
      keyboardType: keyboardType,
      maxLines: maxLines,
      expands: expands,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }

}