class Playlist {
  String? id;
  bool? collaborative;
  String? description;
  ExternalUrls? externalUrls;
  Followers? followers;
  String? href;
  List<Images>? images;
  String? name;
  Owner? owner;
  String? primaryColor;
  bool? public;
  String? snapshotId;
  Tracks? tracks;
  String? type;
  String? uri;

  Playlist(
      {this.id,
      this.collaborative,
      this.description,
      this.externalUrls,
      this.followers,
      this.href,
      this.images,
      this.name,
      this.owner,
      this.primaryColor,
      this.public,
      this.snapshotId,
      this.tracks,
      this.type,
      this.uri});

  Playlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collaborative = json['collaborative'];
    description = json['description'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    followers = json['followers'] != null
        ? new Followers.fromJson(json['followers'])
        : null;
    href = json['href'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    name = json['name'];
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
    primaryColor = json['primary_color'];
    public = json['public'];
    snapshotId = json['snapshot_id'];
    tracks =
        json['tracks'] != null ? new Tracks.fromJson(json['tracks']) : null;
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['collaborative'] = this.collaborative;
    data['description'] = this.description;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.toJson();
    }
    data['href'] = this.href;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    if (this.owner != null) {
      data['owner'] = this.owner!.toJson();
    }
    data['primary_color'] = this.primaryColor;
    data['public'] = this.public;
    data['snapshot_id'] = this.snapshotId;
    if (this.tracks != null) {
      data['tracks'] = this.tracks!.toJson();
    }
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({this.spotify});

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotify'] = this.spotify;
    return data;
  }
}

class Followers {
  Null? href;
  int? total;

  Followers({this.href, this.total});

  Followers.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['total'] = this.total;
    return data;
  }
}

class Images {
  Null? height;
  String? url;
  Null? width;

  Images({this.height, this.url, this.width});

  Images.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}

class Owner {
  String? displayName;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? type;
  String? uri;

  Owner(
      {this.displayName,
      this.externalUrls,
      this.href,
      this.id,
      this.type,
      this.uri});

