import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app_admin/providers/firestore_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/news_model/news_model.dart';

class NewsRepository {
  final FirebaseFirestore firestore;
  NewsRepository(this.firestore);

  CollectionReference get _collection => firestore.collection('news');

  // Fetch all news
  Future<List<NewsModel>> fetchNews() async {
    final snapshot = await _collection.get();
    return snapshot.docs
        .map((doc) => NewsModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Fetch single news by ID
  Future<NewsModel?> getNewsById(String id) async {
    final doc = await _collection.doc(id).get();
    if (!doc.exists) return null;
    return NewsModel.fromJson(doc.data() as Map<String, dynamic>);
  }

  // Add news
  Future<void> addNews(NewsModel news) async {
    await _collection.doc(news.id).set(news.toMap());
  }

  // Update news
  Future<void> updateNews(NewsModel news) async {
    await _collection.doc(news.id).update(news.toMap());
  }

  // Delete news
  Future<void> deleteNews(String id) async {
    await _collection.doc(id).delete();
  }
}

// NewsRepository provider
final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepository(ref.read(firestoreProvider));
});

// Provider to fetch all news
final userNewsListProvider = FutureProvider<List<NewsModel>>((ref) {
  return ref.watch(newsRepositoryProvider).fetchNews();
});

// Provider to fetch news by ID
final userNewsDetailProvider = FutureProvider.family<NewsModel?, String>((
  ref,
  newsId,
) {
  return ref.watch(newsRepositoryProvider).getNewsById(newsId);
});
