import 'package:flutter/material.dart';

class ProfileDetail extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetail(this.label, this.value, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Text(
        label,
        style: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        )
      ),
       Text(
        value,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge!.color
        )
      )
    ],
    );
  }
}