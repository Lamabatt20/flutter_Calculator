import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 131, 183)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculator'),
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
  String result = '';
  String num1 = '';
  String num2 = '';
  String op = '';
  String display = '';

  void clear() {
    result = '';
    display = '';
    num1 = '';
    num2 = '';
    op = '';
  }

  Widget button({title}) {
    return TextButton(
      onPressed: () {
        if (result != '' &&
            title != '+' &&
            title != '-' &&
            title != '*' &&
            title != '/' &&
            title != '=') {
          clear();
        }
        if (title == 'C') {
          clear();
          setState(() {
            display = '';
          });
        } else if (title == 'X') {
          if (num2 != '') {
            num2 = num2.substring(0, num2.length - 1);
            setState(() {
              display = num1 + ' ' + op + ' ' + num2;
            });
          } else if (op != '') {
            op = '';
            setState(() {
              display = num1;
            });
          } else if (num1 != '') {
            num1 = num1.substring(0, num1.length - 1);
            setState(() {
              display = num1;
            });
          }
        } else if (title == '=') {
          if (op == '' || num1 == '' || num2 == '') {
            clear();
            return;
          }

          if (op == "+") {
            result = (double.parse(num1) + double.parse(num2)).toString();
          } else if (op == "-") {
            result = (double.parse(num1) - double.parse(num2)).toString();
          } else if (op == "*") {
            result = (double.parse(num1) * double.parse(num2)).toString();
          } else if (op == "/") {
            result = (double.parse(num1) / double.parse(num2)).toString();
          }

          setState(() {
            display = result;
          });
        } else if (title == '+' ||
            title == "-" ||
            title == "*" ||
            title == "/") {
          if (num1 == '') return;
          op = title;
          display = num1 + ' ' + op + ' ';
          setState(() {});
        } else if (title == '.') {
          if (op == '' && !num1.contains('.')) {
            num1 += title;
            setState(() {
              display = num1;
            });
          } else if (op != '' && !num2.contains('.')) {
            num2 += title;
            setState(() {
              display = num1 + ' ' + op + ' ' + num2;
            });
          }
        } else {
          if (op == '') {
            num1 += title;
            setState(() {
              display = num1;
            });
          } else if (op != '' && title != '=') {
            num2 += title;
            setState(() {
              display = num1 + ' ' + op + ' ' + num2;
            });
          }
        }
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Text(
                "$display",
                style: TextStyle(fontSize: 24),
              )),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(title: "X"),
                  button(title: "/"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(title: "7"),
                  button(title: "8"),
                  button(title: "9"),
                  button(title: "*"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(title: "4"),
                  button(title: "5"),
                  button(title: "6"),
                  button(title: "-"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(title: "1"),
                  button(title: "2"),
                  button(title: "3"),
                  button(title: "+"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(title: "C"),
                  button(title: "0"),
                  button(title: "."),
                  button(title: "="),
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}
