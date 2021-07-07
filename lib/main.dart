import 'package:consumatron/pages/wishlist/screens/WishlistPageMainScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(ConsumatronApp());
}

class ConsumatronApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CircularProgressIndicator(
            backgroundColor: Colors.red,
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Consumatron',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
              buttonTheme: ButtonThemeData(),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black87),
                  foregroundColor:
                      MaterialStateProperty.all(Colors.green.shade800),
                  textStyle: MaterialStateProperty.all(TextStyle(
                      color: Colors.green.shade800, fontFamily: 'Gugi')),
                  shape: MaterialStateProperty.all(
                    BeveledRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
              ),
              fontFamily: 'Gugi',
              textTheme: TextTheme(
                headline3:
                    TextStyle(color: Colors.green.shade800, fontFamily: 'Gugi'),
                bodyText2:
                    TextStyle(color: Colors.green.shade800, fontFamily: 'Gugi'),
              ),
              primarySwatch: Colors.green,
            ),
            home: WishlistPageStartScreen(),
          );
        }

        return CircularProgressIndicator();
      },
    );
  }
}
