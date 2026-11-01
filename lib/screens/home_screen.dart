
import 'package:flutter/material.dart';
import '../widgets/product_card.dart';
import '../widgets/offline_banner.dart';
import 'package:provider/provider.dart';
import '../providers/catalog_provider.dart';
class HomeScreen extends StatelessWidget {
const HomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    final catalog = context.watch<CatalogProvider>();
    final productos = catalog.products;
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
              child: catalog.isLoading
    ? const Center(child: CircularProgressIndicator())
    : catalog.error != null
        ? Center(child: Text(catalog.error!))
        : GridView.builder(
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
