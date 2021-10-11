import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_cubit.dart';
import 'package:pokebankv2/pages/pokemon_list/page/pokemon_list_states.dart';
import 'package:pokebankv2/services/data_base/capturados_dao/pokemons_dao.dart';
import 'package:pokebankv2/services/http/pokemon_api_web/pokemon_api_web.dart';
import 'package:pokebankv2/services/http/transferidos/transfers_api_web.dart';

class PokemonsDaoMock extends Mock implements PokemonsDao{}
class FetchPokemonsWebMock extends Mock implements PokemonWebApi{}
class TransfersWebMock extends Mock implements TransfersWeb{}
class BuildContextMock extends Mock implements BuildContext{}
class PokemonListCubitMock extends MockCubit<PokemonListState> implements PokemonListCubit {}

