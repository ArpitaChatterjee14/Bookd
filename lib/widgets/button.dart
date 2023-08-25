import 'package:flutter/material.dart';

class ButtonConfig extends StatelessWidget {
  final String buttonVal;
  final void Function() nav;
  final double h;
  final double w;

  const ButtonConfig(
      {super.key,
      required this.buttonVal,
      required this.nav,
      required this.w,
      required this.h});

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: nav,
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          textStyle: const TextStyle(fontSize: 18),
          elevation: 10,
          minimumSize: Size(w, h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
      child: Text(buttonVal),
    );
  }
}

class TextButtonConfig extends StatelessWidget {
  final String buttonVal;
  final void Function() nav;

  const TextButtonConfig(
      {super.key, required this.buttonVal, required this.nav});

  @override
  Widget build(context) {
    return TextButton(
      onPressed: nav,
      child: Text(buttonVal),
    );
  }
}
