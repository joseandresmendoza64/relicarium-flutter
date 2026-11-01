
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product producto;

  const ProductCard({
    super.key,
    required this.producto,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: const Color(0xFF0D1726),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
        color: Color(0xFF7DD3FC),
        width: 0.8,
     ),
    
    
      ),

      child: InkWell(onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DetailScreen(
        producto: producto,
      ),
    ),
  );
},
        child: Padding(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
          child: Image.asset(
            'assets/images/${producto.imagen}.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        
        
              const SizedBox(height: 8),
              Text(
                producto.nombre,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
           
              const SizedBox(height: 6),
             
            ],
          ),
        ),
      ),
    );
  }
}
