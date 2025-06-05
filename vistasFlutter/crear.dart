// File: crear.dart
//  CREAR NUEVOS POST              ),
import 'package:flutter/material.dart';

class CrearScreen extends StatefulWidget {
  const CrearScreen({super.key});

  @override
  State<CrearScreen> createState() => _CrearScreenState();
}

class _CrearScreenState extends State<CrearScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _habitacionesController = TextEditingController();
  final TextEditingController _banosController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _contactoController = TextEditingController();

  String _tipoSeleccionado = 'Apartment';
  List<String> _caracteristicasSeleccionadas = [];
  List<String> _imagenesSeleccionadas = [];
  String _tipoArrendatario = 'Cualquiera';

  final List<String> _tiposDisponibles = [
    'Apartment',
    'Room',
    'Studio',
    'House',
  ];

  final List<String> _caracteristicasDisponibles = [
    'Furnished',
    'Pet-friendly',
    'Balcony',
    'Garage',
    'Garden',
    'Gym Access',
    'Pool',
    'Washer/Dryer',
    'Air Conditioning',
    'Heating',
    'Internet Included',
    'Utilities Included',
  ];

  final List<String> _tiposArrendatario = [
    'Cualquiera',
    'Solo Estudiantes',
    'Solo Profesionales',
    'Solo Mujeres',
    'Solo Hombres',
    'Familias',
  ];

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _direccionController.dispose();
    _precioController.dispose();
    _habitacionesController.dispose();
    _banosController.dispose();
    _areaController.dispose();
    _contactoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Crear Publicación',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Icon(Icons.add_home, size: 50, color: Colors.blue),
                    SizedBox(height: 10),
                    Text(
                      'Crear Nueva Publicación',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Encuentra tu compañero de vivienda ideal',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Información Básica
              _buildSection('Información Básica', [
                _buildTextField(
                  controller: _tituloController,
                  label: 'Título de la Publicación',
                  hint: 'Ej: Apartamento Acogedor en Centro',
                  prefixIcon: Icons.title,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _descripcionController,
                  label: 'Descripción',
                  hint:
                      'Describe tu propiedad y qué tipo de compañero buscas...',
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildDropdown(),
              ]),
              const SizedBox(height: 20),

              // Ubicación y Precio
              _buildSection('Ubicación y Precio', [
                _buildTextField(
                  controller: _direccionController,
                  label: 'Dirección',
                  hint: 'Calle, Ciudad, País',
                  prefixIcon: Icons.location_on,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la dirección';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _precioController,
                  label: 'Precio por Mes (USD)',
                  hint: '1500',
                  prefixIcon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el precio';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor ingresa un precio válido';
                    }
                    return null;
                  },
                ),
              ]),
              const SizedBox(height: 20),

              // Detalles de la Propiedad
              _buildSection('Detalles de la Propiedad', [
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _habitacionesController,
                        label: 'Habitaciones',
                        hint: '2',
                        prefixIcon: Icons.bed,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (int.tryParse(value) == null) {
                              return 'Número inválido';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildTextField(
                        controller: _banosController,
                        label: 'Baños',
                        hint: '1',
                        prefixIcon: Icons.bathroom,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (int.tryParse(value) == null) {
                              return 'Número inválido';
                            }
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _areaController,
                  label: 'Área (m²)',
                  hint: '80',
                  prefixIcon: Icons.square_foot,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (double.tryParse(value) == null) {
                        return 'Por favor ingresa un área válida';
                      }
                    }
                    return null;
                  },
                ),
              ]),
              const SizedBox(height: 20),

              // Tipo de Compañero Buscado
              _buildSection('Tipo de Compañero Buscado', [
                const Text(
                  '¿Qué tipo de compañero de vivienda buscas?',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                _buildArrendatarioDropdown(),
              ]),
              const SizedBox(height: 20),

              // Características
              _buildSection('Características', [
                const Text(
                  'Selecciona las características que aplican:',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      _caracteristicasDisponibles.map((caracteristica) {
                        final isSelected = _caracteristicasSeleccionadas
                            .contains(caracteristica);
                        return FilterChip(
                          label: Text(caracteristica),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _caracteristicasSeleccionadas.add(
                                  caracteristica,
                                );
                              } else {
                                _caracteristicasSeleccionadas.remove(
                                  caracteristica,
                                );
                              }
                            });
                          },
                          selectedColor: Colors.blue[100],
                          checkmarkColor: Colors.blue[700],
                        );
                      }).toList(),
                ),
              ]),
              const SizedBox(height: 20),

              // Información de Contacto
              _buildSection('Información de Contacto', [
                _buildTextField(
                  controller: _contactoController,
                  label: 'WhatsApp o Teléfono',
                  hint: '+1 234 567 8900',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa tu información de contacto';
                    }
                    return null;
                  },
                ),
              ]),
              const SizedBox(height: 20),

              // Imágenes
              _buildSection('Imágenes', [
                GestureDetector(
                  onTap: _seleccionarImagenes,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 2,
                        style: BorderStyle.none,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          size: 50,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _imagenesSeleccionadas.isEmpty
                              ? 'Agregar Fotos'
                              : '${_imagenesSeleccionadas.length} imagen(es) seleccionada(s)',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            fontWeight:
                                _imagenesSeleccionadas.isNotEmpty
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                          ),
                        ),
                        Text(
                          'Toca para seleccionar imágenes',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_imagenesSeleccionadas.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _imagenesSeleccionadas.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 80,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.image,
                                  color: Colors.blue[600],
                                  size: 30,
                                ),
                              ),
                              Positioned(
                                top: 4,
                                right: 4,
                                child: GestureDetector(
                                  onTap: () => _eliminarImagen(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ]),
              const SizedBox(height: 30),

              // Botón de Crear
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _crearPublicacion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    'CREAR PUBLICACIÓN',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? prefixIcon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _tipoSeleccionado,
      decoration: InputDecoration(
        labelText: 'Tipo de Propiedad',
        prefixIcon: const Icon(Icons.home, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      items:
          _tiposDisponibles.map((tipo) {
            return DropdownMenuItem(value: tipo, child: Text(tipo));
          }).toList(),
      onChanged: (value) {
        setState(() {
          _tipoSeleccionado = value!;
        });
      },
    );
  }

  Widget _buildArrendatarioDropdown() {
    return DropdownButtonFormField<String>(
      value: _tipoArrendatario,
      decoration: InputDecoration(
        labelText: 'Preferencias de Compañero',
        prefixIcon: const Icon(Icons.people, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
      items:
          _tiposArrendatario.map((tipo) {
            return DropdownMenuItem(value: tipo, child: Text(tipo));
          }).toList(),
      onChanged: (value) {
        setState(() {
          _tipoArrendatario = value!;
        });
      },
    );
  }

  void _seleccionarImagenes() {
    // Aquí iría la lógica para seleccionar imágenes
    // Por ahora simulamos agregar una imagen
    setState(() {
      _imagenesSeleccionadas.add(
        'imagen_${_imagenesSeleccionadas.length + 1}.jpg',
      );
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Imagen agregada (simulación)'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _eliminarImagen(int index) {
    setState(() {
      _imagenesSeleccionadas.removeAt(index);
    });
  }

  void _crearPublicacion() {
    if (_formKey.currentState!.validate()) {
      // Validaciones adicionales
      if (_imagenesSeleccionadas.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor agrega al menos una imagen'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Aquí iría la lógica para guardar la publicación
      _mostrarDialogoExito();
    }
  }

  void _mostrarDialogoExito() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green[600], size: 30),
              const SizedBox(width: 10),
              const Text('¡Éxito!'),
            ],
          ),
          content: const Text(
            'Tu publicación ha sido creada exitosamente. ¡Pronto encontrarás tu compañero de vivienda ideal!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _limpiarFormulario();
              },
              child: const Text(
                'Crear Otra',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Regresar a la pantalla anterior
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Ver Publicación',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _limpiarFormulario() {
    _tituloController.clear();
    _descripcionController.clear();
    _direccionController.clear();
    _precioController.clear();
    _habitacionesController.clear();
    _banosController.clear();
    _areaController.clear();
    _contactoController.clear();
    setState(() {
      _tipoSeleccionado = 'Apartment';
      _tipoArrendatario = 'Cualquiera';
      _caracteristicasSeleccionadas.clear();
      _imagenesSeleccionadas.clear();
    });
  }
}
