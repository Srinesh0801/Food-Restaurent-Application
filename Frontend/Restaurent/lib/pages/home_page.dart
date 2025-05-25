// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'staff_registration_page.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   static const lightningBlue = Color(0xFF3ABEF9);

//   // final List<String> imageUrls = const [
//   //   'https://source.unsplash.com/800x400/?college',  // Replace with your own URLs
//   //   'https://source.unsplash.com/800x400/?students',
//   //   'https://source.unsplash.com/800x400/?classroom',
//   //   'https://source.unsplash.com/800x400/?graduation',
//   // ];
//   final List<String> imageUrls = const [
//   'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60', // College building
//   'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60', // Students sitting
//   'https://images.unsplash.com/photo-1571260899304-425eee4c7efc?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60', // Classroom
//   'https://images.unsplash.com/photo-1588072432836-e10032774350?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60', // Graduation
// ];


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF0F9FF),
//       appBar: AppBar(
//         backgroundColor: lightningBlue,
//         elevation: 0,
//         title: const Row(
//           children: [
//             Icon(Icons.school, color: Colors.white),
//             SizedBox(width: 10),
//             Text(
//               'Zeus College',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: lightningBlue),
//               child: Text(
//                 'Menu',
//                 style: TextStyle(color: Colors.white, fontSize: 24),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person_add, color: lightningBlue),
//               title: const Text('Staff Registration'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const StaffRegistrationPage()),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Carousel Slider
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: 180,
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 aspectRatio: 16 / 9,
//               ),
//               items: imageUrls.map((url) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(url, fit: BoxFit.cover, width: double.infinity),
//                 );
//               }).toList(),
//             ),
//             const SizedBox(height: 20),

//             // About Section
//             Card(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//               elevation: 6,
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: const [
//                     Text(
//                       'About Zeus College',
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: lightningBlue),
//                     ),
//                     SizedBox(height: 10),
//                     Text(
//                       'Zeus College is a premier institute dedicated to excellence in education, '
//                       'fostering innovation and nurturing tomorrow’s leaders. Our campus is equipped with world-class facilities, '
//                       'high-quality faculty, and a strong placement track record.',
//                       style: TextStyle(fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Highlights Grid
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildHighlightCard(Icons.business_center, 'Placements'),
//                 _buildHighlightCard(Icons.group, 'Students'),
//                 _buildHighlightCard(Icons.people, 'Staff'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHighlightCard(IconData icon, String title) {
//     return Card(
//       color: lightningBlue.withOpacity(0.1),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         width: 100,
//         height: 100,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: lightningBlue, size: 30),
//             const SizedBox(height: 10),
//             Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For stylish fonts
// ignore: unused_import
import 'staff_registration_page.dart';
import 'staff_menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const orange = Color(0xFFFF6F00);
  bool isStrawberry = false;

  late AnimationController _spinController1;
  late AnimationController _spinController2;

  // For description animation
  late AnimationController _descAnimationController;
  late Animation<Offset> _descSlideAnimation;
  late Animation<double> _descFadeAnimation;

  @override
  void initState() {
    super.initState();
    _spinController1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _spinController2 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Description fade & slide animation
    _descAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _descSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _descAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _descFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _descAnimationController,
        curve: Curves.easeIn,
      ),
    );

    _descAnimationController.forward();
  }

  void toggleDonut() {
    setState(() {
      isStrawberry = !isStrawberry;
    });

    _spinController1.forward(from: 0.0);
    _spinController2.forward(from: 0.0);
  }

  @override
  void dispose() {
    _spinController1.dispose();
    _spinController2.dispose();
    _descAnimationController.dispose();
    super.dispose();
  }
 // <-- import the menu page

