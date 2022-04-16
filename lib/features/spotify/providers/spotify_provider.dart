import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/artist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/category.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/category_playlist.dart';
import 'package:flutter_spotify_africa_assessment/features/spotify/models/playlist.dart';
import 'package:flutter_spotify_africa_assessment/utils/api.dart';
import 'package:flutter_spotify_africa_assessment/utils/http_client.dart';

class SpotifyProvider with ChangeNotifier {
  List<Items> _categoryPlaylist = [];
  String _categoryTitle = "";
  List<String> _allArtistIDsInPlaylist = [];
  List<SpotifyArtist> _artistsListFromAPI = [];
  List<PlaylistItems> _tracks = [];

  void addArtistsToArray(String artistId) async {
    _allArtistIDsInPlaylist.add(artistId);
  }

  void removeArtistsFromArray() {
    _allArtistIDsInPlaylist = [];
  }

  // Get all IDs of artist in a playlist. This returns an array of string IDS
  List<String> get allArtistIDsInPlaylist => _allArtistIDsInPlaylist;

  // After getting the IDs array we pass it to the API. The provided API does not allows us to send all the IDs in one request. This affects performance because we are forced to loop through all IDs hence making multiple requests. I have limited the number of requests that we are making
  List<SpotifyArtist> get artistsListFromAPI => [..._artistsListFromAPI];

  // Returns a list of all the tracks in the selected playlist
  List<PlaylistItems> get tracks => [..._tracks];

  // Returns the category title. I wanted to keep the AppBar outside the FutureBuilder in the spotify_category.dart hence I created a getter for the title
  String get categoryTitle => _categoryTitle;

  // Returns a list of the playlist in a category
  List<Items> get categoryPlaylist => [..._categoryPlaylist];

  // Returns a Single category from the API
  Future<Category> getSingleCategory(String categoryId) async {
    try {
      var url = Uri.parse("${API.baseURL}browse/categories/$categoryId");
      var response = await HTTPService.client.get(url, headers: API.headers);
      final Map<String, dynamic> categoryJSON = json.decode(response.body);
      Category category = Category.fromJson(categoryJSON);
      _categoryTitle = category.name ?? "";
      return category;
    } catch (e) {
      throw e;
    }
  }

  // Returns the Playlist in a selected Category
  Future<List<Items>> getCategoryPlaylist(categoryId, offset) async {
    try {
      var limit = 6;
      var url = Uri.parse(
          "${API.baseURL}browse/categories/$categoryId/playlists?offset=${offset * limit}&limit=$limit");
      var response = await HTTPService.client.get(url, headers: API.headers);

      if (response.statusCode == 200) {
        final Map<String, dynamic> categoryPlaylistJSON =
            json.decode(response.body);
        CategoryPlaylist categoryPlaylist =
            CategoryPlaylist.fromJson(categoryPlaylistJSON);

        var items = categoryPlaylist.playlists!.items!;

        // We are inserting the data at the end of the list every we scroll to the end of the list
        _categoryPlaylist.insertAll(_categoryPlaylist.length, items);

        return _categoryPlaylist;
      } else if (response.statusCode == 401) {
        throw "You are not authorized access this endpoint";
      } else if (response.statusCode == 500) {
        throw "Failed to load data";
      } else if (response.statusCode == 40) {
        throw "Failed to load data";
      }
    } catch (e) {
      rethrow;
    }
    return _categoryPlaylist;
  }

  // Returns a playlist from the API
  Future<Playlist> getPlaylist(String playlistId) async {
    try {
      var url = Uri.parse("${API.baseURL}playlists/$playlistId");
      var response = await HTTPService.client.get(url, headers: API.headers);

      final Map<String, dynamic> playlistJSON = json.decode(response.body);
      Playlist playlist = Playlist.fromJson(playlistJSON);

      _tracks = playlist.tracks!.items!;
      return playlist;
    } catch (e) {
      throw "Failed To Load Playlist";
    }
  }

  // Returns a combined List of Artists from the API. We have limited the artists to 6 for performance reasons as there hundreds of them. In an ideal situation we would pass all IDs at once and get a response. The Spotify API allows that through passing a query param ids but the provided API doesnt allow us.
  Future<List<SpotifyArtist>> combinedListOfArtists(
      List<PlaylistItems> ids) async {
    // Create a variable to that will contain our list of Id strings
    List<String> idsList = [];

    // Loop through all the tracks
    for (int i = 0; i < ids.length; i++) {
      // Assign a variable of type track. Each of these variables contains a List of artists
      Track? selectedtrack = ids[i].track;
      // Loop through each artist in a track
      for (int i = 0; i < selectedtrack!.artists!.length; i++) {
        // Pull out the string IDs and add them to our idsList
        idsList.add(selectedtrack.artists![i].id ?? "");
      }
    }

    // Convert our List to an Iterable. Limited the items to 6 to avoid very long load times
    var formattedIterable = idsList.take(6).map((e) {
      return e;
    });

    // We want to wait until all the network requests complete so we have used Future.wait that will allow us to loop through all our items first before the Future completes
    return Future.wait(formattedIterable.take(6).map((e) {
      // Pass the string ID to get a single artist
      return getSingleArtistInPlaylist(e);
    }));

    // Because the artists list is for bonus points, I didn't continue to sort the list in order of those that appear the most times in a list.
  }

  // Gets an from the API using their ID
  Future<SpotifyArtist> getSingleArtistInPlaylist(String artistId) async {
    try {
      var url = Uri.parse("${API.baseURL}artists/$artistId");
      var response = await HTTPService.client.get(url, headers: API.headers);
      final Map<String, dynamic> artistJSON = json.decode(response.body);
      SpotifyArtist artist = SpotifyArtist.fromJson(artistJSON);
      return artist;
    } catch (e) {
      throw e;
    }
  }
}
