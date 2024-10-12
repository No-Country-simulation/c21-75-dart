import 'package:flutter/material.dart';
import '../../style/styles.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool autofocus;

  const CustomPasswordField({
    super.key,
    required this.controller,
    this.label = "Contraseña",
    this.autofocus = false,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      obscureText: _obscureText,
      autofocus: widget.autofocus,
      decoration: baseDecoration.copyWith(
        //labelText: widget.label,
        hintText: "Ingrese su contraseña",
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });

            // Mantiene la posición del cursor al cambiar la visibilidad
            widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length),
            );
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa tu contraseña';
        }
        if (value.length < 6) {
          return 'La contraseña debe tener al menos 6 caracteres';
        }
        if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
            !RegExp(r'\d').hasMatch(value)) {
          return 'La contraseña debe incluir letras y números';
        }
        return null;
      },
    );
  }
}
