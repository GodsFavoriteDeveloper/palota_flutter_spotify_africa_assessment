import 'dart:async';
import 'dart:convert';
import 'dart:io';

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
    // print(ids[0].track!.id);
    List<String> idsList = [];

    for (int i = 0; i < ids.length; i++) {
      Track? selectedtrack = ids[i].track;
      for (int i = 0; i < selectedtrack!.artists!.length; i++) {
        idsList.add(selectedtrack.artists![i].id ?? "");
      }
      // if (ids[i].track != null) {
      //   idsList.add(ids[i].track!.artists![0].id ?? "");
      // }
    }

    print(idsList);

    // print(jsonEncode(ids));

    // print(idsList);

    Iterable idss = [
      "4ZTqTkO2kj1doQrbqQ5KEe",
      "0byBbjjMnPnPDMosIzKHO4",
      "6LzSS8yBk2YQpAvQxzOu0M",
      "260q55nLIeMDgpXiUJYTRK"
    ];

    // print(idsList);
    // print(idss);
    var backToJSOn = jsonEncode(ids);

    var tryd = idsList.take(7).map((e) {
      return e;
    });

    // print(tryd);

    Iterable yes = idsList;

    return Future.wait(tryd.take(6).map((e) {
      print(e);
      return getSingleArtistInPlaylist(e);
    }));

    // _allArtistIDsInPlaylist.forEach((element) async {
    //   // print(element);
    //   SpotifyArtist result =
    //       await getSingleArtistInPlaylist(element.toString());
    //   _artistsListFromAPI.add(result);
    // });
    // Future.forEach(_allArtistIDsInPlaylist, (element) async {
    //   print(element);
    //   SpotifyArtist result =
    //       await getSingleArtistInPlaylist(element.toString());
    //   _artistsListFromAPI.add(result);
    // });
    // for (var i = 0; i < 6; i++) {
    //   SpotifyArtist result =
    //       await getSingleArtistInPlaylist(_allArtistIDsInPlaylist[i]);
    //   _artistsListFromAPI.add(result);
    // }
    return _artistsListFromAPI;
  }

  // Gets an from the API using their ID
  Future<SpotifyArtist> getSingleArtistInPlaylist(String artistId) async {
    // print(artistId);
    try {
      var url = Uri.parse("${API.baseURL}artists/${artistId}");
      var response = await HTTPService.client.get(url, headers: API.headers);
      final Map<String, dynamic> artistJSON = json.decode(response.body);
      print(artistJSON);
      SpotifyArtist artist = SpotifyArtist.fromJson(artistJSON);
      return artist;
    } catch (e) {
      throw e;
    }
  }
}
