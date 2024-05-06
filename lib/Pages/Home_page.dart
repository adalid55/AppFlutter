import 'package:flutter/material.dart';
import 'package:sistemafacturacion/Pages/PaginaFactura.dart';
import 'package:sistemafacturacion/Pages/PaginaProductos.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

int _paginaActual = 0;

List<Widget> _Paginas = [
Factura(),
Productos(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 45, 131),
        title: const Text('Factos Technology', style: (TextStyle(fontSize: 30, color: Colors.white,fontFamily:'ArialBlack',))),
        centerTitle: true,
      ),

      body: _Paginas[_paginaActual],

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _paginaActual = index;
          });
        },

        currentIndex: _paginaActual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart), label: "Factura"),
          BottomNavigationBarItem(icon: Icon(Icons.add_business), label: "Productos"),
        ],
      ),
    );
  }
}