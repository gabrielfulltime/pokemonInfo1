import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';
import 'package:pokebankv2/services/http/pokemon_api_web/pokemon_api_web.dart';

class PagedInfinitScroll extends StatefulWidget {
  const PagedInfinitScroll({Key? key, required this.repository}) : super(key: key);
  final PokemonWebApi repository;

  @override
  _PagedInfinitScrollState createState() => _PagedInfinitScrollState();
}

class _PagedInfinitScrollState extends State<PagedInfinitScroll> {
  final _pagingController = PagingController<int, PokedexItem>(firstPageKey: 0);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => _fetchPage(pageKey));
    _scrollController.addListener(_scrollListener);

  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Cheguei na build");
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Text("Algo")
            ),
            PagedSliverList<int, PokedexItem>(

              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<PokedexItem>(
                  itemBuilder: (BuildContext context, PokedexItem pokedexItem, int index) {
                    print("Cheguei no builder");
                    final pokemon = pokedexItem;
                    return Container(
                      child: Text("${pokemon.pokemon.pokemonName} and ${pokemon.pokemon.pokedexId}"),
                      height: 50,
                      color: Colors.blue,
                      width: 50,
                    );
                  },
                  firstPageErrorIndicatorBuilder: (context) {
                    print(_pagingController.error);
                    print(_pagingController.itemList);
                    return Text("Deu erro de primeira");
                  },
                  noItemsFoundIndicatorBuilder: (context) => Text("Num achamo nada")),
            ),
            SliverToBoxAdapter(
              child: ElevatedButton(
                child: Icon(Icons.refresh),
                onPressed: () => _pagingController.notifyPageRequestListeners(_pagingController.itemList!.length)
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {

    print ("Pagekey => ${_pagingController.nextPageKey} and firts pagekey ${_pagingController.firstPageKey}");
    print(pageKey);
    int initialPoint = pageKey +1;
    int endPoint = initialPoint + 20;
    if (endPoint>= 898) endPoint = 898;
    try {
      final List<PokedexItem> newPage =
          await widget.repository.findAllPokedex(initialPoint: initialPoint, endPoint: endPoint);
      print(newPage);
      print("Cheguei a fazer a request");
      final int previouslyFetchedItemsCount = _pagingController.itemList?.length ?? 0;
      final bool isLastPage = endPoint <= 898;
      if (isLastPage) {
        _pagingController.appendLastPage(newPage);
      } else {
        final int nextPageKey = pageKey +1;
        _pagingController.appendPage(newPage, nextPageKey);
      }
      print("Cheguei ao fim do fetch");
    } catch (error) {
      _pagingController.error = error;
    }
  }

  _scrollListener(){
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent){
      _pagingController.notifyPageRequestListeners(_pagingController.itemList!.length);
    }

  }
}