void _goToStaffRegistration() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const StaffMenuPage()),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),
      appBar: AppBar(
        backgroundColor: orange,
        elevation: 0,
        title: const Text(''),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: orange),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_add, color: orange),
              title: const Text('Staff Registration'),
              onTap: () {
                Navigator.pop(context);
                _goToStaffRegistration();
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // FOOD title with styled fonts and spinning donuts
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'F',
                  style: GoogleFonts.lobster(
                    fontSize: 72,
                    color: orange,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.orange.shade700,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // First spinning donut
                GestureDetector(
                  onTap: toggleDonut,
                  child: AnimatedBuilder(
                    animation: _spinController1,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _spinController1.value * 6.28, // 2π for full spin
                        child: child,
                      );
                    },
                    child: DonutCircle(isStrawberry: isStrawberry, size: 72),
                  ),
                ),

                const SizedBox(width: 12),

                // Second spinning donut
                GestureDetector(
                  onTap: toggleDonut,
                  child: AnimatedBuilder(
                    animation: _spinController2,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _spinController2.value * 6.28,
                        child: child,
                      );
                    },
                    child: DonutCircle(isStrawberry: isStrawberry, size: 72),
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  'D',
                  style: GoogleFonts.lobster(
                    fontSize: 72,
                    color: orange,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6,
                        color: Colors.orange.shade700,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Animated About Section with fade & slide
            FadeTransition(
              opacity: _descFadeAnimation,
              child: SlideTransition(
                position: _descSlideAnimation,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 6,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Discover FOOD',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: orange,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Step into a culinary adventure where every bite tells a story. FOOD blends passion with innovation to bring you unforgettable flavors crafted by master chefs. '
                          'Experience the harmony of fresh ingredients, warm ambiance, and heartfelt hospitality — your taste buds will thank you!',
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Highlights Grid with tap scale animation
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHighlightCard(Icons.star, 'Signature Dishes', orange, onTap: null),
                _buildHighlightCard(Icons.people, 'Customers', orange, onTap: null),
                _buildHighlightCard(
                  Icons.person,
                  'Staff',
                  orange,
                  onTap: _goToStaffRegistration,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightCard(IconData icon, String title, Color color, {VoidCallback? onTap}) {
    return _HighlightCard(
      icon: icon,
      title: title,
      color: color,
      onTap: onTap,
    );
  }
}

// Separate Stateful widget for highlight card with tap animation
class _HighlightCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const _HighlightCard({
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  });

  @override
  State<_HighlightCard> createState() => _HighlightCardState();
}

class _HighlightCardState extends State<_HighlightCard> with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    _scaleController.reverse();
  }

  void _onTapUp(_) {
    _scaleController.forward();
    if (widget.onTap != null) widget.onTap!();
  }

  void _onTapCancel() {
    _scaleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Widget card = Card(
      color: widget.color.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: widget.color, size: 30),
            const SizedBox(height: 10),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
    );

    if (widget.onTap == null) {
      return card;
    }

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleController,
        child: card,
      ),
    );
  }
}

// Donut circle widget with hole and sprinkles for realism
class DonutCircle extends StatelessWidget {
  final bool isStrawberry;
  final double size;

  const DonutCircle({
    super.key,
    required this.isStrawberry,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final chocolateBase = const Color(0xFF6F4E37);
    final chocolateHighlight = const Color(0xFFD2B48C);
    final strawberryBase = const Color(0xFFEF5B9C);
    final strawberryHighlight = const Color(0xFFF7B1C4);

    final baseColor = isStrawberry ? strawberryBase : chocolateBase;
    final highlightColor = isStrawberry ? strawberryHighlight : chocolateHighlight;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Donut base with radial gradient
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [baseColor, highlightColor],
              center: const Alignment(-0.3, -0.3),
              radius: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(3, 3),
              ),
            ],
          ),
        ),

        // Sprinkles overlay (dots)
        CustomPaint(
          size: Size(size, size),
          painter: SprinklePainter(isStrawberry: isStrawberry),
        ),

        // Hole in donut
        Container(
          width: size * 0.5,
          height: size * 0.5,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(-2, -2),
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Painter for sprinkles dots
class SprinklePainter extends CustomPainter {
  final bool isStrawberry;

  SprinklePainter({required this.isStrawberry});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final sprinklesChocolate = [
      Colors.redAccent,
      Colors.blueAccent,
      Colors.yellowAccent,
      Colors.white,
    ];

    final sprinklesStrawberry = [
      Colors.white,
      Colors.yellowAccent,
      Colors.lightBlueAccent,
      Colors.pinkAccent,
    ];

    final sprinkles = isStrawberry ? sprinklesStrawberry : sprinklesChocolate;

    // Positions for sprinkles relative to donut size
    final sprinklePositions = [
      Offset(size.width * 0.3, size.height * 0.2),
      Offset(size.width * 0.6, size.height * 0.35),
      Offset(size.width * 0.45, size.height * 0.6),
      Offset(size.width * 0.7, size.height * 0.7),
      Offset(size.width * 0.25, size.height * 0.7),
      Offset(size.width * 0.55, size.height * 0.5),
    ];

    for (int i = 0; i < sprinklePositions.length; i++) {
      paint.color = sprinkles[i % sprinkles.length];
      canvas.drawOval(
        Rect.fromCenter(center: sprinklePositions[i], width: 6, height: 3),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant SprinklePainter oldDelegate) {
    return oldDelegate.isStrawberry != isStrawberry;
  }
}
