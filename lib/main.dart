import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: ProFirebaseOptions.current,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueGrey[900],
        backgroundColor: Colors.blueGrey[50],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey[900],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            elevation: 5.0,
            shadowColor: Colors.black,
          ),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 20.0,
            color: Colors.blueGrey[900],
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 16.0,
            color: Colors.blueGrey[900],
          ),
          button: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
          subtitle1: TextStyle(
            fontSize: 14.0,
            color: Colors.blueGrey[900],
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.blueGrey[50],
          contentPadding:
          EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: Colors.blueGrey[400],
          ),
        ),
      ),
      home: Control(),
    );
  }
}

class Control extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ControlState();
  }
}

class ControlState extends State<Control> {
  final databaseReference = FirebaseDatabase.instance.ref();
  final TextEditingController _textController = TextEditingController();
  String _message = '';

  @override
  void initState() {
    super.initState();
    databaseReference.child('message').onValue.listen((event) {
      if (event.snapshot != null && event.snapshot.value != null) {
        setState(() {
          _message = event.snapshot.value.toString();
        });
      } else {
        setState(() {
          _message = 'Körsetıletın habar joq';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jetınşı praktika"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.blueGrey[50],
        body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        TextFormField(
        controller: _textController,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
        hintText: "Habardy engızıñız",
        filled: true,
        fillColor: Colors.blueGrey[100], // change to desired color
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
        ),
      ),
    ),
      SizedBox(height: 24.0),
      ElevatedButton(
        onPressed: () {
          databaseReference.child('message').set(_textController.text);
          _textController.clear();
        },
        child: Text('Jıberu'),
      ),
      SizedBox(height: 24.0),
      Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              _message,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
      ],
    ),
        ),
    );
  }
}