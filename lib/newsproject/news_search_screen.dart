import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import 'add_like_screen.dart';
import 'news_detail_screen.dart';
import 'news_service.dart';

class NewsSearchView extends StatefulWidget {
  const NewsSearchView({super.key});

  @override
  State<NewsSearchView> createState() => _NewsSearchViewState();
}

class _NewsSearchViewState extends State<NewsSearchView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'business';
  final List<String> _categories = [
    'business', 'entertainment', 'general', 'health', 'science', 'sports', 'technology'
  ];

  @override
  void initState() {
    super.initState();
    // Schedule the fetchNews method to be called after the first frame
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fetchNews(_selectedCategory);
    });
  }

  Future<void> _fetchNews(String category, [String? query]) async {
    await Provider.of<NewsProvider>(context, listen: false).fetchNews(category, query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff71a08b4534),
        centerTitle: true,
        elevation: 50,
        title: const Text("News", style: TextStyle(color: Colors.white)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(75),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: _searchController,
              onSubmitted: (value) {
                _fetchNews(_selectedCategory, value);
              },
              decoration: InputDecoration(
                hintText: 'Search news...',
                hintStyle: const TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search, color: Color(0xff71a08b)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavouriteScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<NewsProvider>(builder: (context, value, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category, style: const TextStyle(color: Colors.black)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                    _fetchNews(_selectedCategory, _searchController.text);
                  });
                },
                decoration: InputDecoration(
                  fillColor: const Color(0xff71a08b453),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: value.loading
                  ? const Center(child: CircularProgressIndicator())
                  : value.newsSearchModel?.articles?.isEmpty ?? true
                  ? const Center(child: Text('No articles found'))
                  : ListView.builder(
                itemCount: value.newsSearchModel?.articles?.length ?? 0,
                itemBuilder: (_, index) {
                  var article = value.newsSearchModel!.articles![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailsScreen(article: article),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          article.urlToImage == null
                              ? const Padding(
                            padding: EdgeInsets.only(top: 30),
                            child: Center(child: Text("there is no image",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff71a08b)))),
                          )
                              : Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage(article.urlToImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.author ?? 'No author',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  article.title ?? 'No title',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                Text(article.description ?? 'No description'),
                                const SizedBox(height: 10),
                                Text(
                                  'Source: ${article.source?.name ?? 'Unknown'}',
                                  style: const TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'Published at: ${article.publishedAt != null ? DateFormat('yyyy-MM-dd – kk:mm').format(article.publishedAt!) : 'Unknown date'}',
                                  style: const TextStyle(fontStyle: FontStyle.italic, color: Color(0xff71a08b)),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:
                                LikeButton(
                                  size: 30,
                                  isLiked: value.favourites.any((fav) => fav['name'] == article.title),
                                  onTap: (isLiked) async {
                                    if (!isLiked) {
                                      // Add to favorites
                                      await value.addFavourite(
                                        article.title,
                                        article.description ?? "",
                                        article.urlToImage ?? "",
                                      );
                                    } else {
                                      // Remove from favorites
                                      final index = value.favourites.indexWhere((fav) => fav['name'] == article.title);
                                      if (index != -1) {
                                        await value.deleteData(index);
                                      }
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
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
