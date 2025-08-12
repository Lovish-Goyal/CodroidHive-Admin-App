// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:uuid/uuid.dart';
// import '../../models/user_model/user_model.dart';
// import '../../providers/user_provider.dart';
// import '../home/widgets/users_details_screen.dart';

// class UsersScreen extends ConsumerStatefulWidget {
//   const UsersScreen({super.key});

//   @override
//   ConsumerState<UsersScreen> createState() => _UsersScreenState();
// }

// class _UsersScreenState extends ConsumerState<UsersScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _phoneController = TextEditingController();
//   DateTime? _dob;
//   String _gender = 'Male';
//   String _selectedRole = 'Alumni';

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(userProvider.notifier).fetchAllUsers();
//     });
//   }

//   Future<void> _submit() async {
//     if (_formKey.currentState!.validate() && _dob != null) {
//       final newUser = UserModel(
//         id: const Uuid().v4(),
//         username: _nameController.text.trim(),
//         email: _emailController.text.trim(),
//         phoneNumber: _phoneController.text.trim(),
//         dateOfBirth: _dob!,
//         gender: _gender,
//         role: _selectedRole,
//         createdAt: DateTime.now(),
//         updatedAt: DateTime.now(),
//         status: '',
//       );

//       await ref.read(userProvider.notifier).addUser(newUser);
//       Navigator.of(context).pop();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('User added successfully')),
//       );

//       _formKey.currentState?.reset();
//       _nameController.clear();
//       _emailController.clear();
//       _phoneController.clear();
//       _passwordController.clear();
//       setState(() => _dob = null);
//       ref.read(userProvider.notifier).fetchAllUsers();
//     } else if (_dob == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please select a date of birth')),
//       );
//     }
//   }

//   void _showAddUserDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: const Text('Add New User',
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         content: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 _buildTextField(_nameController, 'Full Name', Icons.person,
//                     (val) => val!.isEmpty ? 'Enter name' : null),
//                 _buildTextField(_emailController, 'Email', Icons.email, (val) {
//                   if (val == null || val.isEmpty || !val.contains('@')) {
//                     return 'Enter a valid email';
//                   }
//                   return null;
//                 }, keyboardType: TextInputType.emailAddress),
//                 _buildTextField(_passwordController, 'Password', Icons.lock,
//                     (val) => val!.isEmpty ? 'Enter password' : null,
//                     obscureText: true),
//                 _buildTextField(_phoneController, 'Phone Number', Icons.phone,
//                     (val) {
//                   if (val == null || val.length < 10) {
//                     return 'Enter a valid number';
//                   }
//                   return null;
//                 }, keyboardType: TextInputType.phone),
//                 const SizedBox(height: 10),
//                 ListTile(
//                   contentPadding: EdgeInsets.zero,
//                   title: Text(
//                     _dob == null
//                         ? 'Select Date of Birth'
//                         : 'DOB: ${_dob!.toLocal().toIso8601String().split('T')[0]}',
//                   ),
//                   trailing: const Icon(Icons.calendar_today),
//                   onTap: () async {
//                     final picked = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime(2000),
//                       firstDate: DateTime(1950),
//                       lastDate: DateTime.now(),
//                     );
//                     if (picked != null) setState(() => _dob = picked);
//                   },
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _gender,
//                   decoration: const InputDecoration(
//                       labelText: 'Gender', prefixIcon: Icon(Icons.wc)),
//                   items: const [
//                     DropdownMenuItem(value: 'Male', child: Text('Male')),
//                     DropdownMenuItem(value: 'Female', child: Text('Female')),
//                     DropdownMenuItem(value: 'Other', child: Text('Other')),
//                   ],
//                   onChanged: (val) => setState(() => _gender = val!),
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _selectedRole,
//                   decoration: const InputDecoration(
//                       labelText: 'Role', prefixIcon: Icon(Icons.work_outline)),
//                   items: const [
//                     DropdownMenuItem(value: 'Alumni', child: Text('Alumni')),
//                     DropdownMenuItem(
//                         value: 'Employee', child: Text('Employee')),
//                   ],
//                   onChanged: (val) => setState(() => _selectedRole = val!),
//                   validator: (val) => val!.isEmpty ? 'Select role' : null,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(),
//             child: const Text('Cancel'),
//           ),
//           FilledButton.icon(
//             onPressed: _submit,
//             icon: const Icon(Icons.check),
//             label: const Text('Add User'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField(
//     TextEditingController controller,
//     String label,
//     IconData icon,
//     String? Function(String?) validator, {
//     TextInputType keyboardType = TextInputType.text,
//     bool obscureText = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//         ),
//         validator: validator,
//       ),
//     );
//   }

//   Widget _buildUserList() {
//     final userState = ref.watch(userProvider);

//     return userState.when(
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (e, _) => Center(child: Text('Error: $e')),
//       data: (users) => users.isEmpty
//           ? const Center(child: Text('No users found'))
//           : ListView.separated(
//               itemCount: users.length,
//               separatorBuilder: (_, __) => const Divider(),
//               itemBuilder: (context, index) {
//                 final user = users[index];
//                 return ListTile(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => UserDetailScreen(user: user),
//                       ),
//                     );
//                   },
//                   leading:
//                       CircleAvatar(child: Text(user.username[0].toUpperCase())),
//                   title: Text(user.username),
//                   subtitle: Text('${user.email} • ${user.phoneNumber}'),
//                   trailing: Chip(label: Text(user.role)),
//                 );
//               },
//             ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Users',
//           style: TextStyle(color: Color.fromARGB(255, 10, 29, 86)),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: _buildUserList(),
//       ),
//       floatingActionButton: GestureDetector(
//         onTap: _showAddUserDialog,
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF0A1D56), Color(0xFF1976D2)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(30),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 blurRadius: 8,
//                 offset: const Offset(2, 4),
//               )
//             ],
//           ),
//           child: const Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.add, color: Colors.white),
//               SizedBox(width: 6),
//               Text(
//                 'Add User',
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  Widget _buildUserList(String status) {
    final userState = ref.watch(userProvider);

    return userState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (data) {
        final users = data[status] ?? [];
        if (users.isEmpty) return const Center(child: Text('No users found'));

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, i) {
            final user = users[i];
            return ListTile(
              title: Text(user.username),
              subtitle: Text('${user.email} • ${user.phoneNumber}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (status == 'pending')
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      tooltip: 'Approve',
                      onPressed: () =>
                          ref.read(userProvider.notifier).approveUser(user),
                    ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Remove',
                    onPressed: () =>
                        ref.read(userProvider.notifier).deleteUser(user.id),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Users'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Approved'),
              Tab(text: 'Pending'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUserList('approved'),
            _buildUserList('pending'),
          ],
        ),
      ),
    );
  }
}
