import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/artist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/providers/spotify_provider.dart';
import 'package:provider/provider.dart';

class ArtistsView extends StatefulWidget {
  ArtistsView({Key? key, required this.playlist}) : super(key: key);

  Playlist playlist;

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  List<SpotifyArtist> result = [];

  Future<List<SpotifyArtist>> getArtistsList(BuildContext context) async {
    result = await Provider.of<SpotifyProvider>(context, listen: false)
        .combinedListOfArtists(widget.playlist.tracks!.items!);

    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    getArtistsList(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getArtistsList(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<SpotifyArtist> artists =
                  snapshot.data as List<SpotifyArtist>;
              int maxIndex = 6;
              if (artists.length < 6) {
                maxIndex = artists.length;
              }
              return Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: maxIndex,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 130,
                      padding:
                          const EdgeInsets.only(left: 0, right: 15, top: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              artists[index].images![0].url ?? "N/A",
                              width: 120,
                              height: 120,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              artists[index].name ?? "N/A",
                              style: const TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          }
          return const Text("No data found");
        },
      ),
    );
  }
}
