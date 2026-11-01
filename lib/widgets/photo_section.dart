import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/photo_provider.dart';

class PhotoSection extends StatelessWidget {
  const PhotoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final photos = context.watch<PhotoProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Foto de tu colección',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: photos.busy
                  ? null
                  : () => photos.selectPhoto(fromCamera: true),
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Cámara'),
            ),
            OutlinedButton.icon(
              onPressed: photos.busy
                  ? null
                  : () => photos.selectPhoto(fromCamera: false),
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Galería'),
            ),
          ],
        ),
        if (photos.busy) const LinearProgressIndicator(),
        if (photos.error != null)
          Text(photos.error!, style: const TextStyle(color: Colors.white)),
        if (photos.photoPath != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Image.file(
              File(photos.photoPath!),
              height: 220,
              width: double.infinity,
              fit: BoxFit.contain,
              errorBuilder: (_, error, stackTrace) =>
                  const Text('No se pudo mostrar la foto.'),
            ),
          ),
        if (photos.hasPendingPhoto)
          ElevatedButton.icon(
            onPressed: photos.busy ? null : photos.savePhoto,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Guardar foto'),
          ),
        if (photos.photoPath != null && !photos.hasPendingPhoto)
          const Text(
            'Foto guardada en este dispositivo',
            style: TextStyle(color: Color(0xFF7DD3FC)),
          ),
        if (photos.requiresSettings)
          TextButton(
            onPressed: photos.busy ? null : () => photos.openSettings(),
            child: const Text('Abrir ajustes'),
          ),
      ],
    );
  }
}
