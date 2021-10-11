import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';
import 'package:pokebankv2/pages/pokedex_list/page/pokedex_list_states.dart';
import 'package:pokebankv2/services/http/pokemon_api_web/pokemon_api_web.dart';

class PokedexListCubit extends Cubit<PokedexListState> {
  PokedexListCubit(this.pokemonWebApi) : super(InitialPokedexListState());
  final PokemonWebApi pokemonWebApi;

  Future<void> loadPokedex({required int initialPoint, required int endPoint}) async {
    emit(LoadingPokedexListState());
    final List<PokedexItem> pokedex =
        await pokemonWebApi.findAllPokedex(initialPoint: initialPoint, endPoint: endPoint);
    emit(LoadedPokedexListState(pokedex: pokedex, hasReachedMax: false));
  }

  void nextLoad({required LoadedPokedexListState state}) async {
    emit(LoadingPokedexListState());
    final List<PokedexItem> news =
        await pokemonWebApi.findAllPokedex(initialPoint: state.pokedex.length+1, endPoint: state.pokedex.length + 10);
    final List<PokedexItem> pokedexList = state.pokedex;
    for (PokedexItem pokemon in news) {
      print (pokemon);
      pokedexList.add(pokemon);
    }
    emit(LoadedPokedexListState(pokedex: pokedexList));
  }
}
