// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../providers/news_provider.dart';
// import 'widgets/add_news_screen.dart';
// import 'widgets/news_details_screen.dart';

// class NewsScreen extends ConsumerStatefulWidget {
//   const NewsScreen({super.key});

//   @override
//   ConsumerState<NewsScreen> createState() => _NewsScreenState();
// }

// class _NewsScreenState extends ConsumerState<NewsScreen> {
//   String searchQuery = '';
//   bool sortByLatest = true;

//   @override
//   Widget build(BuildContext context) {
//     final newsListAsync = ref.watch(newsListProvider);

//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Column(
//             children: [
//               // Search bar
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search news...',
//                   prefixIcon: const Icon(Icons.search),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onChanged: (value) {
//                   setState(() {
//                     searchQuery = value.toLowerCase();
//                   });
//                 },
//               ),
//               const SizedBox(height: 10),

//               // Filter buttons
//               Row(
//                 children: [
//                   const Text('Sort by: '),
//                   DropdownButton<bool>(
//                     value: sortByLatest,
//                     items: const [
//                       DropdownMenuItem(
//                         value: true,
//                         child: Text('Latest'),
//                       ),
//                       DropdownMenuItem(
//                         value: false,
//                         child: Text('Oldest'),
//                       ),
//                     ],
//                     onChanged: (value) {
//                       if (value != null) {
//                         setState(() {
//                           sortByLatest = value;
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               // News List
//               Expanded(
//                 child: newsListAsync.when(
//                   loading: () =>
//                       const Center(child: CircularProgressIndicator()),
//                   error: (e, _) => Center(child: Text('Error: $e')),
//                   data: (newsList) {
//                     if (newsList.isEmpty) {
//                       return const Center(child: Text('No news found.'));
//                     }

//                     // Filter and sort news
//                     final filteredNews = newsList
//                         .where((news) =>
//                             news.title.toLowerCase().contains(searchQuery) ||
//                             (news.description?.toLowerCase() ?? '')
//                                 .contains(searchQuery))
//                         .toList();

//                     filteredNews.sort((a, b) => sortByLatest
//                         ? b.createdAt.compareTo(a.createdAt)
//                         : a.createdAt.compareTo(b.createdAt));

//                     if (filteredNews.isEmpty) {
//                       return const Center(child: Text('No results found.'));
//                     }

//                     return ListView.builder(
//                       itemCount: filteredNews.length,
//                       itemBuilder: (context, index) {
//                         final news = filteredNews[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => NewsDetailScreen(news: news),
//                               ),
//                             );
//                           },
//                           child: Card(
//                             elevation: 3,
//                             margin: const EdgeInsets.symmetric(vertical: 8),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // News image - full width landscape
//                                 if (news.image != null &&
//                                     news.image!.trim().isNotEmpty)
//                                   ClipRRect(
//                                     borderRadius: const BorderRadius.vertical(
//                                       top: Radius.circular(12),
//                                     ),
//                                     child: Image.network(
//                                       news.image!,
//                                       height: 180,
//                                       width: double.infinity,
//                                       fit: BoxFit.cover,
//                                       errorBuilder: (_, __, ___) => Container(
//                                         height: 180,
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey.shade300,
//                                           borderRadius:
//                                               const BorderRadius.vertical(
//                                             top: Radius.circular(12),
//                                           ),
//                                         ),
//                                         child: const Icon(Icons.article,
//                                             size: 48, color: Colors.grey),
//                                       ),
//                                     ),
//                                   )
//                                 else
//                                   Container(
//                                     height: 180,
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: const BorderRadius.vertical(
//                                         top: Radius.circular(12),
//                                       ),
//                                     ),
//                                     child: const Icon(Icons.article,
//                                         size: 48, color: Colors.grey),
//                                   ),

//                                 // News details
//                                 Padding(
//                                   padding: const EdgeInsets.all(16),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         news.title,
//                                         style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         news.description ??
//                                             'No description provided.',
//                                         maxLines: 2,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(fontSize: 14),
//                                       ),
//                                       const SizedBox(height: 10),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               const Icon(
//                                                 Icons.newspaper,
//                                                 size: 14,
//                                                 color: Colors.blue,
//                                               ),
//                                               const SizedBox(width: 4),
//                                               Text(
//                                                 'Published on:',
//                                                 style: const TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.grey),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(
//                                             news.createdAt
//                                                 .toLocal()
//                                                 .toIso8601String()
//                                                 .split('T')
//                                                 .first,
//                                             style: const TextStyle(
//                                                 fontSize: 12,
//                                                 color: Colors.grey),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: GestureDetector(
//         onTap: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const AddNewsScreen()),
//           );
//           ref.refresh(newsListProvider); // Refresh after return
//         },
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
//                 'Add News',
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
