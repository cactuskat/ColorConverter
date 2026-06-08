import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      home: LandingPage(),
    );
  }
}

// A StatefulWidget is required because state changes (units, background color)
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  // App Color changing behavior
  static const List<MapEntry<Color, Color>> themes = [
    MapEntry(Color.fromARGB(255, 141, 100, 196), Color.fromARGB(255, 76, 14, 110)),
    MapEntry(Color.fromARGB(255, 188, 144, 128), Colors.brown),
    MapEntry(Colors.lightGreen, Colors.lime),
    MapEntry(Colors.blue, Colors.lightBlueAccent),
    MapEntry(Color.fromARGB(255, 206, 111, 142), Color.fromARGB(255, 123, 31, 62))];

  int counter = 0;
  void _increment() {
    setState(() {
      counter++;
       if (counter >= themes.length) {
        counter = 0;
      }
    });
  }

  // Converting Units
  final _formKey = GlobalKey<FormState>();

  String? fromUnit;
  String? toUnit;
  double amount = 0;
  String result = " ";

  // converting everything to ounce first then to the 'toUnit'
  double convertUnit(double amount, String fromUnit, String toUnit) {
    double ounce;

    if (fromUnit == 'ounce') {
      ounce = amount;
    } else if (fromUnit == 'pound') {
      ounce = amount * 16;
    } else {
      ounce = amount / 28.3;
    }

    if (toUnit == 'ounce') {
      return ounce;
    } else if (toUnit == 'pound') {
      return ounce / 16;
    } else {
      return ounce * 28.3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final barColor = themes[counter].key;
    final bodyColor = themes[counter].value;

    final barTextColor =
        ThemeData.estimateBrightnessForColor(barColor) == Brightness.dark
            ? Colors.white
            : Colors.black;

    final bodyTextColor =
        ThemeData.estimateBrightnessForColor(bodyColor) == Brightness.dark
            ? Colors.white
            : Colors.black;

    return GestureDetector(
      onTap: _increment,
      child: Scaffold(
        backgroundColor: bodyColor,
        appBar: AppBar(
          title: Text(
            "Unit Converter",
            style: TextStyle(color: barTextColor),
          ),
          backgroundColor: barColor,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Select units, enter a value, and press Submit.',
                  style: TextStyle(color: bodyTextColor),
                ),
                SizedBox(height: 20),
                Text(
                  'Convert From',
                  style: TextStyle(color: bodyTextColor),
                ),

                DropdownButtonFormField<String>(
                  initialValue: fromUnit,
                  items: [
                    DropdownMenuItem(value: 'gram', child: Text('Gram', style: TextStyle(color: barTextColor))),
                    DropdownMenuItem(value: 'pound', child: Text('Pound', style: TextStyle(color: barTextColor))),
                    DropdownMenuItem(value: 'ounce', child: Text('Ounce', style: TextStyle(color: barTextColor))),
                  ],
                  onChanged: (value) {
                    setState(() {
                      fromUnit = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a unit';
                    }
                    return null;
                  },
                  dropdownColor: barColor,
                ),

                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Enter Amount',
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a value';
                    }

                    final number = double.tryParse(value);

                    if (number == null) {
                      return 'Numbers only';
                    }

                    if (number < 0) {
                      return 'Must be 0 or greater';
                    }

                    return null;
                  },
                  onSaved: (value) {
                    amount = double.parse(value!);
                  },
                  style: TextStyle(
                    color: bodyTextColor,
                  ),
                ),

                Text(
                  'Convert To',
                  style: TextStyle(color: bodyTextColor),
                ),

                DropdownButtonFormField<String>(
                  initialValue: toUnit,
                  items: [
                    DropdownMenuItem(value: 'gram', child: Text('Gram', style: TextStyle(color: barTextColor))),
                    DropdownMenuItem(value: 'pound', child: Text('Pound', style: TextStyle(color: barTextColor))),
                    DropdownMenuItem(value: 'ounce', child: Text('Ounce', style: TextStyle(color: barTextColor))),
                  ],
                  onChanged: (value) {
                    setState(() {
                      toUnit = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a unit';
                    }
                    return null;
                  },
                  dropdownColor: barColor,
                ),
                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final convertedAmount = convertUnit(
                        amount,
                        fromUnit!,
                        toUnit!,
                      );

                      setState(() {
                        result = convertedAmount.toStringAsFixed(1);
                      });
                    }
                  },
          
                  child: Text('Submit', style: TextStyle(color: barTextColor)),
                  style: ElevatedButton.styleFrom(backgroundColor: barColor),
                ),

                SizedBox(height: 40),

                Text(
                  result,
                  style: TextStyle(color: bodyTextColor, fontSize: 24),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}