class MovieDetailsModel {
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MovieDetailsModel({this.status, this.statusMessage, this.data, this.meta});

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    meta = json['@meta'] != null ? new Meta.fromJson(json['@meta']) : null;
  }
}

class Data {
  Movie? movie;

  Data({this.movie});

  Data.fromJson(Map<String, dynamic> json) {
    movie = json['movie'] != null ? new Movie.fromJson(json['movie']) : null;
  }
}

class Movie {
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  int? likeCount;
  String? descriptionIntro;
  String? descriptionFull;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;
  List<Cast>? cast;

  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.likeCount,
    this.descriptionIntro,
    this.descriptionFull,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
    this.cast,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = (json['rating'] as num?)?.toDouble();
    runtime = json['runtime'];
    genres = json['genres'] != null ? List<String>.from(json['genres']) : [];
    likeCount = json['like_count'];
    descriptionIntro = json['description_intro'];
    descriptionFull = json['description_full'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    if (json['torrents'] != null) {
      torrents = <Torrents>[];
      json['torrents'].forEach((v) {
        torrents!.add(new Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
    if (json['cast'] != null) {
      cast = <Cast>[];

      json['cast'].forEach((v) {
        cast!.add(Cast.fromJson(v));
      });
    }
  }
}

class Torrents {
  String? url;
  String? hash;
  String? quality;
  String? type;
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
      this.type,
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
    type = json['type'];
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

class Cast {
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Cast({
    this.name,
    this.characterName,
    this.urlSmallImage,
    this.imdbCode,
  });

  Cast.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }
}

class Meta {
  int? apiVersion;
  String? executionTime;

  Meta({this.apiVersion, this.executionTime});

  Meta.fromJson(Map<String, dynamic> json) {
    apiVersion = json['api_version'];
    executionTime = json['execution_time'];
  }
}
