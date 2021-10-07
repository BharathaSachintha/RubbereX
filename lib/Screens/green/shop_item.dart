import 'package:app/Screens/green/detail_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../items.dart';

class ShopItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Text('Shop', style: TextStyle(color: Colors.grey, fontSize: 17)),
          SizedBox(height: 7),
          Text('Knife',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (_)=>DetailItemPage(items: items[index],),),);
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                                tag: items[index].title,
                                child: Image.network(items[index].image)),
                            SizedBox(height: 10),
                            Text(
                              items[index].title,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              items[index].discription,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "\$${items[index].price}",
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  child:
                                      Text("+", style: TextStyle(fontSize: 22)),
                                  onPressed: () {},
                                )
                              ],
                            ),
                            SizedBox(height: 30),
                            Divider(),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
