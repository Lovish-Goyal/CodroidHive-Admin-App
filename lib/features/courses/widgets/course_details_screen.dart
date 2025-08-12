import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/course_model/course_model.dart';
import '../../../providers/courses_provider.dart';
import 'edit_course_details.dart';

class CourseDetailScreen extends ConsumerStatefulWidget {
  final CourseModel course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  ConsumerState<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends ConsumerState<CourseDetailScreen> {
  late CourseModel _course;

  @override
  void initState() {
    super.initState();
    _course = widget.course;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Image
                ClipRRect(
                  // borderRadius: const BorderRadius.only(
                  //   bottomLeft: Radius.circular(30),
                  //   bottomRight: Radius.circular(30),
                  // ),
                  child: Stack(
                    children: [
                      Image.network(
                        _course.image ?? 'https://via.placeholder.com/400x300',
                        height: 280,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      // Container(
                      //   height: 280,
                      //   width: double.infinity,
                      //   color: Colors.black.withOpacity(0.3),
                      // ),
                      Positioned(
                        top: 20,
                        left: 16,
                        child: CircleAvatar(
                          backgroundColor: Colors.black.withOpacity(0.6),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Course Details
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _course.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_course.subtitle != null &&
                          _course.subtitle!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _course.subtitle!,
                            style: TextStyle(
                                fontSize: 16, color: Colors.grey[700]),
                          ),
                        ),
                      const SizedBox(height: 20),
                      _buildDetail("Instructor", _course.instructor),
                      _buildDetail("Language", _course.language),
                      _buildDetail("Level", _course.level),
                      _buildDetail(
                          "Duration (hrs)", _course.durationHours?.toString()),
                      _buildDetail("Modules", _course.totalModules?.toString()),
                      _buildDetail(
                          "Price",
                          _course.isFree
                              ? "Free"
                              : '${_course.currency ?? ''} ${_course.price?.toStringAsFixed(2) ?? ''}'),
                      const SizedBox(height: 20),
                      if (_course.tags != null && _course.tags!.isNotEmpty) ...[
                        const Text("What You’ll Learn",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _course.tags!
                              .map((tag) => Chip(
                                    backgroundColor: const Color.fromARGB(
                                        221, 102, 102, 102),
                                    label: Text(
                                      tag,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                      if (_course.description != null &&
                          _course.description!.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text("Course Description",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(
                          _course.description!,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Bottom Buttons
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final updated = await Navigator.push<CourseModel>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditCourseScreen(course: _course),
                          ),
                        );
                        if (updated != null) {
                          setState(() => _course = updated);
                          ref.refresh(courseListProvider);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Course'),
                            content: const Text(
                                'Are you sure you want to delete this course?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await ref
                              .read(courseRepositoryProvider)
                              .deleteCourse(_course.id);
                          ref.refresh(courseListProvider);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Course deleted successfully')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetail(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}
