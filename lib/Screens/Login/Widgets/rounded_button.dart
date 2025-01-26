import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final String text;
  final bool isLoading;
  const RoundedButton(
      {super.key,
      required this.color,
      required this.onTap,
      required this.text,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 125,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: color),
        child: Center(
          child: isLoading ? CircularProgressIndicator() : Text(text),
        ),
      ),
    );
  }
}
