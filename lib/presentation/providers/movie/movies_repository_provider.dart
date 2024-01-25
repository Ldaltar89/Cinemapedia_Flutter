import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este respositorio es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRespositoryImpl(MoviedbDatasource());
});
