import 'package:flutter/material.dart';

import 'colors.dart';

class DividerConstant extends StatelessWidget {
  const DividerConstant({
    super.key,
    required this.dark, this.text ='' ,
  });

  final bool dark;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Divider(
            color: dark ? xColors.darkgrey : xColors.grey,
            thickness: 2,
            indent: 40,
            endIndent: 5,
          ),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Flexible(
          child: Divider(
            color: dark ? xColors.darkgrey : xColors.grey,
            thickness: 2,
            indent: 5,
            endIndent: 40,
          ),
        ),
      ],
    );
  }
}
