import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String _message;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Text(_message)
          ],
        ),
      ),
    );
  }

  Progress(this._message);
}
