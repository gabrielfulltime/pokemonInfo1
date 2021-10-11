import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';
import 'package:pokebankv2/pages/pokemon_form/page/pokemon_form_states.dart';
import 'package:pokebankv2/services/http/pokemon_api_web/pokemon_api_web.dart';

class PokeFormCubit extends Cubit<PokemonFormState> {
  PokeFormCubit() : super(InitialPokemonFormState());

  void fetchPokemon(String pokeNome, BuildContext context) async {
    emit(FindingPokemonFormState());
    final PokemonWebApi _fetchPokemonsWeb = AppDependencies.of(context)!.pokemonsWeb;
    final PokedexItem? pokeInformacao = await _fetchPokemonsWeb.findA(nameOrId: pokeNome);
    emit(pokeInformacao != null ? FindedPokemonFormState(pokeInformacao) : NotFindedPokemonFormState());
  }
}