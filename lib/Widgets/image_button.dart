import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../size_config.dart';
import '../theme.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    Key? key,
    required this.text,
    required this.image,
    required this.press,
  }) : super(key: key);

  final String text, image;
  final void Function()? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenWidth(50),
      child: InkWell(
        onTap: press,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).brightness == Brightness.light
                ? kPrimaryLightColor
                : kPrimaryDark3Color,
            border: Border.all(
              color: kPrimary2Color,
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 46, 51, .1),
                blurRadius: 10,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: Theme.of(context).brightness == Brightness.light
                      ? kTextColor
                      : kPrimaryLightColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(150),
              Image.asset(
                image,
                height: getProportionateScreenHeight(40),
                width: getProportionateScreenWidth(40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

























      // child:TextButton(
      //   onPressed: press as void Function(),
      //   style: TextButton.styleFrom(
      //     shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      //     primary: Colors.white,
      //     backgroundColor: kPrimaryColor,
      //     elevation: 9.0,
      //     shadowColor:kPrimaryColor,
      //   ),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //      SizedBox(width: getProportionateScreenWidth(80)),
      //       Text(
      //         text,
      //         style: TextStyle(
      //           fontSize: getProportionateScreenWidth(18),
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //      SizedBox(width: getProportionateScreenWidth(60)),
      //      SvgPicture.asset(
      //         "assets/icons/Lock.svg",
      //         height: getProportionateScreenWidth(18),
      //         color: Colors.white,
      //       ),
      //      //Icon(Icons.login_outlined,size: 32,),
      //     ],
      //   ),
      // ),

      // @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton.icon(
//         onPressed: press as void Function(),
//         icon: Icon(Icons.login_outlined),
//         label: Text(text),
//         style: ElevatedButton.styleFrom(
//         primary:kPrimaryColor,
//         elevation: 6,
//         shadowColor: kPrimaryColor,
//          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),
//          textStyle: TextStyle(
//            fontSize: getProportionateScreenWidth(18),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }


  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 56,
  //     child: TextButton(
  //       style: TextButton.styleFrom(
  //         shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //         primary: Colors.white,
  //         backgroundColor: kPrimaryColor,
  //         elevation: 9,
  //         shadowColor:kPrimaryColor, 
  //       ),
  //       onPressed: press as void Function(),
  //       child: Text(
  //         text,
  //         style: TextStyle(
  //           fontSize: getProportionateScreenWidth(18),
  //           color: Colors.white,
  //           fontWeight: FontWeight.bold,
  //           //letterSpacing: 2,
  //         ),
  //       ),
  //     ),
  //   );
  // }