import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../services/Staffs/staff_service.dart';
// import 'staff_menu_page.dart'; // <-- import the menu page




class StaffRegistrationPage extends StatefulWidget {
  const StaffRegistrationPage({super.key});

  @override
  State<StaffRegistrationPage> createState() => _StaffRegistrationPageState();
}

class _StaffRegistrationPageState extends State<StaffRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> staffData = {};

  void registerStaff() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    try {
      final response = await StaffService.addStaff(staffData);
      Fluttertoast.showToast(msg: response['message'] ?? 'Staff added successfully');
      _formKey.currentState!.reset();
      staffData.clear();
      setState(() {}); // Reset UI
    } catch (e) {
      Fluttertoast.showToast(msg: 'Failed to add staff: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f5f9),
      appBar: AppBar(
        title: const Text("Staff Registration"),
        backgroundColor: const Color(0xff2563eb),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("name", label: "Name"),
_buildDropdownField("role", label: "Role", options: [
  "Chef",
  "Waiter",
  "Manager",
  "Cleaner",
  "Cashier",
  "Receptionist",
  "CEO",
  "Other"
]),
_buildTextField(
  "email",
  label: "Email",
  validator: (val) {
    if (val == null || val.trim().isEmpty) return 'Enter email';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(val.trim())) return 'Enter a valid email';
    return null;
  },
),
_buildTextField("phone", label: "Phone"),
_buildDropdownField("gender", label: "Gender", options: ["Male", "Female", "Other"]),
_buildDatePickerField("dob", label: "Date of Birth"),
_buildTextField("address", label: "Address"),
_buildDropdownField("branch", label: "Branch", options: [
  "Main Street",
  "Downtown",
  "Uptown"
]),
_buildDropdownField("shift", label: "Shift", options: [
  "Morning",
  "Afternoon",
  "Evening",
  "Night",
  "Full Day"
]),
_buildTextField("experience", label: "Experience"),
_buildDatePickerField("dateOfJoining", label: "Date of Joining"),
_buildTextField("bloodGroup", label: "Blood Group"),
_buildTextField("emergencyContact", label: "Emergency Contact"),
_buildTextField("staffId", label: "Staff ID (optional)"),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff22c55e),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: registerStaff,
                      child: const Text("Register Staff", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, [String? hint]) {
    return InputDecoration(
      labelText: label,
      hintText: hint ?? '',
      filled: true,
      fillColor: const Color(0xfff8fafc),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xffcbd5e1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xffcbd5e1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Color(0xff2563eb)),
      ),
    );
  }

  Widget _buildTextField(String key, {String? label, String? hint, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: staffData[key],
        decoration: _inputDecoration(label ?? _capitalize(key), hint),
        onSaved: (val) => staffData[key] = val?.trim() ?? '',
        validator: validator ??
            (val) {
              if (val == null || val.trim().isEmpty) return 'Enter ${label ?? _capitalize(key)}';
              return null;
            },
      ),
    );
  }

  Widget _buildDatePickerField(String key, {required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        readOnly: true,
        controller: TextEditingController(text: staffData[key]),
        decoration: _inputDecoration(label),
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            String formatted = DateFormat('yyyy-MM-dd').format(picked);
            setState(() {
              staffData[key] = formatted;
            });
          }
        },
        validator: (val) {
          if ((staffData[key] ?? '').isEmpty) return 'Select $label';
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownField(String key, {required String label, required List<String> options}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        decoration: _inputDecoration(label),
        value: (staffData[key] != null && staffData[key]!.isNotEmpty) ? staffData[key] : null,
        items: options
            .map((value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (val) {
          setState(() {
            staffData[key] = val ?? '';
          });
        },
        validator: (val) => (val == null || val.isEmpty) ? 'Select $label' : null,
      ),
    );
  }

  String _capitalize(String s) => s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;
}

////////////////////////

// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import '../services/staff_service.dart';

// class StaffRegistrationPage extends StatefulWidget {
//   const StaffRegistrationPage({super.key});

//   @override
//   State<StaffRegistrationPage> createState() => _StaffRegistrationPageState();
// }

// class _StaffRegistrationPageState extends State<StaffRegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   final Map<String, String> staffData = {};

//   final Map<String, TextEditingController> _dateControllers = {
//     'dob': TextEditingController(),
//     'dateOfJoining': TextEditingController(),
//   };

