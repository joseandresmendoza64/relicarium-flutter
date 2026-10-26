
import 'package:flutter/material.dart';
import '../models/product.dart';

class DetailScreen extends StatelessWidget {
  final Product producto;

  const DetailScreen({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15151F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF252536),
        foregroundColor: Colors.amber,
        title: const Text('Detalle de reliquia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
  child: Image.asset(
    'assets/images/${producto.imagen}.png',
    width: 220,
    height: 180,
    fit: BoxFit.contain,
  ),
),
            const SizedBox(height: 30),
            Text(
              producto.nombre,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              producto.descripcion,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '\$${producto.precio} USD',
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al catálogo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
