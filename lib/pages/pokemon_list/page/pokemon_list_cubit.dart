import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_states.dart';
import 'package:pokebankv2/services/data_base/capturados_dao/pokemons_dao.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  final PokemonsDao pokemonsDao;
  PokemonListCubit(this.pokemonsDao) : super(InitialPokemonListState());


  Future<void> load() async {

    emit(LoadingPokemonListState());
    await pokemonsDao.findAll().then((pokemonsList) {
       emit(
           pokemonsList.isNotEmpty?
                 LoadedPokemonListState(pokemonsList)
               : LoadedEmptyPokemonListState());
    });
  }
}
