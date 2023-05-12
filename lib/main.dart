import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stotppub/firebase_options.dart';
import 'package:stotppub/src/app.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
