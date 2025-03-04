import 'package:dartz/dartz.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_info_response.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_species_reponse.dart';
import 'package:pokedexsprout/data/domain/repositories/pokemon_repository.dart';

import '../../../common/failure.dart';
import '../entities/pokemon_info_entity.dart';

class PokemonUseCase {
  final PokemonRepository respository;

  PokemonUseCase(this.respository);

  Future<Either<Failure,List<PokemonInfoEntity>>>  getPokemons(){
    return respository.getPokemons();
  }
  Future<Either<Failure,PokemonInfoResponse>> getPokemonInfo(url){
    return respository.getPokemonInfo(url);
  }
  Future<Either<Failure,PokemonSpeciesResponse>> getPokemonSpecies(url){
    return respository.getSpeciesPokemon(url);
  }
}