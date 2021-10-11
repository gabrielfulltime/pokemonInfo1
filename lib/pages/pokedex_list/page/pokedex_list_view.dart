import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokebankv2/components/mensagem_centralizada.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';
import 'package:pokebankv2/pages/pokedex_list/page/pokedex_list_cubit.dart';
import 'package:pokebankv2/pages/pokedex_list/page/pokedex_list_states.dart';
import 'package:pokebankv2/pages/pokedex_specific/page/pokedex_especifico_view.dart';
import 'package:pokebankv2/services/http/pokemon_api_web/pokemon_api_web.dart';
import 'package:pokebankv2/tela%20aleatoria.dart';
import 'package:sqflite/utils/utils.dart';

class PokedexListView extends StatefulWidget {
  @override
  State<PokedexListView> createState() => _PokedexListViewState();
}

class _PokedexListViewState extends State<PokedexListView> {
  final PokemonWebApi _fetchPokemonsWeb = new PokemonWebApi();
  final _pagingController = PagingController<int, PokedexItem>(firstPageKey: 0);
  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    scroll.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    int _quantidadePokemon = 10;
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokedex", style: _styleWhite()),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.sync(() => _pagingController.refresh());
          },
          child: CustomScrollView(
            controller: scroll,
            slivers: <Widget>[
              SliverToBoxAdapter(child: Container()),
              PagedSliverGrid<int, PokedexItem>(
                showNewPageErrorIndicatorAsGridChild: false,
                showNoMoreItemsIndicatorAsGridChild: false,
                showNewPageProgressIndicatorAsGridChild: false,
                pagingController: _pagingController,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250, childAspectRatio: 5 / 5, crossAxisSpacing: 10, mainAxisSpacing: 10),
                builderDelegate:
                    PagedChildBuilderDelegate<PokedexItem>(itemBuilder: (BuildContext context, item, int index) {
                  Color? color = PokedexItem.colorsType[item.type![0]];
                  print(color);
                  return Material(
                    child: InkResponse(
                      highlightColor: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PokedexEspecifico(id: item.pokemon.pokedexId)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Flexible(
                              child: Hero(
                                tag: "pokemon$index",
                                child: Image.network(
                                  item.pokemon.urlImage,
                                  color: (item.found ? null : Colors.black),
                                ),
                              ),
                            ),
                            Text(item.pokemon.pokemonName.toUpperCase(), style: _styleWhite()),
                            Text(
                              "Nº ${item.pokemon.pokedexId.toString().padLeft(3, "0")}",
                              style: _styleWhite(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    child: Text("${item.type}", style: _styleWhite()),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    )),
                                Container(
                                    child: Text("${item.type}", style: _styleWhite()),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ))
                              ],
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ));
  }

  TextStyle _styleWhite() {
    return TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
  }

  _scrollListener() {
    if (scroll.offset >= scroll.position.maxScrollExtent - 150 &&
        _pagingController.value.status != PagingStatus.ongoing) {
      print("Vou atualizar");
      _pagingController.nextPageKey = _pagingController.itemList!.length;
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    print("Pagekey => ${_pagingController.nextPageKey} and firts pagekey ${_pagingController.firstPageKey}");
    print(pageKey);
    int initialPoint = pageKey + 1;
    int endPoint = initialPoint + 9;
    if (endPoint >= 898) endPoint = 898;
    try {
      final List<PokedexItem> newPage =
          await _fetchPokemonsWeb.findAllPokedex(initialPoint: initialPoint, endPoint: endPoint);
      print(newPage);
      print("Cheguei a fazer a request");
      final int previouslyFetchedItemsCount = _pagingController.itemList?.length ?? 0;
      final bool isLastPage = endPoint <= 898;
      if (isLastPage) {
        _pagingController.appendLastPage(newPage);
      } else {
        final int nextPageKey = pageKey + 1;
        _pagingController.appendPage(newPage, nextPageKey);
      }
      print("Cheguei ao fim do fetch");
    } catch (error) {
      _pagingController.error = error;
    }
  }
}

class PokedexGrid extends StatelessWidget {
  final LoadedPokedexListState state;

  PokedexGrid(this.state);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250, childAspectRatio: 5 / 5, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: state.pokedex.length,
        itemBuilder: (BuildContext context, index) {
          return Material(
            child: InkResponse(
              highlightColor: Colors.blueGrey[900],
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PokedexEspecifico(id: state.pokedex[index].pokemon.pokedexId)));
              },
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Flexible(
                        child: Hero(
                      tag: "pokemon$index",
                      child: Image.network(
                        state.pokedex[index].pokemon.urlImage,
                        color: (state.pokedex[index].found ? null : Colors.black),
                      ),
                    )),
                    Text(state.pokedex[index].pokemon.pokemonName.toUpperCase()),
                    Text("Nº ${state.pokedex[index].pokemon.pokedexId.toString().padLeft(3, "0")}"),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
              ),
            ),
          );
        });
  }
}
