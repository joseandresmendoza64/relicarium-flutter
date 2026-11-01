
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
        foregroundColor: const Color(0xFF7DD3FC),
        centerTitle: true,
title: const Text(
  'Detalle de Reliquia',
  style: TextStyle(
    color: Color(0xFF7DD3FC),
    fontSize: 26,
    fontWeight: FontWeight.bold,
  ),
),
       
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           ClipRRect(
  borderRadius: BorderRadius.circular(16),
  child: AspectRatio(
    aspectRatio: 1,
    child: Image.asset(
      'assets/images/${producto.imagen}.png',
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  ),
),
            const SizedBox(height: 20),
            Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Expanded(
      child: Text(
        producto.nombre,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    const SizedBox(width: 12),
    Text(
      '\$ ${producto.precio}',
      style: const TextStyle(
        color: Color(0xFF7DD3FC),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    ),
  ],
),

            const SizedBox(height: 16),
            Text(
              producto.descripcion,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.bold,

              ),
            ),
          
            const SizedBox(height: 40),
            Center(
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
