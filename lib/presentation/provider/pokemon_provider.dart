
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedexsprout/data/datasource/pokemon_remote_data_source.dart';
import 'package:pokedexsprout/data/domain/repositories/pokemon_repository.dart';

import '../../common/dio_interceptor.dart';
import '../../data/domain/usecase/pokemon_use_case.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(DioInterceptor());
  return dio;
});

final pokemonRemoteRepositoryProvider = Provider<PokemonRemoteDataSource>(
      (ref) => PokemonRemoteDataSourceImpl( dio: ref.read(dioProvider)),
);

final pokemonRepositoryProvider = Provider<PokemonRepository>(
    (ref) => PokemonRepositoryImpl( remoteDataSource: ref.read(pokemonRemoteRepositoryProvider))
);

final getPokemonUseCaseProvider = Provider<PokemonUseCase>(
      (ref) => PokemonUseCase(ref.read(pokemonRepositoryProvider)),
);

final getPokemonProvider = FutureProvider((ref) async {
  final getPokemonUseCase = ref.read(getPokemonUseCaseProvider);
  final result = await getPokemonUseCase.respository.getPokemons();

  return result.fold(
        (failure) => throw Exception(failure.message),
        (pokemonResults) => pokemonResults,
  );
});

final getPokemonSpeciesProvider = FutureProvider.family((ref, String url) async {
  final getPokemonUseCase = ref.read(getPokemonUseCaseProvider);
  final result = await getPokemonUseCase.respository.getSpeciesPokemon(url);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (pokemonResults) => pokemonResults,
  );
});

final getPokemonInfoProvider = FutureProvider.family((ref, String url) async {
  final getPokemonUseCase = ref.read(getPokemonUseCaseProvider);
  final result = await getPokemonUseCase.respository.getPokemonInfo(url);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (pokemonResults) => pokemonResults,
  );
});
