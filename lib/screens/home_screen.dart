
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/offline_banner.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Product> productos = const [
    Product(
      nombre: 'Teseracto',
      descripcion: 'Cubo cósmico de energía extraordinaria.',
      precio: 12500,
      imagen: 'teseracto',
    ),
 Product(
      nombre: 'Copa traslador',
      descripcion: 'Objeto mágico capaz de transportar personas.',
      precio: 6700,
      imagen: 'copa',
    ),
     Product(
      nombre: 'Espada Maestra',
      descripcion: 'Espada legendaria perteneciente al héroe del tiempo.',
      precio: 90000,
      imagen: 'espada',
    ),
  Product(
      nombre: 'Death Note',
      descripcion: 'Cuaderno oscuro donde todo nombre escrito termina en muerte.',
      precio: 10500,
      imagen: 'cuaderno',
    ),
    Product(
      nombre: 'Anticitera',
      descripcion: 'Dispositivo ancestral de astronomía.',
      precio: 8900,
      imagen: 'anticitera',
    ),
    Product(
      nombre: 'Escama de dragón',
      descripcion: 'Reliquia de una criatura legendaria.',
      precio: 3200,
      imagen: 'escama',
    ),
     
    Product(
      nombre: 'Esferas del Dragón',
      descripcion: 'Esferas místicas que invocan a Shenlong.',
      precio: 20500,
      imagen: 'esferas',
    ),
  
    Product(
      nombre: 'Omnitrix',
      descripcion: 'Dispositivo alienígena de transformación.',
      precio: 15000,
      imagen: 'omnitrix',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15151F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF252536),
        title: const Text(
          'RELICARIUM II',
          style: TextStyle(
            color: Color(0xFF7DD3FC),
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const OfflineBanner(),
            const Text(
              'Mercado de lo imposible',
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            const Center(
            child: Text('❦ ─────────── ✦ ─────────── ❦',
           style: TextStyle(color: Color(0xFF7DD3FC), fontSize: 18)),
            ),
            const Text(
              'Artefactos legendarios, toca para conocer más detalles',
              style: TextStyle(color: Color.fromARGB(255, 101, 202, 252), fontSize: 17),
              
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.60,
                ),
                itemCount: productos.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    producto: productos[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
