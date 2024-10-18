import 'package:flutter/material.dart';

final InputDecoration baseDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.grey, width: 1.5),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2.0),
  ),
);
