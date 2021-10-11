import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BlocContainer extends StatelessWidget{}
Future<void> push (BuildContext blocContext, BlocContainer container) async {
  Navigator.of(blocContext).push(
    MaterialPageRoute(
      builder: (context) => container,
    ),
  );
}