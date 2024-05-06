import 'package:flutter/material.dart';
import 'package:sistemafacturacion/services/firebase_service.dart';

class actualizar extends StatefulWidget {
  const actualizar({super.key});

  @override
  State<actualizar> createState() => _actualizarState();
}

class _actualizarState extends State<actualizar> {

TextEditingController datoController0 = TextEditingController();
TextEditingController datoController1 = TextEditingController();
TextEditingController datoController2  = TextEditingController();
TextEditingController datoController3 = TextEditingController();
TextEditingController datoController4 = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    datoController0.text = arguments['codigo'];
    datoController1.text = arguments['nombre'];
    datoController2.text  = arguments['cantidad'].toString();
    datoController3.text = arguments['precioCosto'];
    datoController4.text = arguments['precioVenta'];


    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Producto'),
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
                await editProductos(arguments['uid'], datoController0.text, datoController1.text, int.parse(datoController2.text), datoController3.text, datoController4.text).then((_){
                  Navigator.pop(context);
                });
              },
              child: const Text("Actualizar"))
          ],
        ),
      ),
    );
  }
}