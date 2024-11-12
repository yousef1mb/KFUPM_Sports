import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/theme.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: AppTheme.lightGradiant,
      ),
      child: child,
    );
  }
}
