import 'package:flutter/material.dart';

class TopNavBar extends StatelessWidget {
  final String category;
  const TopNavBar({super.key, required this.category});

  @override
  Widget build(context) {
    return AppBar(
      title: Text(category),
    );
  }
}
