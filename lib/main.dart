import 'package:flutter/material.dart';
import 'package:temperature_convertor/colors.dart';

void main() {
  runApp(const TemperatureConvertor());
}

class TemperatureConvertor extends StatelessWidget {
  const TemperatureConvertor({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Temperature Convertor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double inTemp = 0.0, outTemp = 0.0;
  String output_temp = "";

  // Initial Selected Value
  String dropdownvalueIn = 'Celsius';
  String dropdownvalueOut = 'Celsius';

  // List of items in our dropdown menu
  var items = [
    'Celsius',
    'Fahrenheit',
    'Kelvin',
  ];

  String bg_string_image = 'assets/images/winter.png';
  //animated container
  List<Color> colorList = [
    Colors.blue.shade200,
    Colors.lightBlue,
    Colors.blue.shade600,
    Colors.indigo
  ];
  List<Alignment> alignmentList = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];
  int index = 0;
  Color bottomColor = Colors.blue.shade200;
  Color topColor = Colors.blue.shade600;
  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    //for starting the animation automatically from backround color
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          if ((inTemp >= 30 && dropdownvalueIn == "Celsius") ||
              (inTemp >= 86 && dropdownvalueIn == "Fahrenheit") ||
              (inTemp >= 303.15 && dropdownvalueIn == "Kelvin")) {
            bottomColor = Colors.orangeAccent.shade400;
          }

          if ((inTemp <= 0 && dropdownvalueIn == "Celsius") ||
              (inTemp <= 32 && dropdownvalueIn == "Fahrenheit") ||
              (inTemp <= 273.15 && dropdownvalueIn == "Kelvin")) {
            bottomColor = Colors.blue.shade600;
          }

          if (((inTemp >= 14 && inTemp <= 29) &&
                  dropdownvalueIn == "Celsius") ||
              ((inTemp >= 57.2 && inTemp <= 84.2) &&
                  dropdownvalueIn == "Fahrenheit") ||
              ((inTemp >= 287.15 && inTemp <= 302.15) &&
                  dropdownvalueIn == "Kelvin")) {
            bottomColor = Colors.yellow.shade400;
          }
        }));

    var backgroundColor = backgroundColor_cold;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(widget.title, style: TextStyle(color: Colors.white)),
        ),
        body: AnimatedContainer(
          duration: Duration(seconds: 2),
          onEnd: () {
            setState(() {
              //to reset the background color
              if ((inTemp >= 30 && dropdownvalueIn == "Celsius") ||
                  (inTemp >= 86 && dropdownvalueIn == "Fahrenheit") ||
                  (inTemp >= 303.15 && dropdownvalueIn == "Kelvin")) {
                // backgroundColor = backgroundColor_hot;
                // bg_string_image = 'assets/images/summer.png';
                List<Color> colorListHot = [
                  Colors.orangeAccent.shade400,
                  Colors.yellow.shade800,
                  Colors.yellowAccent.shade700,
                  Colors.orange,
                  Colors.deepOrange
                ];

                colorList.removeRange(0, colorList.length);
                colorList.addAll(colorListHot);
                bottomColor = Colors.yellow;
              }

              if ((inTemp <= 0 && dropdownvalueIn == "Celsius") ||
                  (inTemp <= 32 && dropdownvalueIn == "Fahrenheit") ||
                  (inTemp <= 273.15 && dropdownvalueIn == "Kelvin")) {
                // backgroundColor = backgroundColor_cold;
                // bg_string_image = 'assets/images/winter.png';

                List<Color> colorListCold = [
                  Colors.blue.shade200,
                  Colors.blue.shade600,
                  Colors.indigo.shade400,
                  Colors.deepPurpleAccent,

                ];
                colorList.removeRange(0, colorList.length);
                colorList.addAll(colorListCold);
                bottomColor = Colors.blue.shade600;
              }

              if (((inTemp >= 14 && inTemp <= 29) &&
                      dropdownvalueIn == "Celsius") ||
                  ((inTemp >= 57.2 && inTemp <= 84.2) &&
                      dropdownvalueIn == "Fahrenheit") ||
                  ((inTemp >= 287.15 && inTemp <= 302.15) &&
                      dropdownvalueIn == "Kelvin")) {
                // backgroundColor = backgroundColor_med;
                // bg_string_image = 'assets/images/winter.png';
                List<Color> colorListMed = [
                  Colors.red.shade400,
                  Colors.orangeAccent.shade200,
                  Colors.yellow.shade600
                ];
                colorList.removeRange(0, colorList.length);
                colorList.addAll(colorListMed);
                bottomColor = Colors.orangeAccent.shade200;
              }
              index = index + 1;
              // animate the color
              bottomColor = colorList[index % colorList.length];
              topColor = colorList[(index + 1) % colorList.length];
            });
          },
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              gradient: LinearGradient(
                  begin: begin, end: end, colors: [bottomColor, topColor])),
          child: Center(
            child: Container(
              width: deviceWidth * 0.9,
              height: deviceHight * 0.5,
              child: Card(
                elevation: 30,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.black12,
                  ),
                  borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                ),
                // color: backgroundColor,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 5),
                                  width: deviceWidth * 0.45,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        labelText: dropdownvalueIn,
                                        labelStyle:
                                            TextStyle(color: Color(0xff000000)),
                                        hintText: "Temperature",
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                              width: 2,
                                            )),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                              color: Colors.black54,
                                              width: 2,
                                            ))),
                                    onChanged: (value) {
                                      setState(() {
                                        try {
                                          inTemp = double.parse(value);
                                        } catch (e) {}
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "INPUT",
                                  style:
                                      TextStyle(fontSize: deviceWidth * 0.03),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, left: 20),
                                  child: DropdownButton(
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalueIn = newValue!;
                                      });
                                    },
                                    value: dropdownvalueIn,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  width: deviceWidth * 0.45,
                                  height: 65,
                                  child: Center(
                                      child: Text(
                                    output_temp,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: deviceWidth * 0.04),
                                  )),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 2),
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "OUTPUT",
                                  style:
                                      TextStyle(fontSize: deviceWidth * 0.03),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, right: 1),
                                  child: DropdownButton(
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalueOut = newValue!;
                                      });
                                    },
                                    value: dropdownvalueOut,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: items.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: deviceHight * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              primary: Colors.black45,
                              fixedSize: const Size(200, 50),
                              shadowColor: Colors.black12,
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            onPressed: () {
                              if (dropdownvalueIn == "Celsius" &&
                                  dropdownvalueOut == "Fahrenheit") {
                                outTemp = inTemp * (9 / 5) + 32;
                                output_temp = "${outTemp.toStringAsFixed(3)}  F";
                              }
                              if (dropdownvalueIn == "Celsius" &&
                                  dropdownvalueOut == "Celsius") {
                                outTemp = inTemp;
                                output_temp =
                                    "${outTemp.toStringAsFixed(3)}  C";
                              }
                              if (dropdownvalueIn == "Celsius" &&
                                  dropdownvalueOut == "Kelvin") {
                                outTemp = inTemp + 273.15;
                                output_temp =
                                    "${outTemp.toStringAsFixed(3)}  K";
                              }
                              if (dropdownvalueIn == "Fahrenheit" &&
                                  dropdownvalueOut == "Celsius") {
                                outTemp = (inTemp - 32) * (5 / 9);
                                output_temp =
                                    "${outTemp.toStringAsFixed(3)}  C";
                              }
                              if (dropdownvalueIn == "Fahrenheit" &&
                                  dropdownvalueOut == "Fahrenheit") {
                                outTemp = inTemp;
                                output_temp =
                                    "${outTemp.toStringAsFixed(3)}  F";
                              }
                              if (dropdownvalueIn == "Fahrenheit" &&
                                  dropdownvalueOut == "Kelvin") {
                                outTemp = (inTemp - 32) * (5 / 9) + 273.15;
                                output_temp =
                                    "${outTemp.toStringAsFixed(3)}  K";
                              }
                              if (dropdownvalueIn == "Kelvin" &&
                                  dropdownvalueOut == "Kelvin") {
                                outTemp = inTemp;
                                output_temp =
                                    "${outTemp.toStringAsFixed(3)}  K";
                              }
                              if (dropdownvalueIn == "Kelvin" &&
                                  dropdownvalueOut == "Celsius") {
                                outTemp = inTemp - 273.15;
                                output_temp =
                                    "${outTemp.toStringAsFixed(3)}  C";
                              }
                              if (dropdownvalueIn == "Kelvin" &&
                                  dropdownvalueOut == "Fahrenheit") {
                                outTemp = (inTemp - 273.15) * (9 / 5) + 32;
                                output_temp =
                                    "${outTemp.toStringAsFixed(3)}  F";
                              }
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.downloading_outlined,
                              size: 25,
                            ),
                            label: Text(
                              "Convert",
                              style: TextStyle(
                                  fontSize: deviceWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
