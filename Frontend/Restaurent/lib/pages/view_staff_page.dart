import 'package:flutter/material.dart';
import '../services/Staffs/staff_service.dart';

class ViewStaffPage extends StatefulWidget {
  const ViewStaffPage({super.key});

  @override
  State<ViewStaffPage> createState() => _ViewStaffPageState();
}

class _ViewStaffPageState extends State<ViewStaffPage> {
  late Future<List<Map<String, dynamic>>> _staffFuture;

  @override
  void initState() {
    super.initState();
    _staffFuture = StaffService.getAllStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Staff'),
        backgroundColor: const Color(0xff2563eb),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _staffFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final staffList = snapshot.data!;
          if (staffList.isEmpty) {
            return const Center(child: Text('No staff found.'));
          }

          return ListView.builder(
            itemCount: staffList.length,
            itemBuilder: (context, index) {
              final staff = staffList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ExpansionTile(
                  title: Text(staff['name'] ?? 'Unnamed'),
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: [
                    _buildDetailRow('Email', staff['email']),
                    _buildDetailRow('Phone', staff['phone']),
                    _buildDetailRow('Department', staff['department']),
                    _buildDetailRow('Designation', staff['designation']),
                    _buildDetailRow('Staff ID', staff['staffId']),
                    _buildDetailRow('DOB', staff['dob']),
                    _buildDetailRow('Gender', staff['gender']),
                    _buildDetailRow('Address', staff['address']),
                    _buildDetailRow('Date of Joining', staff['dateOfJoining']),
                    _buildDetailRow('Qualification', staff['qualification']),
                    _buildDetailRow('Experience', staff['experience']),
                    _buildDetailRow('Blood Group', staff['bloodGroup']),
                    _buildDetailRow('Emergency Contact', staff['emergencyContact']),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value?.toString() ?? '-')),
        ],
      ),
    );
  }
}




// import 'dart:async';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ViewStaffPage extends StatefulWidget {
//   const ViewStaffPage({Key? key}) : super(key: key);

//   @override
//   _ViewStaffPageState createState() => _ViewStaffPageState();
// }

// class _ViewStaffPageState extends State<ViewStaffPage> with TickerProviderStateMixin {
//   int _selectedIndex = -1;
//   Map<String, dynamic>? _selectedStaff;
//   late Future<List<Map<String, dynamic>>> _staffFuture;

//   late AnimationController _colorController;
//   late Animation<Color?> _colorAnimation;
//   Color _backgroundColor = Colors.deepPurpleAccent;

//   final List<String> _backgroundImages = [
//     'https://images.unsplash.com/photo-1532619675605-1e4b9ff61f90?auto=format&fit=crop&w=1400&q=80',
//     'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=1400&q=80',
//     'https://images.unsplash.com/photo-1506784983877-45594efa4cbe?auto=format&fit=crop&w=1400&q=80'
//   ];
//   int _currentBgImageIndex = 0;
//   Timer? _bgImageTimer;

//   @override
//   void initState() {
//     super.initState();
//     _staffFuture = _fetchStaff();

//     _colorController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 6),
//     )..repeat(reverse: true);

//     _colorAnimation = ColorTween(
//       begin: Colors.deepPurpleAccent,
//       end: Colors.tealAccent,
//     ).animate(CurvedAnimation(parent: _colorController, curve: Curves.easeInOut));

//     _bgImageTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
//       setState(() {
//         _currentBgImageIndex = (_currentBgImageIndex + 1) % _backgroundImages.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _colorController.dispose();
//     _bgImageTimer?.cancel();
//     super.dispose();
//   }

//   Future<List<Map<String, dynamic>>> _fetchStaff() async {
//     final response = await http.get(Uri.parse('http://localhost:3000/staff'));

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.cast<Map<String, dynamic>>();
//     } else {
//       throw Exception('Failed to load staff');
//     }
//   }

//   void _onNameTap(int index, Map<String, dynamic> staff) {
//     setState(() {
//       _selectedIndex = index;
//       _selectedStaff = staff;
//     });
//   }

//   String _getInitials(String name) {
//     final parts = name.trim().split(' ');
//     if (parts.length == 1) return parts[0][0];
//     return parts[0][0] + parts[1][0];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FutureBuilder<List<Map<String, dynamic>>>(
//         future: _staffFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: Colors.white));
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.white)),
//             );
//           }

//           final staffList = snapshot.data!;

