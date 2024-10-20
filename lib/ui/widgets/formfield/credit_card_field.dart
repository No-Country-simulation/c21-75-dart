import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../style/styles.dart';

class CreditCardField extends StatefulWidget {
  final TextEditingController controller;

  const CreditCardField({super.key, required this.controller});

  @override
  State<CreditCardField> createState() => _CreditCardFieldState();
}

class _CreditCardFieldState extends State<CreditCardField> {
  static const int _maxLength = 16;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLength: _maxLength,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Solo números
      decoration: baseDecoration.copyWith(
        labelText: "Número de Tarjeta",
        hintText: "XXXX XXXX XXXX XXXX",
        prefixIcon: const Icon(Icons.credit_card),
      ),
      onChanged: (value) {
        // Elimina cualquier carácter que no sea numérico.
        widget.controller.text = _filterNumbers(value);
        widget.controller.selection = TextSelection.fromPosition(
          TextPosition(offset: widget.controller.text.length),
        );
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, ingresa el número de tarjeta';
        }
        if (value.length != _maxLength) {
          return 'La tarjeta debe tener 16 dígitos';
        }
        return null;
      },
    );
  }

  /// Función para eliminar caracteres no numéricos.
  String _filterNumbers(String input) {
    final numericRegex = RegExp(r'[0-9]');
    return input.split('').where((char) => numericRegex.hasMatch(char)).join();
  }
}
