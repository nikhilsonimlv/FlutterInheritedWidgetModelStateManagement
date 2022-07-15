import 'dart:math';

import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var color1= Colors.purple[400];
  var color2 = Colors.yellow[500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: AvailableColorsModel(
        color1: color1,
        color2: color2,
        child: Column(
          children: [
            Row(
              children: [
                TextButton(onPressed: () {
                  setState((){
                   color1 =  colors.getRandomElement();
                  });
                }, child: const Text("Change 1")),
                TextButton(
                  onPressed: () {
                    setState((){
                      color2 =  colors.getRandomElement();
                    });                  },
                  child: const Text("Change 2"),
                ),
              ],
            ),
            const ColorWidget(color: AvailableColors.color1),
            const ColorWidget(color: AvailableColors.color2),
          ],
        ),
      ),
    );
  }
}

enum AvailableColors { color1, color2 }

/**
 * This method is called by descendant, it provides copy of the aspect parameters
 */
class AvailableColorsModel extends InheritedModel<AvailableColors> {
  final Color? color1;
  final Color? color2;

  const AvailableColorsModel({Key? key, required this.color1, required this.color2, required Widget child}) : super(key: key, child: child);

  //This function is used to get copy of parameters
  static AvailableColorsModel of(BuildContext context, AvailableColors aspect) {
    return InheritedModel.inheritFrom<AvailableColorsModel>(context, aspect: aspect)!;
  }

  @override
  bool updateShouldNotify(covariant AvailableColorsModel oldWidget) {
    devtools.log("updateShouldNotify");
    return color1 != oldWidget.color1 || color2 != oldWidget.color2;
  }

  // if updateShouldNotify returns true then flutter calls updateShouldNotifyDependent()
  @override
  bool updateShouldNotifyDependent(covariant AvailableColorsModel oldWidget, Set<AvailableColors> dependencies) {
    devtools.log("updateShouldNotifyDependent");
    if (dependencies.contains(AvailableColors.color1) && color1 != oldWidget.color1) {
      return true;
    }
    if (dependencies.contains(AvailableColors.color2) && color2 != oldWidget.color2) {
      return true;
    }

    return false;
  }
}

class ColorWidget extends StatelessWidget {
  final AvailableColors color;

  const ColorWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case AvailableColors.color1:
        devtools.log("Color 1 has rebuilt");
        break;
      case AvailableColors.color2:
        devtools.log("Color 2 has rebuilt");
        break;
    }

    final provider = AvailableColorsModel.of(context, color);

    return Container(
      height: 150,
      color: color == AvailableColors.color1 ? provider.color1 : provider.color2,
    );
  }
}

final colors = [
  Colors.redAccent,
  Colors.yellow,
  Colors.blue,
  Colors.brown,
  Colors.deepOrange,
  Colors.cyanAccent,
  Colors.lightGreenAccent,
  Colors.purpleAccent,
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(Random().nextInt(length));
}

//Basic Inherited widget
/*void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: ApiProvider(api: Api(), child: const MyHomePage()),
    );
  }
}

class ApiProvider extends InheritedWidget{
  final Api api;
  final String uuid;

  ApiProvider({Key? key,required this.api,required Widget child}):uuid = const Uuid().v4(),super(key: key,child: child);

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    return uuid !=oldWidget.uuid;
  }

  static ApiProvider of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueKey _textKey = const ValueKey<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ApiProvider.of(context).api.dateAndTime??""),
      ),
      body: GestureDetector(
        onTap: () async{
          final api = ApiProvider.of(context).api;
          final dateTime = await api.getDateAndTime();
          setState(() {
            _textKey = ValueKey(dateTime);
          });
        },
        child: Container(color: Colors.white,child: DateTimeWidget(key: _textKey),),
      ),
    );
  }
}

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateAndTime ??"Tap tp get data ");
  }
}

class Api {
  String? dateAndTime;
  Future<String> getDateAndTime() {
    return Future.delayed(const Duration(seconds: 1), () => DateTime.now().toIso8601String()).then((value) {
      dateAndTime = value;
      return value;
    });
  }
}*/
