import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/museum_artwork.dart';
import '../providers/museum_provider.dart';
import '../services/museum_api_service.dart';

class MuseumScreen extends StatelessWidget {
  const MuseumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MuseumProvider(MuseumApiService())..load(),
      child: Consumer<MuseumProvider>(
        builder: (context, museum, _) => Scaffold(
          appBar: AppBar(title: const Text('Archivo del museo')),
          body: SafeArea(child: _buildBody(context, museum)),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, MuseumProvider museum) {
    switch (museum.status) {
      case MuseumStatus.loading:
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Consultando el archivo del museo…'),
            ],
          ),
        );
      case MuseumStatus.error:
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off_outlined, size: 44),
                const SizedBox(height: 16),
                Text(
                  'Archivo no disponible',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(museum.error!, textAlign: TextAlign.center),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: museum.load,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              ],
            ),
          ),
        );
      case MuseumStatus.success:
        return RefreshIndicator(
          onRefresh: museum.load,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              Text(
                'Armaduras históricas',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              const Text('Colección del Art Institute of Chicago'),
              const Text('Desliza hacia abajo para actualizar.'),
              const SizedBox(height: 16),
              if (museum.artworks.isEmpty)
                const Text('El museo no devolvió piezas para esta consulta.'),
              for (final artwork in museum.artworks) _ArtworkCard(artwork: artwork),
            ],
          ),
        );
    }
  }
}

class _ArtworkCard extends StatelessWidget {
  const _ArtworkCard({required this.artwork});

  final MuseumArtwork artwork;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = artwork.imageUrl;
    const placeholder = ColoredBox(
      color: Color(0xFF172438),
      child: Center(child: Icon(Icons.museum_outlined, size: 32)),
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          SizedBox(
            width: 104,
            height: 112,
            child: imageUrl == null
                ? placeholder
                : Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    excludeFromSemantics: true,
                    errorBuilder: (_, _, _) => placeholder,
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(artwork.title, style: theme.textTheme.titleLarge),
                  if (artwork.date case final date?) Text(date),
                  if (artwork.origin case final origin?) Text(origin),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
