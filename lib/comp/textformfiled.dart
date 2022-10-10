import 'package:flutter/material.dart';

class AlterText extends StatelessWidget {
  final String? label;
  final String? Function(String?) valid;
  final TextInputType? type;
  final String? hint;
  final TextEditingController mycontroller;
  const AlterText(
      {Key? key,
      this.hint,
      required this.mycontroller,
      required this.valid,
      this.type,
      this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        keyboardType: type,
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            contentPadding: const EdgeInsets.all(8),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: Colors.purple, width: 1.3))),
      ),
    );
  }
}
