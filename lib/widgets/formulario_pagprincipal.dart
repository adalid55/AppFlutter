import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataModel {
  String cod, nom;
  int can, des, exi, pre;
  late double total;
  DataModel ({required this.cod, required this.nom, required this.can, required this.des, required this.exi, required this.pre,}) : total = (pre - (pre * (des/100))) * can;
}

 class FormBill extends StatefulWidget {
  const FormBill({super.key});

  @override
  State<FormBill> createState() => _FormBillState();
}


class _FormBillState extends State<FormBill> {

String? documentoId;
FocusNode _focusNode = FocusNode();


final List<DataModel> _data = [];

final TextEditingController controllerCod = TextEditingController();
final TextEditingController controllerNombre = TextEditingController();
final TextEditingController controllerExist = TextEditingController();
final TextEditingController controllerPrec = TextEditingController();
final TextEditingController controllerCant= TextEditingController();
final TextEditingController controllerDesc = TextEditingController();

 double get totalSum => _data.fold(0, (previousValue, element) => previousValue + element.total);

 // Método para agregar datos a la lista
  void _addData() {
    if (controllerCod.text.isNotEmpty &&
        controllerNombre.text.isNotEmpty &&
        controllerExist.text.isNotEmpty &&
        controllerPrec.text.isNotEmpty &&
        controllerCant.text.isNotEmpty &&
        controllerDesc.text.isNotEmpty) {
      setState(() {
        _data.add(DataModel(
          cod: controllerCod.text,
          nom: controllerNombre.text,
          exi: int.parse(controllerExist.text),
          pre: int.parse(controllerPrec.text),
          can: int.parse(controllerCant.text),
          des: int.parse(controllerDesc.text),
        ));
        _updateQuantityInDatabase(documentoId!, int.parse(controllerCant.text));
        controllerCod.clear();
        controllerNombre.clear();
        controllerExist.clear();
        controllerPrec.clear();
        controllerCant.clear();
        controllerDesc.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Por favor, complete todos los campos.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

// Función para actualizar la cantidad en la base de datos
Future<void> _updateQuantityInDatabase(String codigo, int quantity) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot snapshot =
      await firestore.collection('productos').doc(codigo).get();

  if (snapshot.exists) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    if (data != null && data.containsKey('cantidad')) {
      int existingQuantity = data['cantidad'];
      int newQuantity = existingQuantity - quantity;

      await firestore
          .collection('productos')
          .doc(codigo)
          .update({'cantidad': newQuantity});
    } else {
      print('No se encontró la cantidad del producto en la base de datos.');
    }
  } else {
    print('No se encontró el producto en la base de datos.');
  }
}



  // Función para obtener los datos del producto en Firebase si existe
  Future<void> obtenerDatosProducto(String codigo) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    
    // Consultar el documento en la colección "productos" usando el campo "codigo"
    QuerySnapshot querySnapshot = await firestore.collection('productos').where('codigo', isEqualTo: codigo).get();
    
    // Verificar si se encontró algún documento con el código dado
    if (querySnapshot.docs.isNotEmpty) {

      documentoId = querySnapshot.docs[0].id;
      print('ID del documento: $documentoId');
  
      // Si existe, obtener el primer documento (asumiendo que hay solo uno con el mismo código)
      DocumentSnapshot snapshot = querySnapshot.docs.first;
      
      // Obtener los datos del documento
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      
      // Establecer los datos en los controladores de texto
      controllerNombre.text = data['nombre'];
      controllerExist.text = data['cantidad'].toString();
      controllerPrec.text = data['precioVenta'];
   
    } else {

      print('No se encontraron documentos con el código proporcionado.');

      // Si no existe, limpiar los campos
      controllerNombre.clear();
      controllerExist.clear();
      controllerPrec.clear();

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Producto no encontrado'),
            content: const Text('No se encontró ningún producto con el código ingresado.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      );
    }
  }


  // Función para borrar todas las filas excepto el encabezado
  void _clearRows() {
    setState(() {
      _data.clear();
    });
  }

  @override
  Widget build(BuildContext context) {    
    
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10,),
      
           Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.33,
                child: inputcod(),
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.33,
                child: inputcant(),
              ),
      
                Container(
                width: MediaQuery.of(context).size.width * 0.33,
                child: inputdesc(),
              ),
            ],
          ),
      
          const SizedBox(height: 10,),

          inputnombre(),

          const SizedBox(height: 10,),
       
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: inputExis(),
              ),
      
                Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: inputprecio(),
              ),
            ],
          ),

          const SizedBox(height: 20,),
      

       Center(
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [        
            Container(
            padding: const EdgeInsets.symmetric(horizontal:15),
            margin: const EdgeInsets.symmetric(horizontal:15),
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(onPressed: () async {
            
              await obtenerDatosProducto(controllerCod.text);
         
            }, child: const Text("Buscar")
            ),
          ),
         
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.symmetric(horizontal:15),
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton( 
            onPressed: () async {
              _addData();
              _focusNode.requestFocus();
            }, 
            child: const Text("Añadir")
            ),
          ),
              ],
            ),
       ),
         

          Container(
          margin: const EdgeInsets.symmetric(horizontal:15, vertical: 20),
          decoration: BoxDecoration(  color: Color.fromARGB(255, 57, 82, 192),
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(255, 121, 123, 136),width:1),
          ),

            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  sortColumnIndex: 0,
                  sortAscending: true,
                  columnSpacing: Checkbox.width,
                  columns: const [
                    
                    DataColumn(label: Center(
                      child: Text("Código",style: TextStyle(
                        color: Colors.white, // Color de la letra de la columna
                        fontSize: 16, fontWeight: FontWeight.bold,
                        ),// Tamaño de la letra de la columna 
                      ),
                    ),
                    numeric: false,
                    ),
                
                    DataColumn(label:  Center(
                      child: Text("Cantidad",style: TextStyle(
                        color: Colors.white, // Color de la letra de la columna
                        fontSize: 16, fontWeight: FontWeight.bold,
                        ),),
                    ),
                    numeric: false,
                    ),
                
                    DataColumn(label:Center(
                      child: Text("Nombre",style: TextStyle(
                        color: Colors.white, // Color de la letra de la columna
                        fontSize: 16, fontWeight: FontWeight.bold,
                        ),),
                    ),
                      numeric: false,
                      ), 
                
                       DataColumn(label:Center(
                        child: Text("Descuento",style: TextStyle(
                        color: Colors.white, // Color de la letra de la columna
                        fontSize: 16, fontWeight: FontWeight.bold,
                        ),),
                       ),
                      numeric: false,
                      ), 
                
                      DataColumn(label:Center(
                        child: Text("Precio",style: TextStyle(
                        color: Colors.white, // Color de la letra de la columna
                        fontSize: 16, fontWeight: FontWeight.bold,
                        ),),
                      ),
                      numeric: false,
                      ),
                
                      DataColumn(label:Center(
                        child: Text("Total",style: TextStyle(
                        color: Colors.white, // Color de la letra de la columna
                        fontSize: 16, fontWeight: FontWeight.bold,
                        ),),
                       ),
                       numeric: false,
                       ),               
                  ], 
                  
                  rows: _data.map(
                        (data) => DataRow(cells: [
                          DataCell(Center(child: Text(data.cod, style: (const TextStyle(color: Colors.white))))),
                          DataCell(Center(child: Text(data.can.toString(), style: (const TextStyle(color: Colors.white))))),
                          DataCell(Center(child: Text(data.nom, style: (const TextStyle(color: Colors.white))))),
                          DataCell(Center(child: Text(data.des.toString(), style: (const TextStyle(color: Colors.white))))),
                          DataCell(Center(child: Text(data.pre.toString(), style: (const TextStyle(color: Colors.white))))),
                          DataCell(Center(child: Text(data.total.toString(), style: (const TextStyle(color: Colors.white))))),
                        ]),
                      ).toList(),


                ),
              ),
            ),
          ),


        Center(
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [   

            const SizedBox(height: 20),
            Text(
              'Total: ${totalSum.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
         
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.symmetric(horizontal:15),
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton( 
            onPressed: () async {

                _clearRows();
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('¡Gracias por su compra :)!'),
                    content: const Text('Factura ingresada correctamente.'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Center(child: Text('Aceptar')),
                      ),
                    ],
                  );
                },
              );
            }, 
            child: const Text("Facturar")
            ),
          ),
              ],
            ),
       ),

        ],
      ),
    );
  }


  Container inputcod() {
    return Container(
      
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(255, 121, 123, 136),width:1.5),
          
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          //autofocus: true,
          focusNode: _focusNode,
          controller: controllerCod,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Código"
            ),
        ),
      );
  }

    Container inputcant() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(255, 121, 123, 136),width:1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          controller: controllerCant,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Cantidad"
            ),
        ),
      );
  }

  Container inputnombre() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(255, 121, 123, 136),width:1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          controller: controllerNombre,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Nombre"
            ),
        ),
      );
  }

  Container inputExis() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(255, 121, 123, 136),width:1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: TextField(
          controller:  controllerExist,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Existencia"
            ),
        ),
      );
  }

    Container inputprecio() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(255, 121, 123, 136),width:1.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child:  TextField(
          controller: controllerPrec,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Precio"
            ),
        ),
      );
  }

  Container inputdesc() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color.fromARGB(255, 121, 123, 136),width:1.5),
          
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child:  TextField(
          controller: controllerDesc,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Descuento"
            ),
        ),
      );
  }
}