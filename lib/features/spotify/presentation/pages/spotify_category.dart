import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/category.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/pages/components/playlist_gridview.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/providers/spotify_provider.dart';
import 'package:provider/provider.dart';

// TODO: fetch and populate playlist info and allow for click-through to detail
// Feel free to change this to a stateful widget if necessary
class SpotifyCategory extends StatelessWidget {
  final String categoryId;

  const SpotifyCategory({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  Future<Category> getCategoryDetails(context) async {
    var result = await Provider.of<SpotifyProvider>(context, listen: false)
        .getSingleCategory(categoryId);
    return result;
  }

  Widget _buildCategoryPageBody(BuildContext context, Category category) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            category.name ?? "",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(height: 40),
          Image.network(category.icons![0].url ?? ""),
        ],
      ),
    );
  }

  Widget _buildCategoryInformation(context) {
    return FutureBuilder(
      future: getCategoryDetails(context),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Category category = snapshot.data as Category;
          return _buildCategoryPageBody(context, category);
        }

        return const Text('No Category Loaded');
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 50),
              _buildCategoryInformation(context),
              const SizedBox(height: 30),
              const Expanded(child: PlaylistGridView()),
            ],
          )),
    );
  }
}
