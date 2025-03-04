import 'package:dio/dio.dart';
import 'package:pokedexsprout/common/constants.dart';
import 'package:pokedexsprout/common/exception.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_info_response.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_list_response.dart';
import 'package:pokedexsprout/data/domain/model/pokemon_species_reponse.dart';


abstract class PokemonRemoteDataSource {
  Future<PokemonListResponse> getPokemons();
  Future<PokemonInfoResponse> getInfoPokemon(url);
  Future<PokemonSpeciesResponse> getSpeciesPokemon(url);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final Dio dio;

  PokemonRemoteDataSourceImpl({required this.dio});

  @override
  Future<PokemonListResponse> getPokemons() async {
     final response = await dio.get('$BASE_URL/pokemon');

     if(response.statusCode == 200){
       return PokemonListResponse.fromJson(response.data);
     }else {
       throw ServerException.fromJson(response.data);
     }
  }

  @override
  Future<PokemonInfoResponse> getInfoPokemon(url) async {
    final response = await dio.get(url);

    if(response.statusCode == 200){
      return PokemonInfoResponse.fromJson(response.data);
    }else {
      throw ServerException.fromJson(response.data);
    }
  }

  @override
  Future<PokemonSpeciesResponse> getSpeciesPokemon(url) async {
    final response = await dio.get(url);

    if(response.statusCode == 200){
      return PokemonSpeciesResponse.fromJson(response.data);
    }else {
      throw ServerException.fromJson(response.data);
    }
  }

}