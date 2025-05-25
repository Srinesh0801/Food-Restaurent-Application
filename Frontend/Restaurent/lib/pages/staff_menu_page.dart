// import 'package:flutter/material.dart';
// import 'add_staff_page.dart';
// import 'view_staff_page.dart';
// import 'edit_staff_page.dart';
// import 'delete_staff_page.dart';

// class StaffMenuPage extends StatelessWidget {
//   const StaffMenuPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final orange = const Color(0xFFFF6F00);

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: orange,
//         title: const Text('Staff Management'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           _buildOptionCard(
//             context,
//             title: 'View Staff',
//             icon: Icons.visibility,
//             color: orange,
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const ViewStaffPage()),
//             ),
//           ),
//           _buildOptionCard(
//             context,
//             title: 'Add Staff',
//             icon: Icons.person_add,
//             color: orange,
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const AddStaffPage()),
//             ),
//           ),
//           _buildOptionCard(
//             context,
//             title: 'Edit Staff',
//             icon: Icons.edit,
//             color: orange,
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const EditStaffPage()),
//             ),
//           ),
//           _buildOptionCard(
//             context,
//             title: 'Delete Staff',
//             icon: Icons.delete,
//             color: orange,
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const DeleteStaffPage()),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildOptionCard(BuildContext context,
//       {required String title,
//       required IconData icon,
//       required Color color,
//       required VoidCallback onTap}) {
//     return Card(
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: ListTile(
//         leading: Icon(icon, color: color),
//         title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
//         trailing: const Icon(Icons.arrow_forward_ios),
//         onTap: onTap,
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
// import 'add_staff_page.dart';
import 'view_staff_page.dart';
import 'edit_staff_page.dart';
import 'delete_staff_page.dart';
import 'staff_registration_page.dart';

class StaffMenuPage extends StatelessWidget {
  const StaffMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Management'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildOption(context, 'View Staff', Icons.people, const ViewStaffPage()),
          _buildOption(context, 'Add Staff', Icons.person_add, const StaffRegistrationPage()),
          _buildOption(context, 'Edit Staff', Icons.edit, const EditStaffPage()),
          _buildOption(context, 'Delete Staff', Icons.delete, const DeleteStaffPage()),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, IconData icon, Widget page) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}
