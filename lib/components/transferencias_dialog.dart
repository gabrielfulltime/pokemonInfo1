import 'package:flutter/material.dart';

class TransferenciasDialog extends StatelessWidget {

  final Function(String password) onConfirm;
  final TextEditingController _passController = TextEditingController();

  TransferenciasDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Autenticação"),
      content: TextField(
        controller: _passController,
        keyboardType: TextInputType.numberWithOptions(),
        maxLength: 4,
        decoration: InputDecoration(border: OutlineInputBorder()),
        textAlign: TextAlign.end,
        obscureText: true,
        style: TextStyle(fontSize: 64, letterSpacing: 24),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            onConfirm(_passController.text);
            Navigator.pop(context);
          },
          child: Text("Confirm"),
        )
      ],
    );
  }
}
