import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingmoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initiaLoading = ref.watch(initialLoadingProvider);

    if (initiaLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingmoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(moviesSlideshowProvider);
    final upComingMovies = ref.watch(moviesSlideshowProvider);
    final topRatedMovies = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          titlePadding: EdgeInsets.zero,
          centerTitle: false,
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            // const CustomAppbar(),
            // MoviesSlideshow(movies: nowPlayingMovies.take(6).toList()),
            MoviesSlideshow(movies: slideShowMovies),

            MovieHorizontalListview(
              movies: nowPlayingMovies,
              title: 'En cines',
              subtitle: 'Lunes 20',
              loadNextPage: () {
                ref.read(nowPlayingmoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: upComingMovies,
              title: 'Proximamente',
              subtitle: 'En este mes',
              loadNextPage: () {
                ref.read(upComingMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: popularMovies,
              title: 'Populares',
              // subtitle: 'En este mes',
              loadNextPage: () {
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
            ),
            MovieHorizontalListview(
              movies: topRatedMovies,
              title: 'Mejor Calificadas',
              subtitle: 'Desde Siempre',
              loadNextPage: () {
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
            ),
            const SizedBox(height: 10)
          ],
        );
      }, childCount: 1))
    ]);
  }
}
