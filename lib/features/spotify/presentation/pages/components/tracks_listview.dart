import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/providers/spotify_provider.dart';
import 'package:provider/provider.dart';

class TracklistListView extends StatelessWidget {
  TracklistListView({Key? key, this.searchTerm}) : super(key: key);

  String? searchTerm;

  List<PlaylistItems> tracks = [];

  @override
  Widget build(BuildContext context) {
    List<PlaylistItems> tracks =
        Provider.of<SpotifyProvider>(context, listen: false)
            .tracks
            .where((track) =>
                track.track!.name!.toLowerCase().startsWith(searchTerm ?? ""))
            .toList();

    return Container(
      height: 210,
      child: tracks.isNotEmpty
          ? ListView.builder(
              itemCount: tracks.length,
              itemBuilder: ((context, index) {
                return _buildTrackItem(context, tracks[index]);
              }))
          : const Center(
              child: Text("No reslts for search term"),
            ),
    );
  }

  // Build ListTile widget that will show the list of tracks
  Widget _buildTrackItem(context, track) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Image.network(
          track.track!.album!.images![0].url ?? "",
          width: 70,
          height: 70,
        ),
        title: Text(
          track.track!.name ?? "N/A",
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTrackArtistsString(context, track),
            Text(
              Duration(milliseconds: track.track!.durationMs)
                  .toString()
                  .substring(3, 7),
              style: const TextStyle(fontSize: 14, color: Colors.green),
            )
          ],
        ),
      ),
    );
  }

  // Loop through the array of Artists, get their names and join them into a comma separated string
  Widget _buildTrackArtistsString(context, track) {
    var artistsArr = track.track!.artists;
    List<String> artistNamesList = [];
    for (int i = 0; i < artistsArr!.length; i++) {
      Provider.of<SpotifyProvider>(context, listen: true)
          .addArtistsToArray(artistsArr[i].id);
      artistNamesList.add(artistsArr[i].name ?? "");
    }
    return Text(artistNamesList.join(', '));
  }
}
