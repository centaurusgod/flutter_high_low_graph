import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    title: "Flutter hogh low graoh",
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  double deviceScreenheight = 0;
  double deviceScreenWidth = 0;
  List<FlSpot> highValues = List.empty(growable: true);
  List<FlSpot> lowValues = List.empty(growable: true);
  @override
  void initState() {
    highValues = List.empty(growable: true);
    lowValues = List.empty(growable: true);
    getMinMaxHeartRate();
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceScreenheight = MediaQuery.of(context).size.height;
    deviceScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        //backgroundColor: Color.fromARGB(255, 69, 0, 114),
        backgroundColor: Color.fromARGB(255, 39, 0, 65),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 69, 0, 114),
          centerTitle: true,
          title: Text("High Low Graph"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(children: [
            Container(
              alignment: Alignment.center,
              color: Color.fromARGB(255, 39, 0, 65),
              height: deviceScreenheight / 2,
              width: deviceScreenWidth,
              child: LineChart(
                LineChartData(
                    minX: 0,
                    maxX: 8,
                    minY: 40,
                    maxY: 180,
                    borderData: FlBorderData(
                        show: true,
                        border: Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          bottom: BorderSide(color: Colors.white, width: 2.0),
                          left: BorderSide(color: Colors.white, width: 2.0),
                        )),
                    gridData: FlGridData(
                      drawVerticalLine: true,
                      drawHorizontalLine: true,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.white.withOpacity(0.2),
                          dashArray: [2, 2, 2],
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.white.withOpacity(0.4),
                          dashArray: [2, 2, 2],
                        );
                      },
                    ),

                    //backgroundColor: Colors.black,
                    lineBarsData: [
                      LineChartBarData(
                          // color: Colors.wh,
                          dotData: FlDotData(
                            show: true,
                            // getDotPainter: (p0, p1, p2, p3) {

                            // },
                          ),
                          barWidth: 3.0,
                          spots: lowValues,
                          // [
                          //   // /  const FlSpot(0, 60),
                          //   const FlSpot(1, 65),
                          //   const FlSpot(2, 75),
                          //   const FlSpot(3, 55),
                          //   const FlSpot(4, 62),
                          //   const FlSpot(5, 69),
                          //   const FlSpot(6, 58),
                          //   const FlSpot(7, 50),
                          // ],
                          ),
                      LineChartBarData(
                          color: Color.fromARGB(255, 255, 17, 0),
                          dotData: FlDotData(show: true),
                          barWidth: 3.0,
                           spots: highValues,
                           //[
                          //   // /  const FlSpot(0, 60),
                          //   const FlSpot(1, 90),
                          //   const FlSpot(2, 85),
                          //   const FlSpot(3, 110),
                          //   const FlSpot(4, 120),
                          //   const FlSpot(5, 115),
                          //   const FlSpot(6, 135),
                          //   const FlSpot(7, 120),
                          // ],
                          ),
                    ],
                    titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: mainData(),
                        leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                          reservedSize: 30.0,
                          interval: 20,
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                        )))),
              ),
            ),
            Align(alignment: Alignment.topRight, child: paletteContainer()),
          ]),
        ));
  }

  AxisTitles mainData() {
    return AxisTitles(
        sideTitles: SideTitles(
      //  reservedSize: 400.0,

      showTitles: true,
      getTitlesWidget: (value, meta) {
        switch (value.toInt()) {
          // case 0:return Text("Days:");
          case 1:
            return customStyleText("Mon");
          case 2:
            return customStyleText("Tue");

          case 3:
            return customStyleText("Wed");
          case 4:
            return customStyleText("Thu");
          case 5:
            return customStyleText("Fri");
          case 6:
            return customStyleText("Sat");
          case 7:
            return customStyleText("Sun");

          default:
            return customStyleText("");
        }
      },
    ));
  }

  //function to generte specific color text for button or any datats
  Text customStyleText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.0),
    );
  }

  Container paletteContainer() {
    return Container(
      alignment: Alignment.center,
      color: Colors.transparent,
      width: 90,
      height: 30,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  color: Color.fromARGB(255, 255, 17, 0),
                  width: 50,
                  height: 4,
                ),
                SizedBox(
                  width: 10.0,
                ),
                customStyleText(
                  "High",
                )
              ],
            ),
            Row(
              children: [
                Container(
                  color: Color.fromARGB(255, 0, 188, 212),
                  width: 50,
                  height: 4,
                ),
                SizedBox(
                  width: 10.0,
                ),
                customStyleText(
                  "Low",
                )
              ],
            ),
          ]),
    );
  }
  //function to find max and minimum data from json

  Future<void> getMinMaxHeartRate() async {
    int min = 1, max = 0, data = 0, count = 0;
    try {
      String jsonString = await rootBundle.loadString('assets/data.json');
      dynamic jsondata = json.decode(jsonString);
      // /  print(jsondata[0]);
      // print(jsondata);
//now time to finx maximum and minimum values from
//an array
      for (String key in jsondata.keys) {
        // print(key); // Print the key

        // print(jsondata[key].length());
        count++;
        min = jsondata[key][0];
        max = min;
        for (int i = 0; i < jsondata[key].length; i++) {
          //  print("before errro");

          data = jsondata[key][i].toInt();
          // print(data);
          if (data == 0) continue;

          // print("after errro");
          if (min > data) {
            min = data;
            //  print("Min:$min");
          }
          if (max < data) {
            // print("Min:$max");
            max = data;
          }
        }
      //  print(key + " min:" + min.toString());
        lowValues.add(FlSpot(count.toDouble(), min.toDouble()));
      //  print(key + " max:" + max.toString());
        highValues.add(FlSpot(count.toDouble(), max.toDouble()));
      }

    //  print(highValues);
    } catch (error) {
      print(error);
    }
    setState(() {
      
    });
  }
}
