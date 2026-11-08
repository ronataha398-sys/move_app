import 'package:movie_app/data/models/movie_model.dart';

class MovieSuggestions {
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MovieSuggestions({this.status, this.statusMessage, this.data, this.meta});

  MovieSuggestions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? new Meta.fromJson(json['@meta']) : null;
  }
}

class Data {
  int? movieCount;
  List<Movies>? movies;

  Data({this.movieCount, this.movies});

  Data.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];

    if (json['movies'] != null) {
      movies = <Movies>[];

      json['movies'].forEach((v) {
        movies!.add(Movies.fromJson(v));
      });
    }
  }
}

class Torrents {
  String? url;
  String? hash;
  String? quality;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Torrents(
      {this.url,
      this.hash,
      this.quality,
      this.isRepack,
      this.videoCodec,
      this.bitDepth,
      this.audioChannels,
      this.seeds,
      this.peers,
      this.size,
      this.sizeBytes,
      this.dateUploaded,
      this.dateUploadedUnix});

  Torrents.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    isRepack = json['is_repack'];
    videoCodec = json['video_codec'];
    bitDepth = json['bit_depth'];
    audioChannels = json['audio_channels'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }
}

class Meta {
  Migration? migration;
  int? apiVersion;
  String? executionTime;

  Meta({this.migration, this.apiVersion, this.executionTime});

  Meta.fromJson(Map<String, dynamic> json) {
    migration = json['migration'] != null
        ? new Migration.fromJson(json['migration'])
        : null;
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
}

class Migration {
  String? message;
  String? oldBase;
  String? newBase;
  String? sunset;

  Migration({this.message, this.oldBase, this.newBase, this.sunset});

  Migration.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    oldBase = json['old_base'];
    newBase = json['new_base'];
    sunset = json['sunset'];
  }
}
