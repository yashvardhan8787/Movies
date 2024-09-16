class AppUrls {
  // Base URL for the API
  static var baseUrl = "https://api.themoviedb.org/3";
  // Endpoint for fetching movie list
  static var movieList = baseUrl + "/discover/movie";
  //endpoint for movies poster
  static var posterPathBaseUrl="https://image.tmdb.org/t/p/w500" ;
  //endpoint for upcoming movies
  static var upcomingMovieUrl =baseUrl+'/movie/upcoming';
  //endpoint for topRated movies
  static var topRatedMovieUrl =baseUrl+'/movie/top_rated';
  //endpoint for popular movies
  static var popularMovieUrl =baseUrl+'/movie/popular';
  //endpoint for now playing movies
  static var now_playingMovieUrl =baseUrl+'/movie/now_playing';

  //base end point for details of particular movie
 static var movieDetailUrl = "https://api.themoviedb.org/3/movie/" ;
}


