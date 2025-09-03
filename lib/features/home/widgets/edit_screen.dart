import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/user_model/user_model.dart';

class EditUserScreen extends ConsumerStatefulWidget {
  final UserModel user;

  const EditUserScreen({super.key, required this.user});

  @override
  ConsumerState<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends ConsumerState<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String _gender = 'Male';
  String _role = 'Alumni';
  DateTime? _dob;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.username);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
    _gender = widget.user.gender;
    _role = widget.user.role;
    _dob = widget.user.dateOfBirth;
  }

  Future<void> _save() async {
    // if (_formKey.currentState!.validate() && _dob != null) {
    //   final updatedUser = widget.user.copyWith(
    //     username: _nameController.text.trim(),
    //     email: _emailController.text.trim(),
    //     phoneNumber: _phoneController.text.trim(),
    //     gender: _gender,
    //     role: _role,
    //     dateOfBirth: _dob!,
    //     updatedAt: DateTime.now(),
    //   );
    //   await ref.read(userProvider.notifier).updateUser(updatedUser);
    //   Navigator.pop(context, updatedUser);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Full Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (val) => val!.isEmpty ? 'Enter full name' : null,
              ),
              const SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val == null || !val.contains('@')
                    ? 'Enter valid email'
                    : null,
              ),
              const SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val!.length < 10 ? 'Enter valid number' : null,
              ),
              const SizedBox(height: 16),

              // Date of Birth
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _dob == null
                      ? 'Select Date of Birth'
                      : 'DOB: ${_dob!.toLocal().toIso8601String().split("T")[0]}',
                  style: const TextStyle(fontSize: 16),
                ),
                leading: const Icon(Icons.cake),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _dob ?? DateTime(2000),
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _dob = picked);
                  }
                },
              ),
              const Divider(height: 32),

              // Gender Dropdown
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (val) => setState(() => _gender = val!),
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.wc),
                ),
              ),
              const SizedBox(height: 16),

              // Role Dropdown
              DropdownButtonFormField<String>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'Alumni', child: Text('Alumni')),
                  DropdownMenuItem(value: 'Employee', child: Text('Employee')),
                ],
                onChanged: (val) => setState(() => _role = val!),
                decoration: const InputDecoration(
                  labelText: 'Role',
                  prefixIcon: Icon(Icons.badge),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        height: 60,
        child: FilledButton.icon(
          icon: const Icon(Icons.save),
          label: const Text('Save Changes'),
          onPressed: _save,
        ),
      ),
    );
  }
}