  Owner.fromJson(Map<String, dynamic> json) {
    displayName = json['display_name'];
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['display_name'] = this.displayName;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class Tracks {
  String? href;
  List<PlaylistItems>? items;
  int? limit;
  Null? next;
  int? offset;
  Null? previous;
  int? total;

  Tracks(
      {this.href,
      this.items,
      this.limit,
      this.next,
      this.offset,
      this.previous,
      this.total});

  Tracks.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    if (json['items'] != null) {
      items = <PlaylistItems>[];
      json['items'].forEach((v) {
        items!.add(new PlaylistItems.fromJson(v));
      });
    }
    limit = json['limit'];
    next = json['next'];
    offset = json['offset'];
    previous = json['previous'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['limit'] = this.limit;
    data['next'] = this.next;
    data['offset'] = this.offset;
    data['previous'] = this.previous;
    data['total'] = this.total;
    return data;
  }
}

class PlaylistItems {
  String? addedAt;
  AddedBy? addedBy;
  bool? isLocal;
  Null? primaryColor;
  Track? track;
  VideoThumbnail? videoThumbnail;

  PlaylistItems(
      {this.addedAt,
      this.addedBy,
      this.isLocal,
      this.primaryColor,
      this.track,
      this.videoThumbnail});

  PlaylistItems.fromJson(Map<String, dynamic> json) {
    addedAt = json['added_at'];
    addedBy = json['added_by'] != null
        ? new AddedBy.fromJson(json['added_by'])
        : null;
    isLocal = json['is_local'];
    primaryColor = json['primary_color'];
    track = json['track'] != null ? new Track.fromJson(json['track']) : null;
    videoThumbnail = json['video_thumbnail'] != null
        ? new VideoThumbnail.fromJson(json['video_thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['added_at'] = this.addedAt;
    if (this.addedBy != null) {
      data['added_by'] = this.addedBy!.toJson();
    }
    data['is_local'] = this.isLocal;
    data['primary_color'] = this.primaryColor;
    if (this.track != null) {
      data['track'] = this.track!.toJson();
    }
    if (this.videoThumbnail != null) {
      data['video_thumbnail'] = this.videoThumbnail!.toJson();
    }
    return data;
  }
}

class AddedBy {
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? type;
  String? uri;

  AddedBy({this.externalUrls, this.href, this.id, this.type, this.uri});

  AddedBy.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class Track {
  Album? album;
  List<Artists>? artists;
  List<String>? availableMarkets;
  int? discNumber;
  int? durationMs;
  bool? episode;
  bool? explicit;
  ExternalIds? externalIds;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  bool? isLocal;
  String? name;
  int? popularity;
  String? previewUrl;
  bool? track;
  int? trackNumber;
  String? type;
  String? uri;

  Track(
      {this.album,
      this.artists,
      this.availableMarkets,
      this.discNumber,
      this.durationMs,
      this.episode,
      this.explicit,
      this.externalIds,
      this.externalUrls,
      this.href,
      this.id,
      this.isLocal,
      this.name,
      this.popularity,
      this.previewUrl,
      this.track,
      this.trackNumber,
      this.type,
      this.uri});

  Track.fromJson(Map<String, dynamic> json) {
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
      });
    }
    availableMarkets = json['available_markets'].cast<String>();
    discNumber = json['disc_number'];
    durationMs = json['duration_ms'];
    episode = json['episode'];
    explicit = json['explicit'];
    externalIds = json['external_ids'] != null
        ? new ExternalIds.fromJson(json['external_ids'])
        : null;
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    isLocal = json['is_local'];
    name = json['name'];
    popularity = json['popularity'];
    previewUrl = json['preview_url'];
    track = json['track'];
    trackNumber = json['track_number'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.album != null) {
      data['album'] = this.album!.toJson();
    }
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    data['available_markets'] = this.availableMarkets;
    data['disc_number'] = this.discNumber;
    data['duration_ms'] = this.durationMs;
    data['episode'] = this.episode;
    data['explicit'] = this.explicit;
    if (this.externalIds != null) {
      data['external_ids'] = this.externalIds!.toJson();
    }
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['is_local'] = this.isLocal;
    data['name'] = this.name;
    data['popularity'] = this.popularity;
    data['preview_url'] = this.previewUrl;
    data['track'] = this.track;
    data['track_number'] = this.trackNumber;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class Album {
  String? albumType;
  List<Artists>? artists;
  List<String>? availableMarkets;
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  List<AlbumImages>? images;
  String? name;
  String? releaseDate;
  String? releaseDatePrecision;
  int? totalTracks;
  String? type;
  String? uri;

  Album(
      {this.albumType,
      this.artists,
      this.availableMarkets,
      this.externalUrls,
      this.href,
      this.id,
      this.images,
      this.name,
      this.releaseDate,
      this.releaseDatePrecision,
      this.totalTracks,
      this.type,
      this.uri});

  Album.fromJson(Map<String, dynamic> json) {
    albumType = json['album_type'];
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists!.add(new Artists.fromJson(v));
      });
    }
    availableMarkets = json['available_markets'].cast<String>();
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    if (json['images'] != null) {
      images = <AlbumImages>[];
      json['images'].forEach((v) {
        images!.add(new AlbumImages.fromJson(v));
      });
    }
    name = json['name'];
    releaseDate = json['release_date'];
    releaseDatePrecision = json['release_date_precision'];
    totalTracks = json['total_tracks'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['album_type'] = this.albumType;
    if (this.artists != null) {
      data['artists'] = this.artists!.map((v) => v.toJson()).toList();
    }
    data['available_markets'] = this.availableMarkets;
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['release_date'] = this.releaseDate;
    data['release_date_precision'] = this.releaseDatePrecision;
    data['total_tracks'] = this.totalTracks;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class Artists {
  ExternalUrls? externalUrls;
  String? href;
  String? id;
  String? name;
  String? type;
  String? uri;

  Artists(
      {this.externalUrls, this.href, this.id, this.name, this.type, this.uri});

  Artists.fromJson(Map<String, dynamic> json) {
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    href = json['href'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class AlbumImages {
  int? height;
  String? url;
  int? width;

  AlbumImages({this.height, this.url, this.width});

  AlbumImages.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['url'] = this.url;
    data['width'] = this.width;
    return data;
  }
}

class ExternalIds {
  String? isrc;

  ExternalIds({this.isrc});

  ExternalIds.fromJson(Map<String, dynamic> json) {
    isrc = json['isrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isrc'] = this.isrc;
    return data;
  }
}

class VideoThumbnail {
  Null? url;

  VideoThumbnail({this.url});

  VideoThumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
