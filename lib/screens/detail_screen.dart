
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class DetailScreen extends StatefulWidget {
  final Post post;

  const DetailScreen({
    super.key,
    required this.post,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static const Color pink = Color(0xFFFF4F9A);

  final PostService _postService = PostService();
  late Future<List<dynamic>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = _postService.getComments(widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Scaffold(
      backgroundColor: const Color(0xFF101018),
      appBar: AppBar(
        backgroundColor: const Color(0xFF101018),
        foregroundColor: Colors.white,
        title: const Text(
          'Detail Pengumuman',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C27),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PENGUMUMAN #${post.id}',
                  style: const TextStyle(
                    color: pink,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  post.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  post.body,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'User ID: ${post.userId}',
                  style: const TextStyle(color: pink),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Komentar',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          FutureBuilder<List<dynamic>>(
            future: _commentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(color: pink),
                  ),
                );
              }

              if (snapshot.hasError) {
                return const Text(
                  'Gagal mengambil komentar. Periksa koneksi internet.',
                  style: TextStyle(color: pink),
                );
              }

              final comments = snapshot.data ?? [];

              return Column(
                children: comments.map((comment) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1C27),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment['name'] ?? 'Tanpa nama',
                          style: const TextStyle(
                            color: pink,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          comment['email'] ?? '',
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          comment['body'] ?? '',
                          style: const TextStyle(
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
