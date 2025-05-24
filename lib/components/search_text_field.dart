import 'package:flutter/material.dart';

TextField buildSearchTextField(TextEditingController controller,
    FocusNode focusNode, Function(String) onChanged) {
  return TextField(
    controller: controller,
    focusNode: focusNode,
    decoration: InputDecoration(
      hintText: 'uuid',
      hintStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w100,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // 去除边框
      ),
    ),
    onChanged: onChanged,
  );
}
