import 'package:flutter/material.dart';

class GridTile extends StatelessWidget {
  final String letter;
  const GridTile({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Text(
        letter,
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
