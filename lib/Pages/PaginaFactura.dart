import 'package:flutter/material.dart';
import 'package:sistemafacturacion/widgets/formulario_pagprincipal.dart';

class Factura extends StatefulWidget {
  const Factura({
    super.key,
  });

  @override
  State<Factura> createState() => _FacturaState();
}

class _FacturaState extends State<Factura> {

    Widget build(BuildContext context) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(

         body: FormBill(
          

         ),
      ),
      
    );
    

    }
}
