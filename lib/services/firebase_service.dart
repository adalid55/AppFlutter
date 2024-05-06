import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//Obtener datos de nuestra base de datos
Future<List> getProductos() async {
  List productos = [];
  QuerySnapshot querySnapshot = await db.collection('productos').get();
  for (var doc in querySnapshot.docs) { 
  final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  final prod = {
    "codigo": data['codigo'],
    "nombre": data['nombre'],
    "cantidad": data['cantidad'],
    "precioCosto": data['precioCosto'],
    "precioVenta": data['precioVenta'],
    "uid": doc.id,
  };
  productos.add(prod);
  }
  //await Future.delayed(Duration(seconds: 1));
  return productos;
}

//Guardar datos en nuestra base de datos
Future<void> addProductos(String codigo, String nombre, int cantidad, String precioCosto, String precioVenta) async{
 await db.collection("productos").add({"codigo": codigo, "nombre": nombre, "cantidad": cantidad, "precioCosto": precioCosto, "precioVenta": precioVenta});
}
 
//Actualizar datos en nuestra base de datos
Future<void> editProductos(String uid, String newcodigo, String newnombre, int newcantidad, String newprecioCosto, String newprecioVenta) async{
  await db.collection("productos").doc(uid).set({"codigo": newcodigo, "nombre": newnombre, "cantidad": newcantidad, "precioCosto": newprecioCosto, "precioVenta": newprecioVenta });
}

//Borrar datos en nuestra base de datos
Future<void> deleteProductos(String uid) async{
  await db.collection("productos").doc(uid).delete();
}
