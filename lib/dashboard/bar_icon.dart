import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
// ignore: camel_case_types
class Bar_Category extends StatelessWidget {
  String image;
  final Function press;
  Bar_Category({this.image, this.press});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 40,
        child: Column(
          children: [
            Image.network(
              image,
              width: 30,
              height: 30,
            ),
          ],
        ),
      ),
      onTap: press,
    );
  }
}
