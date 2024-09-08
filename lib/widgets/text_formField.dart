import 'package:flutter/material.dart';

class RoundedTextFormField extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final void Function(String?) onChanged;

  const RoundedTextFormField({
    Key? key,
    this.obscureText = false,
    required this.textEditingController,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(67, 71, 77, 0.08),
            spreadRadius: 10,
            blurRadius: 40,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          ),
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                prefixIcon,
                size: 25,
                color: Colors.blue,
              ),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(131, 143, 160, 100),
              ),
              hintText: hintText,
              errorStyle: TextStyle(height: 0), // To keep the error text height zero
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
