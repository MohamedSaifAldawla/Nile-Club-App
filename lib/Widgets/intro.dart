import 'package:flutter/material.dart';
import 'package:nile_club/theme.dart';

import '../size_config.dart';

class BodyText extends StatelessWidget {
  const BodyText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.weight = FontWeight.normal,
    this.textAlign,
    this.maxLines,
  }) : super(key: key);

  final String text;
  final FontWeight weight;
  final double? fontSize;
  // ignore: prefer_typing_uninitialized_variables
  final color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      // ignore: prefer_if_null_operators
      color: color != null
          ? color
          : Theme.of(context).brightness == Brightness.light
              ? kTextColor
              : kPrimaryLightColor,
      fontSize: fontSize ?? getProportionateScreenWidth(14),
      //decoration: TextDecoration.lineThrough,
      fontWeight: weight,
    );

    return Text(
      text,
      textAlign: textAlign == null ? TextAlign.center : textAlign,
      style: textStyle,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    Key? key,
    required this.text,
    this.color,
  }) : super(key: key);

  final String text;
  // ignore: prefer_typing_uninitialized_variables
  final color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline1,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}

class NormalBodyText extends StatelessWidget {
  const NormalBodyText({
    Key? key,
    required this.text,
    this.color,
    this.fontSize,
    this.weight = FontWeight.normal,
    this.textAlign,
    this.maxLines,
  }) : super(key: key);

  final String text;
  final FontWeight weight;
  final double? fontSize;
  // ignore: prefer_typing_uninitialized_variables
  final color;
  final TextAlign? textAlign;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      // ignore: prefer_if_null_operators
      color: color != null ? color : kTextColor,
      fontSize: fontSize ?? 14,
      fontWeight: weight,
      height: 1.6,
    );

    return Text(
      text,
      textAlign: textAlign == null ? TextAlign.center : textAlign,
      style: textStyle,
    );
  }
}
