import 'package:flutter/material.dart';
import 'package:sistemafacturacion/services/firebase_service.dart';

class Productos extends StatefulWidget {
  const Productos({
    super.key,
  });

  @override
  State<Productos> createState() => _ProductosState();
}

class _ProductosState extends State<Productos> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 231, 231, 231),
      centerTitle: true,
      title: const Text('Lista de Productos',style: TextStyle(decoration: TextDecoration.underline),),
      ),
      body: FutureBuilder(
        future: getProductos(),
        builder: ((context, snapshot) {

          if (snapshot.hasData){

            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {

                return Dismissible(
                  onDismissed: (direction) async{
                    await deleteProductos(snapshot.data?[index]['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context){
                      return AlertDialog(
                        title: Text("¿Esta seguro que desea eliminar ${snapshot.data?[index]['nombre']}?"),
                        actions: [
                          TextButton(onPressed: (){
                            return Navigator.pop(context, false,);
                          }, child: const Text("Cancelar", style: TextStyle(color: Colors.red),)),
                          TextButton(onPressed: (){
                            return Navigator.pop(context, true,);
                          }, child: const Text("Si, estoy seguro"))
                        ],
                      );
                    });
                    return result;
                  },

                  background: Container(
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),

                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),

                  child: ListTile(
                    

                    title: Text(snapshot.data?[index]['nombre'] ),
                    subtitle: Text(("Cod: ${snapshot.data![index]['codigo']}, ") +
                                    ("Cant: ${snapshot.data![index]['cantidad']} Und, ") + 
                                    ("Pre costo: L. ${snapshot.data![index]['precioCosto']}, ") + 
                                    ("Pre venta: L. ${snapshot.data![index]['precioVenta']}")),
                  

                    onTap: (() async {
                      await Navigator.pushNamed(context, "/edit", arguments: {
                        "codigo": snapshot.data?[index]['codigo'],
                        "nombre": snapshot.data?[index]['nombre'],
                        "cantidad": snapshot.data?[index]['cantidad'],
                        "precioCosto": snapshot.data?[index]['precioCosto'],
                        "precioVenta": snapshot.data?[index]['precioVenta'],
                        "uid": snapshot.data?[index]['uid']
                      });
                      setState(() {});
                    }
                    ),
                  ),
                );
              },
            );

          } else{

            return const Center(
              child: CircularProgressIndicator(),
            );

          }
          
        })
      ),
  
  
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),

    );
  }
}