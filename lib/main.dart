import 'package:consumatron/pages/archived/screens/ArchivedItemsPageMainScreen.dart';
import 'package:consumatron/pages/login/screens/LoginPageMainScreen.dart';
import 'package:consumatron/pages/wishlist/screens/WishlistPageMainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

//TODO: Implement Themes

void main() {
  runApp(ConsumatronApp());
}

class ConsumatronApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;

  authentication() {
    if (kReleaseMode) {
      auth.setPersistence(Persistence.SESSION);
    } else {
      auth.setPersistence(Persistence.NONE);
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (kReleaseMode) {
          if (snapshot.hasData) {
            if (snapshot.data!.providerData.length == 1) {
              return WishlistPageStartScreen();
            }
          } else {
            return LoginPageMainScreen();
          }
          return LoginPageMainScreen();
        } else {
          return WishlistPageStartScreen();
        }
      },
    );
  }

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
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.green),
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
                  headline3: TextStyle(
                      color: Colors.green.shade800, fontFamily: 'Gugi'),
                  bodyText2: TextStyle(
                      color: Colors.green.shade800, fontFamily: 'Gugi'),
                ),
                primarySwatch: Colors.green,
              ),
              routes: {
                // '/': (context) => const LoginPageMainScreen(),
                'wishlistPage': (context) => const WishlistPageStartScreen(),
                'archivedItemsPage': (context) =>
                    const ArchivedItemsPageStartScreen(),
              },
              home: authentication());
        }

        return CircularProgressIndicator();
      },
    );
  }
}
