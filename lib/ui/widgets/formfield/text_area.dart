import 'package:flutter/material.dart';

import '../../style/styles.dart';

class CustomTextArea extends StatelessWidget {
  final TextEditingController controller;

  const CustomTextArea({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 5,
      decoration: baseDecoration.copyWith(
        labelText: "Descripción",
        hintText: "Escribe aquí...",
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa una descripción';
        }
        return null;
      },
    );
  }
}
