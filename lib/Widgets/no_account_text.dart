import 'package:flutter/material.dart';
import 'package:nile_club/theme.dart';

import 'intro.dart';

class NoAccountText extends StatelessWidget {
  final String text1;
  final String text2;
  const NoAccountText({
    Key? key,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BodyText(
          text: text1,
        ),
        GestureDetector(
          onTap: () {},
          child: BodyText(
            text: text2,
            color: kPrimary2Color,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
