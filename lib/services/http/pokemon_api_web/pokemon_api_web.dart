import 'dart:convert';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';
import 'package:pokebankv2/models/class/pokedex_item.dart';
import 'package:pokebankv2/services/http/interceptadores/loggin_interceptadores.dart';

class PokemonWebApi {
  Future<List<PokedexItem>> findAll(final int pokemonQuantity) async {
    Response response = await _pokedexListRequest(pokemonQuantity);
    List<PokedexItem> allPokedex = _toPokedexList(response);
    return allPokedex;
  }

  Future<List<PokedexItem>> findAllPokedex({required int initialPoint, required int endPoint}) async {
    final List<PokedexItem> allPokedex = [];
    for (int i = initialPoint; i <= endPoint ; i++) {
      PokedexItem? pokemonItem = await findA(nameOrId: i.toString());
      if (pokemonItem == null) break;
      allPokedex.add(pokemonItem);
    }
    return allPokedex;
  }

  Future<PokedexItem?> findA({String nameOrId = ""}) async {
    Response response = await _requisicaoPokemonItem(nameOrId);
    if (response.statusCode != 200) {
      return null;
    }
    PokedexItem pokedexItem = _toPokemonItem(response);
    return pokedexItem;
  }

  Future<void> findType(final String type) async {
    final String lowerType = type.toLowerCase();

    final String url = "https://pokeapi.co/api/v2/type/$lowerType";
    final InterceptedHttp client = InterceptedHttp.build(interceptors: [LoggingInterceptor()]);
    Response response = await client.get(Uri.parse(url)).timeout(Duration(seconds: 5));
    if (response.statusCode != 200) {
      return null;
    }
  }

  Future<Response> _pokedexListRequest(int quantidadePokemon) async {
    final InterceptedHttp client = InterceptedHttp.build(interceptors: [LoggingInterceptor()]);

    final Response response = await client
        .get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=$quantidadePokemon"))
        .timeout(Duration(seconds: 5));
    return response;
  }

  PokedexItem _toPokemonItem(Response response) {
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);

    PokedexItem? pokedexItem = PokedexItem.fromJson(json: decodedJson);
    return pokedexItem;
  }

  List<PokedexItem> _toPokedexList(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body)["results"];
    int i = 0;

    List<PokedexItem> totalPokedex = [];
    for (Map<String, dynamic> pokemonEspecie in decodedJson) {
      i++;
      final PokedexItem pokedexItem = PokedexItem.fromJson(json: pokemonEspecie, i: i);
      totalPokedex.add(pokedexItem);
    }
    return totalPokedex;
  }

  Future<Response> _requisicaoPokemonItem(String name) async {
    final String url;
    final String lowerName = name.toLowerCase();
    url = "https://pokeapi.co/api/v2/pokemon/$lowerName";
    final InterceptedHttp client = InterceptedHttp.build(interceptors: [LoggingInterceptor()]);
    final Response response = await client.get(Uri.parse(url)).timeout(Duration(seconds: 5));
    return response;
  }
}
