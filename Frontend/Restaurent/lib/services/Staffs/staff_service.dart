import 'dart:convert';
import 'package:http/http.dart' as http;

class StaffService {
  static const String baseUrl = 'http://localhost:3000/api/auth';

//   static Future<Map<String, dynamic>> addStaff(Map<String, dynamic> staffData) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/add-staff'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(staffData),
//     );
//     return jsonDecode(response.body);
//   }

//   // static Future<List<dynamic>> getAllStaff() async {
//   //   final response = await http.get(Uri.parse('$baseUrl/all-staff'));
//   //   return jsonDecode(response.body);
//   // }
//   static Future<List<Map<String, dynamic>>> getAllStaff() async {
//   final response = await http.get(Uri.parse('$baseUrl/all-staff'));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = jsonDecode(response.body);
//     return data.cast<Map<String, dynamic>>();
//   } else {
//     throw Exception('Failed to load staff data');
//   }
// }


//   static Future<Map<String, dynamic>> getStaffById(String id) async {
//     final response = await http.get(Uri.parse('$baseUrl/staff/$id'));
//     return jsonDecode(response.body);
//   }

//   static Future<Map<String, dynamic>> updateStaff(String id, Map<String, dynamic> staffData) async {
//     final response = await http.put(
//       Uri.parse('$baseUrl/update-staff/$id'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(staffData),
//     );
//     return jsonDecode(response.body);
//   }

//   static Future<Map<String, dynamic>> deleteStaff(String id) async {
//     final response = await http.delete(Uri.parse('$baseUrl/delete-staff/$id'));
//     return jsonDecode(response.body);
//   }
// }





 // Add new staff
  static Future<Map<String, dynamic>> addStaff(Map<String, String> staffData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-staff'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(staffData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add staff');
    }
  }

  // Get all staff
  static Future<List<Map<String, dynamic>>> getAllStaff() async {
    final response = await http.get(Uri.parse('$baseUrl/all-staff'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      // cast each item to Map<String, dynamic>
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load staff list');
    }
  }

  // Get staff by name
  static Future<Map<String, dynamic>> getStaffByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/staff/$name'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Staff not found');
    }
  }

  // Update staff by name
  static Future<Map<String, dynamic>> updateStaffByName(String name, Map<String, String> updatedData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/update-staff/$name'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update staff');
    }
  }

  // Delete staff by name
  static Future<void> deleteStaffByName(String name) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete-staff/$name'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete staff');
    }
  }
}