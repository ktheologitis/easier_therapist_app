import 'package:flutter/material.dart';

import '../styles/colorsIcons.dart';

typedef Action = void Function();

class FloatingButton extends StatelessWidget {
  FloatingButton(
      {required this.color,
      this.icon,
      required this.title,
      required this.action});

  final Color color;
  final String title;
  final Icon? icon;
  final Action action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return color;
            }
            return color; // Use the component's default.
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
      ),
      onPressed: () {
        action();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Row(
          children: <Widget>[
            if (icon != null) icon as Widget,
            if (icon != null)
              SizedBox(
                width: 16.0,
              ),
            Text(
              title,
              style: Theme.of(context).textTheme.button,
            ),
          ],
        ),
      ),
    );
  }
}
