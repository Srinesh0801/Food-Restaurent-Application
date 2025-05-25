import 'package:flutter/material.dart';
import '../services/Staffs/staff_service.dart';

class DeleteStaffPage extends StatefulWidget {
  const DeleteStaffPage({super.key});

  @override
  State<DeleteStaffPage> createState() => _DeleteStaffPageState();
}

class _DeleteStaffPageState extends State<DeleteStaffPage> {
  late Future<List<Map<String, dynamic>>> _staffFuture;

  @override
  void initState() {
    super.initState();
    _loadStaff();
  }

  void _loadStaff() {
    _staffFuture = StaffService.getAllStaff();
  }

  void _deleteStaff(String name) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete $name?'),
        content: const Text('Are you sure you want to delete this staff?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await StaffService.deleteStaffByName(name);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleted $name successfully')));
        setState(() {
          _loadStaff(); // Refresh staff list
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete $name: $e')));
      }
    }
  }

  void _showDetails(Map<String, dynamic> staff) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(staff['name'] ?? 'Staff Details'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: staff.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text("${entry.key}: ${entry.value}"),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Staff')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _staffFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final staffList = snapshot.data ?? [];
          if (staffList.isEmpty) {
            return const Center(child: Text('No staff found.'));
          }

          return ListView.separated(
            itemCount: staffList.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final staff = staffList[index];
              final name = staff['name'] ?? 'Unknown';

              return ListTile(
                title: Text(name),
                subtitle: Text(staff['role'] ?? ''),
                onTap: () => _showDetails(staff),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteStaff(name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
