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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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

  void check(){
    //Eingabe in summe_eingabe sichern
    var summe_eingabe = int.parse(eingabe.text); //Typenumwandlung von String aus Textfeld nach Integer
    var summe_aufgabe = number1 + number2;
    

    //prüfen, ob die Eingabe mit dem gerechneten Ergebnis übereinstimmt
    if(summe_eingabe == summe_aufgabe) {
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
          backgroundColor: Colors.green,
        ),
        

        
        body: Container(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            
            
            children: [
              //Rechenaufgabe (verkettete Strings)
              Text(appState.number1.toString()+' + '+appState.number2.toString()+' =',style: TextStyle(fontSize: 60),),

              //Lösungseingabe (Textfeld + Button in einer Row)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //verteile auf Bildschirmbreite
                children: [
                
                //Textfeld Eingabe
                Expanded(child:
                  TextField(
                    controller: appState.eingabe,
                    decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Lösung',
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
                
                mainAxisAlignment: MainAxisAlignment.center, //am Bildschirm zentrieren

                children: [
                Text(appState.feedback,style: TextStyle(fontSize: 50,color: Colors.black),), //Rückgabetext
              ],
              )
            ],
          ),
        ),
        );
  }
}
