import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/category_playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/providers/spotify_provider.dart';
import 'package:flutter_spotify_africa_assessment/routes.dart';
import 'package:provider/provider.dart';

class PlaylistGridView extends StatefulWidget {
  const PlaylistGridView({Key? key}) : super(key: key);

  @override
  State<PlaylistGridView> createState() => _PlaylistGridViewState();
}

class _PlaylistGridViewState extends State<PlaylistGridView> {
  final ScrollController _scrollController = ScrollController();
  int pageNumber = 1;

  Future<List<Items>> getCategories(offset) {
    var result = Provider.of<SpotifyProvider>(context, listen: false)
        .getCategoryPlaylist("afro", offset);
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reload your futurebuilder and load more data
        pageNumber++;
        setState(() {});
        // getCategories(pageNumber);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageNumber = 1;
    // _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: FutureBuilder(
          initialData: [],
          future: getCategories(pageNumber),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Items> playlists = snapshot.data as List<Items>;
                return GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    itemCount: playlists.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              AppRoutes.spotifyCategoryPlaylist,
                              arguments: playlists[index].id);
                        },
                        child: Container(
                          child: Image.network(
                            playlists[index].images![0].url ?? "",
                          ),
                        ),
                      );
                    });
              }
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          })),
    );
  }
}
