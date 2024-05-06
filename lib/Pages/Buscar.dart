import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class buscar extends StatefulWidget {
  const buscar({
    super.key,
  });

  @override
  State<buscar> createState() => _buscarState();
}

class _buscarState extends State<buscar> {
    List busqueda = [];
  List resultado = [];

final TextEditingController buscarcontroller = TextEditingController();

  @override
  void initState () {
    buscarcontroller.addListener(enbuscadecambios);
    super.initState();
  }

  enbuscadecambios (){
  print(buscarcontroller.text);
  buscarresultado ();
  }

  buscarresultado (){
    var mostrarresultados = [];
    if (buscarcontroller.text != "") {
    for (var productosnapshot in busqueda) {
      var nombre = productosnapshot['nombre'].toString().toLowerCase();
        if (nombre.contains(buscarcontroller.text.toLowerCase())) {
          mostrarresultados.add(productosnapshot);
        }
    }
    }else{
      mostrarresultados = List.from(busqueda);
    }

    setState(() {
      resultado = mostrarresultados;
    });

  }

  buscarproducto () async{
    var data = await FirebaseFirestore.instance.collection('productos').orderBy('nombre').get();

    setState (() {
      busqueda = data.docs;
    });
    buscarresultado ();

  }

    @override
    void dispose () {
      buscarcontroller.removeListener(enbuscadecambios);
      buscarcontroller.dispose();
    super.dispose();
    }

    @override
    void didChangeDependencies () {
      buscarproducto();
      super.didChangeDependencies();
    }


    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: CupertinoSearchTextField(
            controller: buscarcontroller,
          ),
        ),
        body: ListView.builder(
          itemCount: resultado.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(resultado[index]['nombre'],),
                    subtitle: Text(("Cod: ${resultado[index]['codigo']}, ") +
                                    ("Cant: ${resultado[index]['cantidad']} Und, ") + 
                                    ("Pre costo: L. ${resultado[index]['precioCosto']}, ") + 
                                    ("Pre venta: L. ${resultado[index]['precioVenta']}")),
                                  

            onTap: (() async {
              
              
            }),

            );
          }
        
        ),

      );
    }
}