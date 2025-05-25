import 'package:flutter/material.dart';
import '../services/Staffs/staff_service.dart';

class EditStaffPage extends StatefulWidget {
  const EditStaffPage({super.key});

  @override
  State<EditStaffPage> createState() => _EditStaffPageState();
}

class _EditStaffPageState extends State<EditStaffPage> {
  late Future<List<Map<String, dynamic>>> _staffFuture;
  Map<String, dynamic>? _selectedStaff;

  // Controllers for input fields
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  final _branchController = TextEditingController();
  final _shiftController = TextEditingController();
  final _experienceController = TextEditingController();
  final _dateOfJoiningController = TextEditingController();
  final _addressController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _emergencyContactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStaff();
  }

  void _loadStaff() {
    _staffFuture = StaffService.getAllStaff();
  }

  void _loadStaffDetails(Map<String, dynamic> staff) {
    _selectedStaff = staff;
    _nameController.text = staff['name'] ?? '';
    _roleController.text = staff['role'] ?? '';
    _emailController.text = staff['email'] ?? '';
    _phoneController.text = staff['phone'] ?? '';
    _genderController.text = staff['gender'] ?? '';
    _dobController.text = staff['dob'] ?? '';
    _branchController.text = staff['branch'] ?? '';
    _shiftController.text = staff['shift'] ?? '';
    _experienceController.text = staff['experience'] ?? '';
    _dateOfJoiningController.text = staff['dateOfJoining'] ?? '';
    _addressController.text = staff['address'] ?? '';
    _bloodGroupController.text = staff['bloodGroup'] ?? '';
    _emergencyContactController.text = staff['emergencyContact'] ?? '';
    setState(() {});
  }

  void _updateStaff() async {
    if (_selectedStaff == null) return;

    final updatedData = {
      "name": _nameController.text,
      "role": _roleController.text,
      "email": _emailController.text,
      "phone": _phoneController.text,
      "gender": _genderController.text,
      "dob": _dobController.text,
      "branch": _branchController.text,
      "shift": _shiftController.text,
      "experience": _experienceController.text,
      "dateOfJoining": _dateOfJoiningController.text,
      "address": _addressController.text,
      "bloodGroup": _bloodGroupController.text,
      "emergencyContact": _emergencyContactController.text,
    };

    try {
      await StaffService.updateStaffByName(_selectedStaff!['name'], updatedData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Staff updated successfully')),
      );
      _loadStaff();
      setState(() {
        _selectedStaff = null;
        _clearControllers();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update staff: $e')),
      );
    }
  }

  void _clearControllers() {
    _nameController.clear();
    _roleController.clear();
    _emailController.clear();
    _phoneController.clear();
    _genderController.clear();
    _dobController.clear();
    _branchController.clear();
    _shiftController.clear();
    _experienceController.clear();
    _dateOfJoiningController.clear();
    _addressController.clear();
    _bloodGroupController.clear();
    _emergencyContactController.clear();
  }

  Widget _buildGridTextField(String label, TextEditingController controller) {
  return SizedBox(
    width: 200,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        isDense: true,
      ),
    ),
  );
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Staff')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _staffFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final staffList = snapshot.data ?? [];
          if (staffList.isEmpty) {
            return const Center(child: Text('No staff found.'));
          }

          return Row(
            children: [
              // Staff List on left
              Container(
                width: 250,
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey.shade300)),
                ),
                child: ListView.separated(
                  itemCount: staffList.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final staff = staffList[index];
                    final name = staff['name'] ?? 'Unknown';
                    final role = staff['role'] ?? 'Unknown Role';
                    final isSelected = _selectedStaff != null && _selectedStaff!['name'] == name;

                    return ListTile(
                      selected: isSelected,
                      title: Text(name),
                      subtitle: Text(role),
                      onTap: () => _loadStaffDetails(staff),
                    );
                  },
                ),
              ),

              // Vertical divider
              const VerticalDivider(width: 1),

              // Details form centered
              Expanded(
                child: Center(
                  child: Container(
                    width: 450,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _selectedStaff == null
                        ? const Text(
                            'Select a staff from the left to edit details.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                            textAlign: TextAlign.center,
                          )
                        : SingleChildScrollView(
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Wrap(
        spacing: 16,
        runSpacing: 12,
        children: [
          _buildGridTextField('Name', _nameController),
          _buildGridTextField('Role', _roleController),
          _buildGridTextField('Email', _emailController),
          _buildGridTextField('Phone', _phoneController),
          _buildGridTextField('Gender', _genderController),
          _buildGridTextField('DOB', _dobController),
          _buildGridTextField('Branch', _branchController),
          _buildGridTextField('Shift', _shiftController),
          _buildGridTextField('Experience', _experienceController),
          _buildGridTextField('Date Of Joining', _dateOfJoiningController),
          _buildGridTextField('Address', _addressController),
          _buildGridTextField('Blood Group', _bloodGroupController),
          _buildGridTextField('Emergency Contact', _emergencyContactController),
        ],
      ),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: _updateStaff,
        child: const Text('Update'),
      ),
    ],
  ),
),

                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
