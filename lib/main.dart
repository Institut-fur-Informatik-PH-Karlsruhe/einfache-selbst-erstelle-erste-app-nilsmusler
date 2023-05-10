import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Rechenübungen',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 18, 240, 170)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var number1 = Random().nextInt(90); //Zufalls-Summand 1
  var number2 = Random().nextInt(90); //Zufalls-Summand 2
  String feedback = '';

  //Globale Variable zum Speichern der Texteingabe
  TextEditingController eingabe = TextEditingController();

  void check() {
    //Eingabe in summe_eingabe sichern
    var summe_eingabe = int.parse(
        eingabe.text); //Typenumwandlung von String aus Textfeld nach Integer
    var summe_aufgabe = number1 + number2;

    //prüfen, ob die Eingabe mit dem gerechneten Ergebnis übereinstimmt
    if (summe_eingabe == summe_aufgabe) {
      feedback = "richtig";
    } else {
      feedback = "falsch";
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      //Titelleiste
      appBar: AppBar(
        centerTitle: true,
        title: Text("Übung zur Addition"),
        backgroundColor: Color.fromARGB(255, 18, 240, 170),
      ),

      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Rechenaufgabe (verkettete Strings)
            Text(
              appState.number1.toString() +
                  ' + ' +
                  appState.number2.toString() +
                  ' =',
              style: TextStyle(fontSize: 50),
            ),

            //Lösungseingabe (Textfeld + Button in einer Row)
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly, //verteile auf Bildschirmbreite
              children: [
                //Textfeld Eingabe
                Expanded(
                  child: TextField(
                    controller: appState.eingabe,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Gebe hier deine Lösung ein',
                    ),
                  ),
                ),

                //Antwortbutton
                ElevatedButton(
                  onPressed: () {
                    appState.check();
                  },
                  child: Text('prüfen'),
                ),
              ],
            ),

            //weitere Row für Rückmeldung ob richtig oder falsch
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, //am Bildschirm zentrieren

              children: [
                Text(
                  appState.feedback,
                  style: TextStyle(fontSize: 50, color: Colors.black),
                ), //Rückgabetext
              ],
            ),

            //weitere Row für den 'reset' button

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    appState.check();
                  },
                  child: Text('reset'),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _refresh,
                    child: ListView(children: [
                      // body of above
                    ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final double size;
  final Function onPressed;
  final IconData icon;

  CircleIconButton({this.size = 30.0, this.icon = Icons.clear, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: this.onPressed,
        child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment(0.0, 0.0), // all centered
              children: <Widget>[
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[300]),
                ),
                Icon(
                  icon,
                  size: size * 0.6, // 60% width for icon
                )
              ],
            )));
  }
}

