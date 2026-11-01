class Product {
  final String nombre;
  final String descripcion;
  final int precio;
  final String imagen;

  const Product({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagen,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'imagen': imagen,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      nombre: json['nombre'] as String,
      descripcion: json['descripcion'] as String,
      precio: (json['precio'] as num).toInt(),
      imagen: json['imagen'] as String,
    );
  }
}