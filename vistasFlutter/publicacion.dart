import 'package:flutter/material.dart';

class Publicacion {
  final String id;
  final String titulo;
  final String subtitulo;
  final String direccion;
  final String precio;
  final String habitaciones;
  final String banos;
  final String area;
  final List<String> caracteristicas;
  final Color color;
  final String tipo;

  Publicacion({
    required this.id,
    required this.titulo,
    required this.subtitulo,
    required this.direccion,
    required this.precio,
    required this.habitaciones,
    required this.banos,
    required this.area,
    required this.caracteristicas,
    required this.color,
    required this.tipo,
  });
}

class PublicacionScreen extends StatefulWidget {
  const PublicacionScreen({super.key});

  @override
  State<PublicacionScreen> createState() => _PublicacionScreenState();
}

class _PublicacionScreenState extends State<PublicacionScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Publicacion> _publicaciones = [
    Publicacion(
      id: '1',
      titulo: 'Cozy Apartment',
      subtitulo: 'Cozy Downtown Apartment',
      direccion: '123 Main St, Anytown, USA',
      precio: '\$1,500/month',
      habitaciones: '1 beds',
      banos: '1 baths',
      area: '650 sqft',
      caracteristicas: ['Furnished', 'Pet-friendly', 'Balcony', '+2 more'],
      color: const Color(0xFFB39DDB),
      tipo: 'Apartment',
    ),
    Publicacion(
      id: '2',
      titulo: 'Spacious Room',
      subtitulo: 'Spacious Room in Shared House',
      direccion: '456 Oak Ave, Anytown, USA',
      precio: '\$800/month',
      habitaciones: '1 beds',
      banos: '1 baths',
      area: '320 sqft',
      caracteristicas: ['Shared Kitchen', 'Washer/Dryer', 'Quiet Area'],
      color: const Color(0xFFFFCC80),
      tipo: 'Room',
    ),
    Publicacion(
      id: '3',
      titulo: 'Modern Loft',
      subtitulo: 'Modern Loft in Arts District',
      direccion: '789 Creative St, Anytown, USA',
      precio: '\$2,200/month',
      habitaciones: '2 beds',
      banos: '2 baths',
      area: '900 sqft',
      caracteristicas: ['High Ceilings', 'Exposed Brick', 'Gym Access'],
      color: const Color(0xFF80CBC4),
      tipo: 'Studio',
    ),
    Publicacion(
      id: '4',
      titulo: 'Suburban House',
      subtitulo: 'Family House in Quiet Neighborhood',
      direccion: '321 Family Ln, Anytown, USA',
      precio: '\$2,800/month',
      habitaciones: '3 beds',
      banos: '2 baths',
      area: '1200 sqft',
      caracteristicas: ['Garden', 'Garage', 'Near Schools'],
      color: const Color(0xFFA5D6A7),
      tipo: 'House',
    ),
  ];

  void _onSwipe(bool liked) {
    if (liked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Te gusta ${_publicaciones[_currentIndex].titulo}!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pasaste ${_publicaciones[_currentIndex].titulo}'),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (_currentIndex < _publicaciones.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡No hay más publicaciones disponibles!'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Find Your Perfect Space',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: const Text(
              'Browse through our curated listings of apartments and rooms.',
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),

          // Search Bar
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter address, city or keyword...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('All Types'),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Any Price'),
                ),
              ],
            ),
          ),

          // Cards
          Expanded(
            child:
                _currentIndex < _publicaciones.length
                    ? Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: _publicaciones.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return _buildCard(_publicaciones[index]);
                          },
                        ),

                        // Action Buttons
                        // botones like, no like
                      ],
                    )
                    : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home, size: 100, color: Colors.grey),
                          SizedBox(height: 20),
                          Text(
                            '¡No hay más publicaciones!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Vuelve más tarde para ver nuevas opciones',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Publicacion pub) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: pub.color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      pub.titulo,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        pub.tipo,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pub.subtitulo,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        pub.direccion,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  Text(
                    pub.precio,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Details Row
                  Row(
                    children: [
                      _buildDetail(Icons.bed, pub.habitaciones),
                      const SizedBox(width: 20),
                      _buildDetail(Icons.bathtub, pub.banos),
                      const SizedBox(width: 20),
                      _buildDetail(Icons.square_foot, pub.area),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Features
                  const Text(
                    'Features:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        pub.caracteristicas.map((feature) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            child: Text(
                              feature,
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('View Details'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          child: const Text(
                            'Contact',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 5),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
