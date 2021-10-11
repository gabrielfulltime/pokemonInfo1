import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/models/class/pokemon.dart';
import 'package:pokebankv2/pages/pokemon_form/page/pokemon_form_view.dart';
import 'package:pokebankv2/pages/pokemon_list/components/pokemon_item_component.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_cubit.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_states.dart';
import 'package:pokebankv2/pages/pokemon_transfer_form/page/new_transfer_view.dart';
import 'package:pokebankv2/routes.dart';


class PokemonListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seus pokemons"),
      ),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(builder: (contextBloc, state) {
        if (state is InitialPokemonListState || state is LoadingPokemonListState) {
          BlocProvider.of<PokemonListCubit>(contextBloc).load();
          return _loadingCenter();
        }
        // if (state is LoadingPokemonListState) {
        //   return _loadingCenter();
        // }
        if (state is LoadedPokemonListState) {
          final List<Pokemon> pokemons = state.pokemonList;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: _whenPokemonListBuilded(pokemons),
          );
        }
        if (state is LoadedEmptyPokemonListState) {
          return _whenPokemonListEmpty(context);
        }
        if (state is FatalErrorPokemonListState) {
          return _whenReturnError("Erro ao trazer seus pokemons capturados");
        }
        return _whenReturnError("Estado não identificado");
      }),
      floatingActionButton: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (BuildContext context, state) {
          if (state is LoadedPokemonListState || state is LoadedEmptyPokemonListState) {
            return FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, Routes.pokemon_form_route);
                });
          }
          return Container();
        },
      ),
    );
  }

  Widget _whenReturnError(String message) {
    return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Column(
                children: <Widget>[Icon(Icons.warning), Text(message)],
              )),
            ),
          );
  }

  Widget _whenPokemonListEmpty(BuildContext context) {
    return Center(
        child: Text("Você ainda não capturou nenhum pokemon, toque no botão para adicionar",
            style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.center));
  }

  Widget _whenPokemonListBuilded(List<Pokemon> pokemons) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final Pokemon pokemon = pokemons[index];
        return Material(
            child: InkResponse(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return NovaTransferencia();
                  }));
                },
                child: PokemonItem(pokemon)));
      },
      itemCount: pokemons.length,
    );
  }

  Widget _loadingCenter() {
    return Center(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Text(
            "Carregando",
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        CircularProgressIndicator(),
      ]),
    );
  }
}