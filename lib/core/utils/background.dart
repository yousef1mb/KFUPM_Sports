import 'package:flutter/material.dart';
import 'package:kfupm_sports/core/theme/theme.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        gradient: AppTheme.lightGradiant,
        

      ),
      child: child,
    );
  }
}