import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para usar TextInputFormatter
import '../../style/styles.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;

  const PhoneNumberField({super.key, required this.controller});

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  String _selectedCountryCode = '+1'; // Código de país inicial

  final List<Map<String, String>> _countryCodes = [
    {'code': '+1', 'country': 'Estados Unidos'},
    {'code': '+52', 'country': 'México'},
    {'code': '+44', 'country': 'Reino Unido'},
    {'code': '+91', 'country': 'India'},
    {'code': '+33', 'country': 'Francia'},
    {'code': '+49', 'country': 'Alemania'},
    {'code': '+81', 'country': 'Japón'},
    {'code': '+55', 'country': 'Brasil'},
    {'code': '+61', 'country': 'Australia'},
    {'code': '+86', 'country': 'China'},
    {'code': '+34', 'country': 'España'},
    {'code': '+39', 'country': 'Italia'},
    {'code': '+7', 'country': 'Rusia'},
    {'code': '+41', 'country': 'Suiza'},
    {'code': '+46', 'country': 'Suecia'},
    {'code': '+31', 'country': 'Países Bajos'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: DropdownButton<String>(
              value: _selectedCountryCode,
              onChanged: (value) {
                setState(() {
                  _selectedCountryCode = value!;
                });
              },
              underline: const SizedBox(),
              items: _countryCodes.map((country) {
                return DropdownMenuItem<String>(
                  value: country['code'],
                  child: Text(
                    '${country['code']}',
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.phone,
              maxLength: 10, // Limita la longitud del número
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly, // Solo permite números
              ],
              decoration: baseDecoration.copyWith(
                hintText: "123 456 7890",
                border: InputBorder
                    .none, // Elimina el borde para que parezca un único campo
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa tu número de teléfono';
                }
                if (value.length < 10) {
                  return 'Número no válido';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
