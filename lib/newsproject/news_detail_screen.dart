import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'news_model_screen.dart';
import 'news_service.dart';

class NewsDetailsScreen extends StatefulWidget {
  final Article article;

  const NewsDetailsScreen({super.key, required this.article});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff71a08b),
        title: const Text(
          'News Details',
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, value, child) {
          final isLiked = value.favourites.any((fav) => fav['name'] == widget.article.title);

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.article.urlToImage == null
                      ? const Center(child: CircularProgressIndicator(color: Color(0xff71a08b)))
                      : Image.network(widget.article.urlToImage!),
                  const SizedBox(height: 16),
                  Text(
                    widget.article.title ?? 'No title',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.article.author ?? 'No author',
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.article.description ?? 'No description',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.article.content ?? 'No content',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  LikeButton(
                    size: 30,
                    isLiked: isLiked,
                    onTap: (isLiked) async {
                      if (isLiked) {
                        final index = value.favourites.indexWhere((fav) => fav['name'] == widget.article.title);
                        if (index != -1) {
                          await value.deleteData(index);
                        }
                      } else {
                        await value.addFavourite(
                          widget.article.title ?? '',
                          widget.article.description ?? '',
                          widget.article.urlToImage ?? '',
                        );
                      }
                      // Return the updated state
                      return !isLiked;
                    },
                    circleColor: const CircleColor(start: Colors.lightGreen, end: Colors.green),
                    likeBuilder: (isLiked) {
                      return Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.pinkAccent : Colors.grey,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: MaterialButton(
                      color: const Color(0xff71a08b),
                      onPressed: _launchUrl,
                      child: const Text(
                        "Open link",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(widget.article.url ?? '');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
