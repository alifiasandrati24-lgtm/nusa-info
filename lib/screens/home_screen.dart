
import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';
import 'detail_screen.dart';
import 'add_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const Color pink = Color(0xFFFF4F9A);
  static const Color background = Color(0xFF101018);

  final PostService _postService = PostService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _postService.getPosts();
  }

  void _loadPosts() {
    setState(() {
      _postsFuture = _postService.getPosts();
    });
  }

  Future<void> _openAddPost() async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddPostScreen(),
      ),
    );

    if (!mounted) return;

    if (result == true) {
      _loadPosts();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pengumuman berhasil dibuat!'),
          backgroundColor: pink,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        foregroundColor: Colors.white,
        title: const Text(
          'NusaInfo',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: pink,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _loadPosts,
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat ulang',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddPost,
        backgroundColor: pink,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: pink),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.wifi_off,
                      color: pink,
                      size: 55,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Gagal memuat pengumuman',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Periksa koneksi internet kamu, lalu coba lagi.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: _loadPosts,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pink,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final posts = snapshot.data ?? [];

          return RefreshIndicator(
            color: pink,
            onRefresh: () async {
              _loadPosts();
              await _postsFuture;
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];

                return Card(
                  color: const Color(0xFF1C1C27),
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.white12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: pink.withValues(alpha: 0.15),
                      child: Text(
                        '${post.id}',
                        style: const TextStyle(
                          color: pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      post.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        post.body,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: pink,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(post: post),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
