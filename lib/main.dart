import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  WinAppPage createState() => WinAppPage();
}

class WinAppPage extends State<MyApp> {
  final List<String> _measure = [
    'meters',
    'kilometres',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds',
    'ounces',
  ];

  String endValue = "0";
  late String _startM;
  late String _endM;
  late int _startI;
  late int _endI;

  final _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0, 0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0, 02835, 3.28084, 0, 0.0625, 1],
  ];

  final valueController = TextEditingController();

  @override
  void initState() {
    _startI = 0;
    _endI = 1;
    _startM = _measure[_startI];
    _endM = _measure[_endI];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontSize: 20);
    const measureStyle = TextStyle(fontSize: 20);

    return FluentApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SIMPLE APP Converter"),
          backgroundColor: const Color.fromARGB(200, 0, 0, 0),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
            child: Column(
              children: [
                const Text("Enter a number", style: labelStyle),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: valueController,
                  decoration: const InputDecoration(
                      hintText: "Enter a number",
                      contentPadding: EdgeInsets.all(9.0)),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text("FROM", style: labelStyle),
                const SizedBox(
                  height: 8,
                ),
                DropdownButton<String>(
                    isExpanded: true,
                    value: _startM,
                    items: _measure.map((m) {
                      return DropdownMenuItem(
                          value: m,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              m,
                              style: measureStyle,
                            ),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _startM = value!;
                        _startI = _measure.indexOf(_startM);
                      });
                    }),
                const SizedBox(
                  height: 8,
                ),
                const Text("TO", style: labelStyle),
                const SizedBox(
                  height: 8,
                ),
                DropdownButton<String>(
                    value: _endM,
                    isExpanded: true,
                    items: _measure.map((m) {
                      return DropdownMenuItem(
                          value: m,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              m,
                              style: measureStyle,
                            ),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _endM = value!;
                        _endI = _measure.indexOf(_endM);
                      });
                    }),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: MaterialButton(
                    minWidth: 150.0,
                    height: 65,
                    color: const Color.fromARGB(255, 253, 136, 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: const Text(
                      'CONVERT',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(237, 255, 255, 255)),
                    ),
                    onPressed: () {
                      try {
                        // get user value
                        final value = double.parse(valueController.text.trim());

                        setState(() {
                          // apply calculations
                          endValue = "${value * _formulas[_startI][_endI]}";
                        });

                        FocusScope.of(context).requestFocus(FocusNode());
                      } catch (e) {
                        print("Enter a valid value");
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('Result: $endValue $_endM', style: labelStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
