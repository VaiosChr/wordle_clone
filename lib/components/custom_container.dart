import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double padding;

  const CustomContainer({super.key, required this.child, this.padding = 16.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20,
            color: Theme.of(context).hoverColor.withOpacity(0.1),
          )
        ],
      ),
      child: child,
    );
  }
}
