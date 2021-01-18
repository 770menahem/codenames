import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newkodenames/firebase/service/authService.dart';
import 'package:newkodenames/obj/MyUser.dart';
import 'package:newkodenames/screen/GameMenu.dart';
import 'package:newkodenames/screen/HomePage.dart';
import 'package:newkodenames/screen/register.dart';
import 'package:provider/provider.dart';

import 'Const.dart';
import 'screen/signin.dart';
import 'screen/AddWord.dart';
import 'screen/Game.dart';
import 'Loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider<Showmap>(create: (_) => showmap),
        ChangeNotifierProvider<GroupPoint>(create: (_) => groupPoints),
        // ChangeNotifierProvider<WordToFind>(create: (_) => wordToFind),
        // ChangeNotifierProvider<Clue>(create: (_) => clue),
        StreamProvider<MyUser>.value(value: AuthService().user),
      ],
      child: MaterialApp(
        title: 'code names',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/home",
        routes: <String, WidgetBuilder>{
          "/home": (BuildContext context) => HomePage(),
          "/game": (BuildContext context) => Game(),
          "/addWord": (BuildContext context) => AddWord(),
          "/signin": (BuildContext context) => SignIn(),
          "/register": (BuildContext context) => Register(),
          "/gameMenu": (BuildContext context) => GameMenu(),
          "/loading": (BuildContext context) => Loading(),
        },
      ),
    );
  }
}
