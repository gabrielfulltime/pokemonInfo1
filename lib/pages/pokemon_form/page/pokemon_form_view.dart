import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/components/progress.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';
import 'package:pokebankv2/models/class/pokemon.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';
import 'package:pokebankv2/pages/pokemon_form/page/pokemon_form_cubit.dart';
import 'package:pokebankv2/pages/pokemon_form/page/pokemon_form_states.dart';
import 'package:pokebankv2/services/data_base/capturados_dao/pokemons_dao.dart';
import 'package:provider/provider.dart';

/*
  Cubit and Container
 */


//

class PokemonForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PokemonsDao _pokemonsDao = AppDependencies.of(context)!.pokemonsDao;

    return BlocProvider(
      create: (BuildContext contextBloc) => PokeFormCubit(),
      child: BlocBuilder<PokeFormCubit, PokemonFormState>(
        builder: (context, state) {
          if (state is InitialPokemonFormState || state is NotFindedPokemonFormState) {
            return _pokeForm(context, state);
          }
          if (state is FindedPokemonFormState) {
            return _pokeFormPokemonFinded(context, state.pokeInformacao, _pokemonsDao);
          }
          if (state is FindingPokemonFormState) {
            return Scaffold(appBar: AppBar(title: Text("Novo Pokemon")), body: Progress("Buscando Pokemon..."));
          }
          return Text("Error");
        },
      ),
    );
  }

  Widget _pokeForm(
    BuildContext context,
    PokemonFormState state,
  ) {
    final TextEditingController _controladorCampoPokeNome = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Pokemon"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              autofocus: (state is NotFindedPokemonFormState) ? true : false,
              maxLength: 30,
              textCapitalization: TextCapitalization.characters,
              controller: _controladorCampoPokeNome,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                labelText: "Nome ou numero da pokedex",
                hintText: "Bulbasaur / 1",
              ),
              keyboardType: TextInputType.name,
              onSubmitted: (string) async {
                final String pokeNome = _controladorCampoPokeNome.text;
                BlocProvider.of<PokeFormCubit>(context).fetchPokemon(pokeNome, context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _pokeFormPokemonFinded(BuildContext context, PokedexItem pokeInformacao, PokemonsDao pokemonsDao) {
    final TextEditingController _controladorCampoPokeNome = TextEditingController();
    _controladorCampoPokeNome.text = pokeInformacao.pokemon.pokemonName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon Capturado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              textCapitalization: TextCapitalization.characters,
              controller: _controladorCampoPokeNome,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                labelText: "Nome Pokemon ou numero da pokedex",
                hintText: "Bulbasaur / 1",
              ),
              keyboardType: TextInputType.name,
              onSubmitted: (string) async {
                final String pokeNome = _controladorCampoPokeNome.text;
                BlocProvider.of<PokeFormCubit>(context).fetchPokemon(pokeNome, context);
              },
            ),
            _pokemonSpecifications(context, pokeInformacao, pokemonsDao),
          ],
        ),
      ),
    );
  }

  Widget _pokemonSpecifications(BuildContext context, PokedexItem pokeInformacao, PokemonsDao _pokemonsDao) {
    final TextEditingController _controladorCampoPokeNumero = TextEditingController();
    final TextEditingController _controladorCampoPokeNome = TextEditingController();
    _controladorCampoPokeNumero.text = pokeInformacao.pokemon.pokedexId.toString();
    _controladorCampoPokeNome.text = pokeInformacao.pokemon.pokemonName;
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
        child: TextField(
          enabled: false,
          controller: _controladorCampoPokeNumero,
          style: TextStyle(fontSize: 24.0),
          decoration: InputDecoration(
            labelText: "Numero da Pokedex",
            hintText: "1",
          ),
          keyboardType: TextInputType.number,
        ),
      ),
      Container(
          height: 150,
          child: Image.network(
            pokeInformacao.pokemon.urlImage.toString(),
            height: 100,
          )),
      SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          child: Text("Confirmar"),
          onPressed: () {
            final String pokeNome = _controladorCampoPokeNome.text;
            final pokeNumero = int.tryParse(_controladorCampoPokeNumero.text);
            final Pokemon novoPokemon = Pokemon(pokeNome, pokeNumero!);
            Provider.of<InformacoesConta>(context, listen: false).addListPokedex(pokeNumero);
            _pokemonsDao.save(novoPokemon).then((id) => Navigator.pop(context));
          },
        ),
      ),
    ]);
  }
}
