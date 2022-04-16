import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/pages/components/artists_horizontal_listview.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/presentation/pages/components/tracks_listview.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/providers/spotify_provider.dart';
import 'package:provider/provider.dart';

//TODO: complete this page - you may choose to change it to a stateful widget if necessary
class SpotifyPlaylist extends StatefulWidget {
  const SpotifyPlaylist({Key? key, required this.playlistId}) : super(key: key);

  final String playlistId;

  @override
  State<SpotifyPlaylist> createState() => _SpotifyPlaylistState();
}

class _SpotifyPlaylistState extends State<SpotifyPlaylist> {
  final TextEditingController _searchController = TextEditingController();

  // Variable we are using to keep track of the search input
  String searchTerm = "";

  Future<Playlist> getPlaylist(BuildContext context) async {
    Playlist playlist =
        await Provider.of<SpotifyProvider>(context, listen: false)
            .getPlaylist(widget.playlistId);
    return playlist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          child: Container(
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    // Assignment of updated value on every change of the input field. The data is then updated on typing in the search field. This can be improved by only updating the Tracks widget only upon every search
                    searchTerm = val.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                    hintText: "Search By Track Name",
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.grey[500],
                    )),
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15)),
          preferredSize: const Size.fromHeight(60),
        ),
      ),
      body: FutureBuilder(
          future: getPlaylist(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              Playlist playlist = snapshot.data as Playlist;

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildPlaylistImage(playlist),
                    _buildPlaylistDescription(playlist),
                    _buildLikes(playlist),
                    _buildPlaylistTracks(playlist),
                    _buildArtistsView(playlist)
                  ],
                ),
              );
            }
            return Container(
              child: const Center(child: CircularProgressIndicator()),
            );
          }),
    );
  }

  Widget _buildPlaylistImage(Playlist playlist) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Image.network(playlist.images![0].url ?? ""),
    );
  }

  Widget _buildPlaylistDescription(Playlist playlist) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      width: double.infinity,
      child: Text(playlist.description ?? ""),
    );
  }

  Widget _buildLikes(Playlist playlist) {
    return Container(
        padding: const EdgeInsets.only(left: 25, top: 10),
        width: double.infinity,
        child: Row(
          children: [
            Text("${playlist.followers!.total!.toString()} likes"),
          ],
        ));
  }

  Widget _buildPlaylistTracks(Playlist playlist) {
    return TracklistListView(
      searchTerm: searchTerm,
    );
  }

  Widget _buildArtistsView(playlist) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Artists in this playlist",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          ArtistsView(
            playlist: playlist,
          ),
        ],
      ),
    );
  }
}
