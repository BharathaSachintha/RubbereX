import 'package:app/Forcast/other/weatherController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final weatherController wc = Get.put(weatherController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: wc.have.value == true
                ? Text(
                    "Next best time to cut rubber latex: " +
                        wc.finalBestStartTime.value.toString() +
                        " to " +
                        wc.finalBestEndTime.value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                : Text(
                    "No any proper time to cut rubber latex",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
      ),
    );
  }
}
