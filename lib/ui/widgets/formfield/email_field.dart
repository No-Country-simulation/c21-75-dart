import 'package:flutter/material.dart';

import '../../style/styles.dart';

class CustomEmailField extends StatelessWidget {
  final TextEditingController controller;

  const CustomEmailField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: baseDecoration.copyWith(
        //labelText: "Correo Electrónico",
        hintText: "ejemplo@correo.com",
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa tu correo';
        }
        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
        if (!emailRegex.hasMatch(value)) {
          return 'Correo no válido';
        }
        return null;
      },
    );
  }
}
