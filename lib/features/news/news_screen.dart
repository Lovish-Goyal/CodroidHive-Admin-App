import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../constants/colors.dart';
import '../../providers/news_provider.dart';
import 'widgets/add_news.dart';
import 'widgets/news_details_screen.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  String _searchQuery = '';
  bool _sortByLatest = true;

  @override
  Widget build(BuildContext context) {
    final newsListAsync = ref.watch(userNewsListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('News'),
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // Search bar
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search news...',
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
                      DropdownMenuItem(value: true, child: Text('Latest')),
                      DropdownMenuItem(value: false, child: Text('Oldest')),
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

              // News Grid
              Expanded(
                child: newsListAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (newsList) {
                    if (newsList.isEmpty) {
                      return const Center(child: Text('No news found.'));
                    }

                    // Search filter
                    final filteredNews = newsList.where((news) {
                      final titleMatch = news.title!.toLowerCase().contains(
                        _searchQuery,
                      );
                      final descMatch = news.description!
                          .toLowerCase()
                          .contains(_searchQuery);
                      return titleMatch || descMatch;
                    }).toList();

                    // Sort
                    filteredNews.sort(
                      (a, b) => _sortByLatest
                          ? b.createdAt.compareTo(a.createdAt)
                          : a.createdAt.compareTo(b.createdAt),
                    );

                    if (filteredNews.isEmpty) {
                      return const Center(child: Text('No results found.'));
                    }

                    return GridView.builder(
                      itemCount: filteredNews.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 420,
                          ),
                      itemBuilder: (context, index) {
                        final news = filteredNews[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => NewsDetailScreen(news: news),
                              ),
                            );
                          },
                          child: Card(
                            color: AppColors.cardBackground,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (news.image != null &&
                                    news.image!.isNotEmpty)
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      news.image!,
                                      height: 200,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Image.asset(
                                        'assets/images/default_news.jpg',
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
                                          news.title!,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 12),
                                        Text(
                                          news.description!,
                                          textAlign: TextAlign.justify,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                              255,
                                              95,
                                              94,
                                              94,
                                            ),
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
            MaterialPageRoute(builder: (_) => const AddNewsScreen()),
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
                'Add News',
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
