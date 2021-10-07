import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class Category extends StatelessWidget {
  String image;
  String text;
  Color color;
  final Function press;
  Category({this.image, this.text, this.color, this.press});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Color(0x9F81B622)),
        child: Column(
          children: [
            Image.network(
              image,
              width: 100,
              height: 100,
            ),
            SizedBox(
              height: 1,
            ),
            Text(
              text,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onTap: press,
    );
  }
}
