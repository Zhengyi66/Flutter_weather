import 'package:flutter/material.dart';


class ProgressView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }

}