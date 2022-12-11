import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../size_config.dart';

class SuffixIcon extends StatelessWidget {
  const SuffixIcon({
    Key? key,
    required this.inputIcon,
    this.size,
  }) : super(key: key);

  final String inputIcon;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
        getProportionateScreenWidth(20),
      ),
      child: SvgPicture.asset(
        inputIcon,
        height: size == null
            ? getProportionateScreenWidth(18)
            : getProportionateScreenWidth(size!),
      ),
      // child: Icon(
      //   inputIcon,
      //   size: 32,
      //   color: kSecondaryColor,
      //   ),
      // child:(inputIcon,height: getProportionateScreenWidth(18),
      // ),
    );
  }
}
