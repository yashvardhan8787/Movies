/// page : 1
/// results : [{"poster_path":"/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg","adult":false,"overview":"Cobb, a skilled thief...","release_date":"2010-07-15","genre_ids":[28,878,12],"id":27205,"original_title":"Inception","original_language":"en","title":"Inception","backdrop_path":"/s3TBrRGB1iav7gFOCNx3H31MoES.jpg","popularity":27.920,"vote_count":28825,"video":false,"vote_average":8.3}]
/// total_pages : 1
/// total_results : 1

class SearchResultModel {
  SearchResultModel({
      num? page, 
      List<searchResults>? results,
      num? totalPages, 
      num? totalResults,}){
    _page = page;
    _results = results;
    _totalPages = totalPages;
    _totalResults = totalResults;
}

  SearchResultModel.fromJson(dynamic json) {
    _page = json['page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(searchResults.fromJson(v));
      });
    }
    _totalPages = json['total_pages'];
    _totalResults = json['total_results'];
  }
  num? _page;
  List<searchResults>? _results;
  num? _totalPages;
  num? _totalResults;
SearchResultModel copyWith({  num? page,
  List<searchResults>? results,
  num? totalPages,
  num? totalResults,
}) => SearchResultModel(  page: page ?? _page,
  results: results ?? _results,
  totalPages: totalPages ?? _totalPages,
  totalResults: totalResults ?? _totalResults,
);
  num? get page => _page;
  List<searchResults>? get results => _results;
  num? get totalPages => _totalPages;
  num? get totalResults => _totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = _totalPages;
    map['total_results'] = _totalResults;
    return map;
  }

}

/// poster_path : "/qmDpIHrmpJINaRKAfWQfftjCdyi.jpg"
/// adult : false
/// overview : "Cobb, a skilled thief..."
/// release_date : "2010-07-15"
/// genre_ids : [28,878,12]
/// id : 27205
/// original_title : "Inception"
/// original_language : "en"
/// title : "Inception"
/// backdrop_path : "/s3TBrRGB1iav7gFOCNx3H31MoES.jpg"
/// popularity : 27.920
/// vote_count : 28825
/// video : false
/// vote_average : 8.3

class searchResults {
  Results({
      String? posterPath, 
      bool? adult, 
      String? overview, 
      String? releaseDate, 
      List<num>? genreIds, 
      num? id, 
      String? originalTitle, 
      String? originalLanguage, 
      String? title, 
      String? backdropPath, 
      num? popularity, 
      num? voteCount, 
      bool? video, 
      num? voteAverage,}){
    _posterPath = posterPath;
    _adult = adult;
    _overview = overview;
    _releaseDate = releaseDate;
    _genreIds = genreIds;
    _id = id;
    _originalTitle = originalTitle;
    _originalLanguage = originalLanguage;
    _title = title;
    _backdropPath = backdropPath;
    _popularity = popularity;
    _voteCount = voteCount;
    _video = video;
    _voteAverage = voteAverage;
}

  searchResults.fromJson(dynamic json) {
    _posterPath = json['poster_path'];
    _adult = json['adult'];
    _overview = json['overview'];
    _releaseDate = json['release_date'];
    _genreIds = json['genre_ids'] != null ? json['genre_ids'].cast<num>() : [];
    _id = json['id'];
    _originalTitle = json['original_title'];
    _originalLanguage = json['original_language'];
    _title = json['title'];
    _backdropPath = json['backdrop_path'];
    _popularity = json['popularity'];
    _voteCount = json['vote_count'];
    _video = json['video'];
    _voteAverage = json['vote_average'];
  }
  String? _posterPath;
  bool? _adult;
  String? _overview;
  String? _releaseDate;
  List<num>? _genreIds;
  num? _id;
  String? _originalTitle;
  String? _originalLanguage;
  String? _title;
  String? _backdropPath;
  num? _popularity;
  num? _voteCount;
  bool? _video;
  num? _voteAverage;
searchResults copyWith({  String? posterPath,
  bool? adult,
  String? overview,
  String? releaseDate,
  List<num>? genreIds,
  num? id,
  String? originalTitle,
  String? originalLanguage,
  String? title,
  String? backdropPath,
  num? popularity,
  num? voteCount,
  bool? video,
  num? voteAverage,
}) => Results(  posterPath: posterPath ?? _posterPath,
  adult: adult ?? _adult,
  overview: overview ?? _overview,
  releaseDate: releaseDate ?? _releaseDate,
  genreIds: genreIds ?? _genreIds,
  id: id ?? _id,
  originalTitle: originalTitle ?? _originalTitle,
  originalLanguage: originalLanguage ?? _originalLanguage,
  title: title ?? _title,
  backdropPath: backdropPath ?? _backdropPath,
  popularity: popularity ?? _popularity,
  voteCount: voteCount ?? _voteCount,
  video: video ?? _video,
  voteAverage: voteAverage ?? _voteAverage,
);
  String? get posterPath => _posterPath;
  bool? get adult => _adult;
  String? get overview => _overview;
  String? get releaseDate => _releaseDate;
  List<num>? get genreIds => _genreIds;
  num? get id => _id;
  String? get originalTitle => _originalTitle;
  String? get originalLanguage => _originalLanguage;
  String? get title => _title;
  String? get backdropPath => _backdropPath;
  num? get popularity => _popularity;
  num? get voteCount => _voteCount;
  bool? get video => _video;
  num? get voteAverage => _voteAverage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['poster_path'] = _posterPath;
    map['adult'] = _adult;
    map['overview'] = _overview;
    map['release_date'] = _releaseDate;
    map['genre_ids'] = _genreIds;
    map['id'] = _id;
    map['original_title'] = _originalTitle;
    map['original_language'] = _originalLanguage;
    map['title'] = _title;
    map['backdrop_path'] = _backdropPath;
    map['popularity'] = _popularity;
    map['vote_count'] = _voteCount;
    map['video'] = _video;
    map['vote_average'] = _voteAverage;
    return map;
  }

}