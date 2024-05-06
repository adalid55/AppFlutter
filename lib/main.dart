import 'package:flutter/material.dart';

//Importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:sistemafacturacion/Pages/Actualizar.dart';
import 'package:sistemafacturacion/Pages/Buscar.dart';
import 'firebase_options.dart';

//Importaciones de paginas
import 'package:sistemafacturacion/Pages/Agregar.dart';
import 'package:sistemafacturacion/Pages/Home_page.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
} 
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const agregar(),
        '/edit': (context) => const actualizar(),
        '/get': (context) => const buscar(),
        }
    );
  }
}

