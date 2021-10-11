import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';
import 'package:pokebankv2/services/http/pokemon_api_web/pokemon_api_web.dart';

class PokedexEspecifico extends StatefulWidget {
  final int id;

  PokedexEspecifico({required this.id});

  @override
  _PokedexEspecificoState createState() => _PokedexEspecificoState();
}

class _PokedexEspecificoState extends State<PokedexEspecifico> {
  @override
  Widget build(BuildContext context) {
    final PokemonWebApi _fetchPokemonsWeb = AppDependencies.of(context)!.pokemonsWeb;

    return Scaffold(
        appBar: AppBar(
          title: Text("Pokedex N° ${this.widget.id.toString()}"),
        ),
        body: FutureBuilder<PokedexItem?>(
            future: _fetchPokemonsWeb.findA(nameOrId: this.widget.id.toString()),
            builder: (context, AsyncSnapshot<PokedexItem?> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.waiting:
                  Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              "Carregando",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          CircularProgressIndicator(),
                        ]),
                  );
                  break;
                case ConnectionState.active:
                  // TODO: Handle this case.
                  break;
                case ConnectionState.done:
                  final PokedexItem pokedexItem;

                  print("${this.widget.id}");
                  pokedexItem = snapshot.data!;
                  final List<Map<String, String>> pokemonStatus = _retornaStatus(pokedexItem.status!);
                  final List<String> pokemonType = _retornaTipo(pokedexItem.type!);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                              [Hero(tag: "pokemon${this.widget.id - 1}", child: Image.network(pokedexItem
                                  .pokemon.urlImage))]),
                        ),
                        pokemonType.length != 1 ? sliverTypeTwo(pokemonType) : sliverTypeOne(pokemonType),
                        SliverList(
                            delegate: SliverChildListDelegate([
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                child: Center(
                                    child: Text(
                              "Pokemon Status",
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                            ))),
                          ),
                        ])),
                        formaStatus(pokemonStatus),
                        formaStatus(pokemonStatus),
                        formaStatus(pokemonStatus),
                      ],
                    ),
                  );
              }
              return Text("");
            }));
  }

  SliverGrid formaStatus(List<Map<String, String>> pokemonStatus) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300, crossAxisSpacing: 10, mainAxisSpacing: 10, mainAxisExtent: 30),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            decoration:
                BoxDecoration(color: Colors.cyan[100 * ((index + 1) % 9)], borderRadius: BorderRadius.circular(5)),
            alignment: Alignment.centerLeft,
            child: Text(
              ' ${pokemonStatus[index]["value"]!.padLeft(3, "0")} -> ${pokemonStatus[index]["name"]}',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          );
        },
        childCount: pokemonStatus.length,
      ),
    );
  }

  SliverList sliverTypeOne(List<String> pokemonType) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Center(
                child: Text(
          "${pokemonType[0]}",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ))),
      ),
    ]));
  }

  Widget sliverTypeTwo(List<String> pokemonType) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Center(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  "${pokemonType[index]}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          );
        },
        childCount: pokemonType.length,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        mainAxisExtent: 30,
      ),
    );
  }

  List<String> _retornaTipo(List<dynamic> listType) {
    List<String> listRetorno = [];
    for (int i = 0; i < listType.length; i++) {
      listRetorno.add(
        listType[i]["type"]["name"].toUpperCase(),
      );
    }
    return listRetorno;
  }

  List<Map<String, String>> _retornaStatus(List<dynamic> listaStatus) {
    List<Map<String, String>> listStatus = [];
    for (int i = 0; i < listaStatus.length; i++) {
      listStatus
          .add({"name": listaStatus[i]["stat"]["name"].toUpperCase(), "value": listaStatus[i]["base_stat"].toString()});
    }
    debugPrint("$listStatus");
    return listStatus;
  }
}
