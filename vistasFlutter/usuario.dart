// package: vistasFlutter/usuario.dart
//                     ),

import 'package:flutter/material.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  // Controladores para los campos del formulario
  final TextEditingController _nombreController = TextEditingController(
    text: 'Juan Pérez',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'juan.perez@email.com',
  );
  final TextEditingController _telefonoController = TextEditingController(
    text: '+1 234 567 8900',
  );
  final TextEditingController _edadController = TextEditingController(
    text: '28',
  );
  final TextEditingController _ocupacionController = TextEditingController(
    text: 'Ingeniero de Software',
  );
  final TextEditingController _bioController = TextEditingController(
    text:
        'Me encanta vivir en espacios cómodos y bien ubicados. Busco compañeros de cuarto responsables y amigables.',
  );

  // Preferencias del usuario
  String _presupuestoSeleccionado = '\$1,000 - \$1,500';
  String _tipoViviendaSeleccionado = 'Apartment';
  List<String> _caracteristicasDeseadas = [
    'Pet-friendly',
    'Furnished',
    'Gym Access',
  ];
  List<String> _ubicacionesPreferidas = ['Downtown', 'Near Metro'];

  final List<String> _presupuestoOpciones = [
    '\$500 - \$800',
    '\$800 - \$1,200',
    '\$1,000 - \$1,500',
    '\$1,500 - \$2,000',
    '\$2,000+',
  ];

  final List<String> _tiposVivienda = ['Apartment', 'Room', 'Studio', 'House'];

  final List<String> _caracteristicasDisponibles = [
    'Pet-friendly',
    'Furnished',
    'Gym Access',
    'Pool',
    'Balcony',
    'Garage',
    'Garden',
    'Washer/Dryer',
    'Air Conditioning',
    'Internet Included',
  ];

  final List<String> _ubicacionesDisponibles = [
    'Downtown',
    'Near Metro',
    'Quiet Area',
    'Near Schools',
    'Shopping District',
    'Arts District',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mi Perfil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            icon: Icon(
              _isEditing ? Icons.save : Icons.edit,
              color: Colors.blue,
            ),
          ),
          IconButton(
            onPressed: () {
              _showLogoutDialog();
            },
            icon: const Icon(Icons.logout, color: Colors.red),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile Header
              _buildProfileHeader(),
              const SizedBox(height: 20),

              // Información Personal
              _buildSection('Información Personal', [
                _buildTextField(
                  controller: _nombreController,
                  label: 'Nombre Completo',
                  icon: Icons.person,
                  enabled: _isEditing,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _emailController,
                  label: 'Correo Electrónico',
                  icon: Icons.email,
                  enabled: _isEditing,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _telefonoController,
                  label: 'Teléfono',
                  icon: Icons.phone,
                  enabled: _isEditing,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _edadController,
                        label: 'Edad',
                        icon: Icons.cake,
                        enabled: _isEditing,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildTextField(
                        controller: _ocupacionController,
                        label: 'Ocupación',
                        icon: Icons.work,
                        enabled: _isEditing,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _bioController,
                  label: 'Biografía',
                  icon: Icons.description,
                  enabled: _isEditing,
                  maxLines: 3,
                ),
              ]),
              const SizedBox(height: 20),

              // Preferencias de Vivienda
              _buildSection('Preferencias de Vivienda', [
                _buildDropdownField(
                  'Presupuesto Mensual',
                  _presupuestoSeleccionado,
                  _presupuestoOpciones,
                  Icons.attach_money,
                  (value) {
                    if (_isEditing) {
                      setState(() {
                        _presupuestoSeleccionado = value!;
                      });
                    }
                  },
                ),
                const SizedBox(height: 15),
                _buildDropdownField(
                  'Tipo de Vivienda Preferida',
                  _tipoViviendaSeleccionado,
                  _tiposVivienda,
                  Icons.home,
                  (value) {
                    if (_isEditing) {
                      setState(() {
                        _tipoViviendaSeleccionado = value!;
                      });
                    }
                  },
                ),
              ]),
              const SizedBox(height: 20),

              // Características Deseadas
              _buildSection('Características Deseadas', [
                const Text(
                  'Selecciona las características que te interesan:',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      _caracteristicasDisponibles.map((caracteristica) {
                        final isSelected = _caracteristicasDeseadas.contains(
                          caracteristica,
                        );
                        return FilterChip(
                          label: Text(caracteristica),
                          selected: isSelected,
                          onSelected:
                              _isEditing
                                  ? (selected) {
                                    setState(() {
                                      if (selected) {
                                        _caracteristicasDeseadas.add(
                                          caracteristica,
                                        );
                                      } else {
                                        _caracteristicasDeseadas.remove(
                                          caracteristica,
                                        );
                                      }
                                    });
                                  }
                                  : null,
                          selectedColor: Colors.blue[100],
                          checkmarkColor: Colors.blue[700],
                        );
                      }).toList(),
                ),
              ]),
              const SizedBox(height: 20),

              // Ubicaciones Preferidas
              _buildSection('Ubicaciones Preferidas', [
                const Text(
                  'Áreas donde te gustaría vivir:',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      _ubicacionesDisponibles.map((ubicacion) {
                        final isSelected = _ubicacionesPreferidas.contains(
                          ubicacion,
                        );
                        return FilterChip(
                          label: Text(ubicacion),
                          selected: isSelected,
                          onSelected:
                              _isEditing
                                  ? (selected) {
                                    setState(() {
                                      if (selected) {
                                        _ubicacionesPreferidas.add(ubicacion);
                                      } else {
                                        _ubicacionesPreferidas.remove(
                                          ubicacion,
                                        );
                                      }
                                    });
                                  }
                                  : null,
                          selectedColor: Colors.green[100],
                          checkmarkColor: Colors.green[700],
                        );
                      }).toList(),
                ),
              ]),
              const SizedBox(height: 20),

              // Estadísticas
              _buildSection('Estadísticas', [
                Row(
                  children: [
                    _buildStatCard('Propiedades\nVistas', '24', Colors.blue),
                    const SizedBox(width: 15),
                    _buildStatCard('Me Gusta\nDados', '8', Colors.green),
                    const SizedBox(width: 15),
                    _buildStatCard('Contactos\nRealizados', '3', Colors.orange),
                  ],
                ),
              ]),
              const SizedBox(height: 30),

              // Botón de Guardar (solo visible cuando está editando)
              if (_isEditing)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _guardarCambios,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'GUARDAR CAMBIOS',
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

  Widget _buildProfileHeader() {
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
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue[100],
                child: const Icon(Icons.person, size: 50, color: Colors.blue),
              ),
              if (_isEditing)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            _nombreController.text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            _emailController.text,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Usuario Verificado',
              style: TextStyle(
                color: Colors.green[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
    required IconData icon,
    bool enabled = true,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: enabled ? Colors.blue : Colors.grey),
        filled: true,
        fillColor: enabled ? Colors.grey[50] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[200]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> options,
    IconData icon,
    void Function(String?)? onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: _isEditing ? Colors.blue : Colors.grey),
        filled: true,
        fillColor: _isEditing ? Colors.grey[50] : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      items:
          options.map((option) {
            return DropdownMenuItem(value: option, child: Text(option));
          }).toList(),
      onChanged: _isEditing ? onChanged : null,
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _guardarCambios() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil actualizado exitosamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
