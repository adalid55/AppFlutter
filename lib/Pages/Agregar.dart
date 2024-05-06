import 'package:flutter/material.dart';
import 'package:sistemafacturacion/services/firebase_service.dart';

class agregar extends StatefulWidget {
  const agregar({super.key});

  @override
  State<agregar> createState() => _agregarState();
}

class _agregarState extends State<agregar> {

TextEditingController datoController0 = TextEditingController(text: "");
TextEditingController datoController1 = TextEditingController(text: "");
TextEditingController datoController2 = TextEditingController(text: "");
TextEditingController datoController3 = TextEditingController(text: "");
TextEditingController datoController4 = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [

            TextField(
            controller: datoController0,
              decoration: const InputDecoration(
                hintText: 'Ingrese el codigo del producto',
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
            controller: datoController1,
              decoration: const InputDecoration(
                hintText: 'Ingrese el nombre del producto',
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
            controller: datoController2,
              decoration: const InputDecoration(
                hintText: 'Ingrese la cantidad de productos',
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
            controller: datoController3,
              decoration: const InputDecoration(
                hintText: 'Ingrese el precio de Costo',
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
            controller: datoController4,
              decoration: const InputDecoration(
                hintText: 'Ingrese el precio de Venta',
              ),
            ),

            const SizedBox(height: 15,),

            ElevatedButton(
              onPressed: () async {
                await addProductos(datoController0.text, datoController1.text, int.parse(datoController2.text), datoController3.text, datoController4.text).then((_) {
                  Navigator.pop(context);
                  });
              },

              child: const Text("Guardar")
            )
          ],
        ),
      ),
    );
  }
}