import 'package:flutter/material.dart';

class TransferidosFeature extends StatelessWidget {
  final String transfersTxt;

  TransferidosFeature(this.transfersTxt);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 100,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.list,
            color: Colors.white,
            size: 24.0,
          ),
          Text(
            transfersTxt,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          )
        ],
      ),
    );
  }
}
