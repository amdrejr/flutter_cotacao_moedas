import 'package:flutter/material.dart';

import '../app_collors.dart';

Widget buildTextField({
  required String label,
  required String prefix,
  required TextEditingController controller,
  Function(String)? func,
}) {
  return TextField(
    controller: controller,
    onChanged: (String value) {
      func!(value);
    },
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
      labelText: label,
      prefixText: prefix,
    ),
    style: TextStyle(fontSize: 25, color: AppCollor.secondary),
  );
}

BoxDecoration containerDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.amber.shade100, width: 3),
  );
}
