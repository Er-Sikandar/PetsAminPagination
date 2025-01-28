import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_adoption_app/providers/AuthProvider.dart';
import 'package:pet_adoption_app/ui/SplashScreen.dart';
import 'package:pet_adoption_app/utils/Prefs.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Prefs.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
   runApp(MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (_) => AuthProvider()),

       ],
      child: MaterialApp(
        title: 'Pet Adoption App',
        debugShowCheckedModeBanner: false,
        // Define light theme
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          textTheme: TextTheme(
            bodySmall: TextStyle(color: Colors.black),
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        // Define dark theme
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),

          textTheme: TextTheme(
            bodySmall: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        themeMode: ThemeMode.system,
        home: SplashScreen(),
      ),
      ),);
}
