import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../models/course_model/course_model.dart';
import '../../providers/courses_provider.dart';
import 'widgets/add_course.dart';
import 'widgets/course_details_screen.dart';

class CoursesScreen extends ConsumerStatefulWidget {
  const CoursesScreen({super.key});

  @override
  ConsumerState<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends ConsumerState<CoursesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _instructorController = TextEditingController();
  final _instructorImageController = TextEditingController();
  final _currencyController = TextEditingController(text: 'USD');
  final _videoUrlController = TextEditingController();
  final _certificateUrlController = TextEditingController();
  final _tagsController = TextEditingController();
  final _languageController = TextEditingController(text: 'English');
  final _levelController = TextEditingController();

  double? _price;
  int? _durationHours;
  int? _totalModules;
  bool _isFree = false;

  // Search & sorting state
  String _searchQuery = '';
  bool _sortByLatest = true;

  Future<void> _addCourse() async {
    if (_formKey.currentState?.validate() ?? false) {
      final course = CourseModel(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        subtitle: _subtitleController.text.trim(),
        description: _descriptionController.text.trim(),
        image: _imageController.text.trim(),
        instructor: _instructorController.text.trim(),
        instructorImage: _instructorImageController.text.trim(),
        currency: _currencyController.text.trim(),
        price: _price,
        durationHours: _durationHours,
        totalModules: _totalModules,
        tags: _tagsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        language: _languageController.text.trim(),
        level: _levelController.text.trim(),
        videoUrl: _videoUrlController.text.trim(),
        certificateUrl: _certificateUrlController.text.trim(),
        isFree: _isFree,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await ref.read(courseRepositoryProvider).addCourse(course);
      Navigator.pop(context);
      _clearForm();
      ref.refresh(courseListProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Course added successfully')),
      );
    }
  }

  void _clearForm() {
    _titleController.clear();
    _subtitleController.clear();
    _descriptionController.clear();
    _imageController.clear();
    _instructorController.clear();
    _instructorImageController.clear();
    _currencyController.text = 'USD';
    _videoUrlController.clear();
    _certificateUrlController.clear();
    _tagsController.clear();
    _languageController.text = 'English';
    _levelController.clear();
    _price = null;
    _durationHours = null;
    _totalModules = null;
    _isFree = false;
  }

  @override
  Widget build(BuildContext context) {
    final courseListAsync = ref.watch(courseListProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search courses...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
              ),
              const SizedBox(height: 10),

              // Sort dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('Sort by: '),
                  DropdownButton<bool>(
                    value: _sortByLatest,
                    items: const [
                      DropdownMenuItem(
                        value: true,
                        child: Text('Latest'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('Oldest'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _sortByLatest = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Course Grid/List
              Expanded(
                child: courseListAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (courses) {
                    if (courses.isEmpty) {
                      return const Center(child: Text('No courses found.'));
                    }

                    // Filter courses based on search query
                    final filteredCourses = courses.where((course) {
                      final titleMatch =
                          course.title.toLowerCase().contains(_searchQuery);
                      final descriptionMatch = course.description
                          .toLowerCase()
                          .contains(_searchQuery);
                      return titleMatch || descriptionMatch;
                    }).toList();

                    // Sort courses by createdAt
                    filteredCourses.sort((a, b) => _sortByLatest
                        ? b.createdAt.compareTo(a.createdAt)
                        : a.createdAt.compareTo(b.createdAt));

                    if (filteredCourses.isEmpty) {
                      return const Center(child: Text('No results found.'));
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: filteredCourses.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        final course = filteredCourses[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CourseDetailScreen(course: course),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (course.image != null &&
                                    course.image!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12)),
                                    child: Image.network(
                                      course.image!,
                                      height: 200, // Reduced to avoid overflow
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      errorBuilder: (_, __, ___) => Image.asset(
                                        'assets/images/default.jpg',
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          course.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(height: 4),
                                        Expanded(
                                          child: Text(
                                            course.description,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCourseScreen()),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0A1D56), Color(0xFF1976D2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'Add Course',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
