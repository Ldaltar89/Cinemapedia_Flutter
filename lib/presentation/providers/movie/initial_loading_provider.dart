import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(moviesSlideshowProvider).isEmpty;
  final step2 = ref.watch(moviesSlideshowProvider).isEmpty;
  final step3 = ref.watch(moviesSlideshowProvider).isEmpty;
  final step4 = ref.watch(moviesSlideshowProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  return false;
});