import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  AddButton({@required this.onPressed});
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
    );
  }
}
