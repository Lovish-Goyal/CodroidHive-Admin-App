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
                      onPressed: () async {
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Confirm Delete'),
                            content: Text(
                                'Are you sure you want to delete this user?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false), // Cancel
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.pop(context, true), // Confirm
                                child: Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white),
                              ),
                            ],
                          ),
                        );

                        if (shouldDelete == true) {
                          ref.read(userProvider.notifier).deleteUser(user.id);
                        }
                      }),
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
