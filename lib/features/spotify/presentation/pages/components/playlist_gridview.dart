import 'dart:async';

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
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  int pageNumber = 1;

  // Created a custom stream that adds data to the list everytime we scoll to the bottom
  // FutureBuilder was my first option but everytime setState would run GridView would scroll back to the top. I had to use streams to avoid the rebuild on data updates
  StreamController<List<Items>> listStream =
      StreamController<List<Items>>.broadcast();

  // This returns a future that has the actual data
  Future<List<Items>> getCategories(offset) {
    var result = Provider.of<SpotifyProvider>(context, listen: false)
        .getCategoryPlaylist("afro", offset);

    return result;
  }

  // Returns a stream that we are listening to. Everytime we scoll to the bottom this method is called and it will get data from the API as a Future and then push it to our stream
  Stream<List<Items>> loadItems() {
    getCategories(pageNumber).then((value) {
      listStream.sink.add(value);
    });
    return listStream.stream;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Runs a listener that checks our scroll position
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // If we reach the bottom of the screen we want to update page number
        pageNumber++;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // Reset page number
    pageNumber = 1;
    // Dispose scroll data
    _scrollController.dispose();
    // Close our stream to avoid any memory leaks
    listStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: StreamBuilder<List<Items>>(
          initialData: [],
          stream: loadItems(),
          builder: ((context, snapshot) {
            List<Items> playlists = snapshot.data as List<Items>;

            return GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: playlists.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 1 / 1.19),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          AppRoutes.spotifyCategoryPlaylist,
                          arguments: playlists[index].id);
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              playlists[index].images![0].url ?? "",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              playlists[index].name!.length > 20
                                  ? "${playlists[index].name!.substring(0, 17)}..."
                                  : "${playlists[index].name}",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          })),
    );
  }
}
