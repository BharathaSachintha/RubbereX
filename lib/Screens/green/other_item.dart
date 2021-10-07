import 'package:app/Screens/green/detail_other.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../other.dart';

class OtherItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 35),
          Text('Other', style: TextStyle(color: Colors.grey, fontSize: 17)),
          SizedBox(height: 7),
          Text('Items',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: others.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (_)=>DetailOtherPage(other: others[index],),),);
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Hero(
                                tag: others[index].title,
                                child: Image.network(others[index].image)),
                            SizedBox(height: 10),
                            Text(
                              others[index].title,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              others[index].discription,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "\$${others[index].price}",
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