//   @override
//   void dispose() {
//     for (final controller in _dateControllers.values) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void registerStaff() async {
//     if (!_formKey.currentState!.validate()) return;
//     _formKey.currentState!.save();

//     try {
//       final response = await StaffService.addStaff(staffData);
//       Fluttertoast.showToast(msg: response['message'] ?? 'Staff added successfully');
//       _formKey.currentState!.reset();
//       staffData.clear();
//       _dateControllers.forEach((key, controller) => controller.clear());
//       setState(() {}); // Reset UI
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Failed to add staff: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff1f5f9),
//       appBar: AppBar(
//         title: const Text("Staff Registration"),
//         backgroundColor: const Color(0xff2563eb),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Card(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           elevation: 8,
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   _buildTextField("name", label: "Name"),
//                   _buildTextField("department", label: "Department"),
//                   _buildTextField(
//                     "email",
//                     label: "Email",
//                     validator: (val) {
//                       if (val == null || val.trim().isEmpty) return 'Enter email';
//                       final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//                       if (!emailRegex.hasMatch(val.trim())) return 'Enter a valid email';
//                       return null;
//                     },
//                   ),
//                   _buildTextField("phone", label: "Phone"),
//                   _buildTextField("designation", label: "Designation"),
//                   _buildTextField("staffId", label: "Staff ID (optional)"),
//                   _buildDatePickerField("dob", label: "Date of Birth"),
//                   _buildDropdownField("gender", label: "Gender", options: ["Male", "Female", "Other"]),
//                   _buildTextField("address", label: "Address"),
//                   _buildDatePickerField("dateOfJoining", label: "Date of Joining"),
//                   _buildTextField("qualification", label: "Qualification"),
//                   _buildTextField("experience", label: "Experience"),
//                   _buildTextField("bloodGroup", label: "Blood Group"),
//                   _buildTextField("emergencyContact", label: "Emergency Contact"),
//                   const SizedBox(height: 20),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xff22c55e),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                       ),
//                       onPressed: registerStaff,
//                       child: const Text("Register Staff", style: TextStyle(fontSize: 16)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(String label, [String? hint]) {
//     return InputDecoration(
//       labelText: label,
//       hintText: hint ?? '',
//       filled: true,
//       fillColor: const Color(0xfff8fafc),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: const BorderSide(color: Color(0xffcbd5e1)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: const BorderSide(color: Color(0xffcbd5e1)),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: const BorderSide(color: Color(0xff2563eb)),
//       ),
//     );
//   }

//   Widget _buildTextField(String key, {String? label, String? hint, String? Function(String?)? validator}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         initialValue: staffData[key],
//         decoration: _inputDecoration(label ?? _capitalize(key), hint),
//         onSaved: (val) => staffData[key] = val?.trim() ?? '',
//         validator: validator ?? (val) {
//           if (val == null || val.trim().isEmpty) return 'Enter ${label ?? _capitalize(key)}';
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildDatePickerField(String key, {required String label}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: _dateControllers[key],
//         readOnly: true,
//         decoration: _inputDecoration(label),
//         onTap: () async {
//           DateTime? picked = await showDatePicker(
//             context: context,
//             initialDate: DateTime.now(),
//             firstDate: DateTime(1950),
//             lastDate: DateTime(2100),
//           );
//           if (picked != null) {
//             String formatted = DateFormat('yyyy-MM-dd').format(picked);
//             setState(() {
//               staffData[key] = formatted;
//               _dateControllers[key]?.text = formatted;
//             });
//           }
//         },
//         validator: (val) {
//           if ((staffData[key] ?? '').isEmpty) return 'Select $label';
//           return null;
//         },
//       ),
//     );
//   }

//   Widget _buildDropdownField(String key, {required String label, required List<String> options}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: DropdownButtonFormField<String>(
//         decoration: _inputDecoration(label),
//         value: (staffData[key] != null && staffData[key]!.isNotEmpty) ? staffData[key] : null,
//         items: options
//             .map((value) => DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 ))
//             .toList(),
//         onChanged: (val) {
//           setState(() {
//             staffData[key] = val ?? '';
//           });
//         },
//         validator: (val) => (val == null || val.isEmpty) ? 'Select $label' : null,
//       ),
//     );
//   }

//   String _capitalize(String s) => s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : s;
// }