//           return LayoutBuilder(
//             builder: (context, constraints) {
//               if (constraints.maxWidth > 700) {
//                 return _buildWideScreenLayout(staffList);
//               } else {
//                 return _buildMobileLayout(staffList);
//               }
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildWideScreenLayout(List<Map<String, dynamic>> staffList) {
//     return Stack(
//       children: [
//         ..._backgroundImages.asMap().entries.map((entry) {
//           int i = entry.key;
//           String imgUrl = entry.value;
//           bool visible = i == _currentBgImageIndex;
//           return AnimatedOpacity(
//             duration: const Duration(milliseconds: 700),
//             opacity: visible ? 1 : 0,
//             curve: Curves.easeInOut,
//             child: Image.network(
//               imgUrl,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//               colorBlendMode: BlendMode.darken,
//               color: Colors.black.withOpacity(0.5),
//             ),
//           );
//         }),
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 800),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [(_colorAnimation.value ?? _backgroundColor).withOpacity(0.85), Colors.black87],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Text(
//                   'Staff Management',
//                   style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 280,
//                       color: Colors.black.withOpacity(0.3),
//                       child: ListView.builder(
//                         itemCount: staffList.length,
//                         itemBuilder: (context, index) {
//                           final staff = staffList[index];
//                           final isSelected = _selectedIndex == index;
//                           return ListTile(
//                             leading: CircleAvatar(
//                               backgroundColor: Colors.white24,
//                               child: Text(_getInitials(staff['name'] ?? '')),
//                             ),
//                             title: Text(
//                               staff['name'] ?? '',
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                             subtitle: Text(
//                               staff['designation'] ?? '',
//                               style: const TextStyle(color: Colors.white60),
//                             ),
//                             tileColor: isSelected ? Colors.white10 : Colors.transparent,
//                             onTap: () => _onNameTap(index, staff),
//                           );
//                         },
//                       ),
//                     ),
//                     const VerticalDivider(width: 1, color: Colors.white24),
//                     Expanded(
//                       child: _selectedStaff == null
//                           ? const Center(child: Text('Select a staff', style: TextStyle(color: Colors.white)))
//                           : _buildDetailsGlassCard(_selectedStaff!),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildMobileLayout(List<Map<String, dynamic>> staffList) {
//     return Stack(
//       children: [
//         AnimatedOpacity(
//           duration: const Duration(milliseconds: 700),
//           opacity: 1,
//           child: Image.network(
//             _backgroundImages[_currentBgImageIndex],
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: double.infinity,
//             colorBlendMode: BlendMode.darken,
//             color: Colors.black.withOpacity(0.5),
//           ),
//         ),
//         AnimatedContainer(
//           duration: const Duration(milliseconds: 800),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [(_colorAnimation.value ?? _backgroundColor).withOpacity(0.85), Colors.black87],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         SafeArea(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Text(
//                   'Staff Management',
//                   style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: staffList.length,
//                   itemBuilder: (context, index) {
//                     final staff = staffList[index];
//                     return Card(
//                       color: Colors.white.withOpacity(0.1),
//                       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor: Colors.white30,
//                           child: Text(_getInitials(staff['name'] ?? '')),
//                         ),
//                         title: Text(staff['name'] ?? '', style: const TextStyle(color: Colors.white)),
//                         subtitle: Text(staff['designation'] ?? '', style: const TextStyle(color: Colors.white60)),
//                         trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white60),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => StaffDetailsPage(staff: staff),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildDetailsGlassCard(Map<String, dynamic> staff) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(25),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
//           child: Container(
//             padding: const EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(25),
//               border: Border.all(color: Colors.white24, width: 2),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.white24,
//                   child: Text(
//                     _getInitials(staff['name'] ?? ''),
//                     style: const TextStyle(fontSize: 24, color: Colors.white),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   staff['name'] ?? '',
//                   style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   staff['designation'] ?? '',
//                   style: const TextStyle(color: Colors.white70),
//                 ),
//                 const Divider(color: Colors.white24, height: 30),
//                 Text('Staff ID: ${staff['staffId'] ?? ''}', style: const TextStyle(color: Colors.white70)),
//                 Text('Phone: ${staff['phone'] ?? ''}', style: const TextStyle(color: Colors.white70)),
//                 Text('Email: ${staff['email'] ?? ''}', style: const TextStyle(color: Colors.white70)),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class StaffDetailsPage extends StatelessWidget {
//   final Map<String, dynamic> staff;
//   const StaffDetailsPage({super.key, required this.staff});

//   String _getInitials(String name) {
//     final parts = name.trim().split(' ');
//     if (parts.length == 1) return parts[0][0];
//     return parts[0][0] + parts[1][0];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text(staff['name'] ?? 'Details', style: const TextStyle(color: Colors.white)),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(25),
//             child: BackdropFilter(
//               filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
//               child: Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(25),
//                   border: Border.all(color: Colors.white24, width: 2),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.white24,
//                       child: Text(
//                         _getInitials(staff['name'] ?? ''),
//                         style: const TextStyle(fontSize: 24, color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       staff['name'] ?? '',
//                       style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       staff['designation'] ?? '',
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                     const Divider(color: Colors.white24, height: 30),
//                     Text('Staff ID: ${staff['staffId'] ?? ''}', style: const TextStyle(color: Colors.white70)),
//                     Text('Phone: ${staff['phone'] ?? ''}', style: const TextStyle(color: Colors.white70)),
//                     Text('Email: ${staff['email'] ?? ''}', style: const TextStyle(color: Colors.white70)),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
