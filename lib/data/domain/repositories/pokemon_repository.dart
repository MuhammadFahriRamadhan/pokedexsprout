
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:pokedexsprout/common/failure.dart';
import 'package:pokedexsprout/data/datasource/pokemon_remote_data_source.dart';
import 'package:pokedexsprout/data/domain/entities/pokemon_info_entity.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_info_response.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_species_reponse.dart';

import '../../../common/exception.dart';

abstract class PokemonRepository {
  Future<Either<Failure,List<PokemonInfoEntity>>>  getPokemons();
  Future<Either<Failure,PokemonInfoResponse>> getPokemonInfo(url);
  Future<Either<Failure,PokemonSpeciesResponse>> getSpeciesPokemon(url);
}

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;
  final List<PokemonInfoEntity> _pokemonList = [];

  PokemonRepositoryImpl({ required this.remoteDataSource });


  @override
  Future<Either<Failure, List<PokemonInfoEntity>>> getPokemons() async {
    try {
      final response = await remoteDataSource.getPokemons();
      for (var data in response.results) {
        final pokemonResponse = await remoteDataSource.getInfoPokemon(data.url);
        final pokemonInfo = pokemonResponse.toPokemonInfo();

        if (!_pokemonList.any((p) => p.name == pokemonInfo.name)) {
          _pokemonList.add(pokemonInfo);
        }
      }
      return Right(_pokemonList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, PokemonInfoResponse>> getPokemonInfo(url) async{
    try {
      final response = await remoteDataSource.getInfoPokemon(url);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, PokemonSpeciesResponse>> getSpeciesPokemon(url) async {
    try {
      final response = await remoteDataSource.getSpeciesPokemon(url);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

}