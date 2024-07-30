import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_service.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff71a08b),
        title: const Text('Favourite', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<NewsProvider>(
        builder: (context, value, child) {
          var data = value.favourites;

          if (data.isEmpty) {
            return const Center(child: Text('No favorites found.'));
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var item = data[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    item['image']!.isEmpty
                        ? const Center(child: Text("there is no image",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color(0xff71a08b)),))
                        : Image.network(item['image']!),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        item['name'] ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(item['description'] ?? ""),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          value.deleteData(index);
                        },
                        icon: const Icon(Icons.thumb_down),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
