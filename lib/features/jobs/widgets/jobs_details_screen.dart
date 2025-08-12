import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/jobs_model/jobs_model.dart';
import '../../../providers/jobs_provider.dart';
import 'edit_jobs_screen.dart';
import 'package:intl/intl.dart';

class JobDetailScreen extends ConsumerStatefulWidget {
  final JobModel job;
  const JobDetailScreen({super.key, required this.job});

  @override
  ConsumerState<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends ConsumerState<JobDetailScreen> {
  late JobModel _job;
  final NumberFormat formatter = NumberFormat.decimalPattern('en_IN');

  @override
  void initState() {
    super.initState();
    _job = widget.job;
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _infoRow(
      {required IconData icon, required String label, String? value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.blueAccent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(value?.isNotEmpty == true ? value! : '—',
                    style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: _job.image != null && _job.image!.isNotEmpty
          ? Image.network(
              _job.image!,
              width: double.infinity,
              fit: BoxFit.contain,
            )
          : Container(
              height: 220,
              color: Colors.grey.shade300,
              child: const Center(child: Text("No Image Available")),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Job Details",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 6, 37, 64),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            const SizedBox(height: 20),

            // Title and Company
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Position: ',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: _job.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            if (_job.company != null)
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Company: ',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: _job.company!,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 8),

            // Basic Info
            _buildSection(
              title: "Job Info",
              child: Column(
                children: [
                  _infoRow(
                      icon: Icons.location_on,
                      label: "Location",
                      value: _job.location),
                  _infoRow(
                      icon: Icons.business_center,
                      label: "Employment Type",
                      value: _job.employmentType),
                  _infoRow(
                    icon: Icons.monetization_on,
                    label: "Salary Range",
                    value: _job.salaryMin != null && _job.salaryMax != null
                        ? "${_job.currency ?? '₹'} ${formatter.format(_job.salaryMin)} - ${formatter.format(_job.salaryMax)}"
                        : 'Not Specified',
                  ),
                  _infoRow(
                      icon: Icons.public,
                      label: "Remote",
                      value: _job.isRemote ? 'Yes' : 'No'),
                  _infoRow(
                      icon: Icons.date_range,
                      label: "Posted On",
                      value:
                          _job.createdAt.toLocal().toString().split(' ').first),
                ],
              ),
            ),

            // Description
            if (_job.description != null && _job.description!.isNotEmpty)
              _buildSection(
                title: "Description",
                child: Text(_job.description!,
                    style: const TextStyle(fontSize: 15)),
              ),

            // Responsibilities
            if (_job.responsibilities != null &&
                _job.responsibilities!.isNotEmpty)
              _buildSection(
                title: "Responsibilities",
                child: Text(_job.responsibilities!,
                    style: const TextStyle(fontSize: 15)),
              ),

            // Requirements
            if (_job.requirements != null && _job.requirements!.isNotEmpty)
              _buildSection(
                title: "Requirements",
                child: Text(_job.requirements!,
                    style: const TextStyle(fontSize: 15)),
              ),

            // Qualifications
            if (_job.qualifications != null && _job.qualifications!.isNotEmpty)
              _buildSection(
                title: "Qualifications",
                child: Text(_job.qualifications!,
                    style: const TextStyle(fontSize: 15)),
              ),

            // Tags
            if (_job.tags != null && _job.tags!.isNotEmpty)
              _buildSection(
                title: "Skills & Tags",
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _job.tags!
                      .map((tag) => Chip(
                            label: Text(tag),
                            backgroundColor: Colors.blue.shade50,
                            labelStyle:
                                const TextStyle(color: Colors.blueAccent),
                          ))
                      .toList(),
                ),
              ),

            // Apply URL
            if (_job.applicationUrl != null && _job.applicationUrl!.isNotEmpty)
              _buildSection(
                title: "Apply Now",
                child: GestureDetector(
                  onTap: () {
                    // Optionally use url_launcher to open link
                  },
                  child: Text(
                    _job.applicationUrl!,
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final updated = await Navigator.push<JobModel>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditJobScreen(job: _job),
                      ),
                    );
                    if (updated != null) {
                      setState(() {
                        _job = updated;
                      });
                      ref.refresh(jobListProvider);
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Edit",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete Job'),
                        content: const Text(
                            'Are you sure you want to delete this job?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      await ref.read(jobRepositoryProvider).deleteJob(_job.id);
                      ref.refresh(jobListProvider);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Job deleted successfully'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  label: const Text("Delete",
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
