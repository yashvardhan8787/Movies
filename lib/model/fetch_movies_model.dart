/// page : 1
/// results : [{"adult":false,"backdrop_path":"/kwzNUM4yZ26XuNAPSyaWwJeWRP4.jpg","genre_ids":[28,35,14],"id":950526,"original_language":"pt","original_title":"O Mestre da Fumaça","overview":"The journey of Gabriel and Daniel, two brothers cursed by the Chinese mafia...","popularity":883.351,"poster_path":"/mg6YkwftQOJjpT2ygYlCi11LWeC.jpg","release_date":"2023-05-18","title":"The Smoke Master","vote_average":7.667,"vote_count":3},{"adult":false,"backdrop_path":"/aswBReNN2adqTiOBnvh96RCDeJP.jpg","genre_ids":[28,80,18],"id":959092,"original_language":"fr","original_title":"Farang","overview":"Sam is a professional boxer about to get released from prison...","popularity":859.912,"poster_path":"/path-to-image.jpg","release_date":"2023-05-18","title":"Farang","vote_average":7.3,"vote_count":12}]

class FetchMoviesModel {
  FetchMoviesModel({
      num? page, 
      List<Results>? results,}){
    _page = page;
    _results = results;
}

  FetchMoviesModel.fromJson(dynamic json) {
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  num? _page;
  List<Results>? _results;
FetchMoviesModel copyWith({  num? page,
  List<Results>? results,
}) => FetchMoviesModel(  page: page ?? _page,
  results: results ?? _results,
);
  num? get page => _page;
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// adult : false
/// backdrop_path : "/kwzNUM4yZ26XuNAPSyaWwJeWRP4.jpg"
/// genre_ids : [28,35,14]
/// id : 950526
/// original_language : "pt"
/// original_title : "O Mestre da Fumaça"
/// overview : "The journey of Gabriel and Daniel, two brothers cursed by the Chinese mafia..."
/// popularity : 883.351
/// poster_path : "/mg6YkwftQOJjpT2ygYlCi11LWeC.jpg"
/// release_date : "2023-05-18"
/// title : "The Smoke Master"
/// vote_average : 7.667
/// vote_count : 3

class Results {
  Results({
      bool? adult, 
      String? backdropPath, 
      List<num>? genreIds, 
      num? id, 
      String? originalLanguage, 
      String? originalTitle, 
      String? overview, 
      num? popularity, 
      String? posterPath, 
      String? releaseDate, 
      String? title, 
      num? voteAverage, 
      num? voteCount,}){
    _adult = adult;
    _backdropPath = backdropPath;
    _genreIds = genreIds;
    _id = id;
    _originalLanguage = originalLanguage;
    _originalTitle = originalTitle;
    _overview = overview;
    _popularity = popularity;
    _posterPath = posterPath;
    _releaseDate = releaseDate;
    _title = title;
    _voteAverage = voteAverage;
    _voteCount = voteCount;
}

  Results.fromJson(dynamic json) {
    _adult = json['adult'];
    _backdropPath = json['backdrop_path'];
    _genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<num>() : [];
    _id = json['id'];
    _originalLanguage = json['original_language'];
    _originalTitle = json['original_title'];
    _overview = json['overview'];
    _popularity = json['popularity'];
    _posterPath = json['poster_path'];
    _releaseDate = json['release_date'];
    _title = json['title'];
    _voteAverage = json['vote_average'];
    _voteCount = json['vote_count'];
  }
  bool? _adult;
  String? _backdropPath;
  List<num>? _genreIds;
  num? _id;
  String? _originalLanguage;
  String? _originalTitle;
  String? _overview;
  num? _popularity;
  String? _posterPath;
  String? _releaseDate;
  String? _title;
  num? _voteAverage;
  num? _voteCount;
Results copyWith({  bool? adult,
  String? backdropPath,
  List<num>? genreIds,
  num? id,
  String? originalLanguage,
  String? originalTitle,
  String? overview,
  num? popularity,
  String? posterPath,
  String? releaseDate,
  String? title,
  num? voteAverage,
  num? voteCount,
}) => Results(  adult: adult ?? _adult,
  backdropPath: backdropPath ?? _backdropPath,
  genreIds: genreIds ?? _genreIds,
  id: id ?? _id,
  originalLanguage: originalLanguage ?? _originalLanguage,
  originalTitle: originalTitle ?? _originalTitle,
  overview: overview ?? _overview,
  popularity: popularity ?? _popularity,
  posterPath: posterPath ?? _posterPath,
  releaseDate: releaseDate ?? _releaseDate,
  title: title ?? _title,
  voteAverage: voteAverage ?? _voteAverage,
  voteCount: voteCount ?? _voteCount,
);
  bool? get adult => _adult;
  String? get backdropPath => _backdropPath;
  List<num>? get genreIds => _genreIds;
  num? get id => _id;
  String? get originalLanguage => _originalLanguage;
  String? get originalTitle => _originalTitle;
  String? get overview => _overview;
  num? get popularity => _popularity;
  String? get posterPath => _posterPath;
  String? get releaseDate => _releaseDate;
  String? get title => _title;
  num? get voteAverage => _voteAverage;
  num? get voteCount => _voteCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = _adult;
    map['backdrop_path'] = _backdropPath;
    map['genre_ids'] = _genreIds;
    map['id'] = _id;
    map['original_language'] = _originalLanguage;
    map['original_title'] = _originalTitle;
    map['overview'] = _overview;
    map['popularity'] = _popularity;
    map['poster_path'] = _posterPath;
    map['release_date'] = _releaseDate;
    map['title'] = _title;
    map['vote_average'] = _voteAverage;
    map['vote_count'] = _voteCount;
    return map;
  }

}