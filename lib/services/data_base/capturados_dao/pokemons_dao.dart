import 'package:path/path.dart';
import 'package:pokebankv2/models/class/pokemon.dart';
import 'package:sqflite/sqflite.dart';

class PokemonsDao {
  static const String _tableName = "pokemons";
  static const String _rowPokeNome = "poke_nome";
  static const String _rowPokeNumero = "poke_numero";
  static const String _rowId = "id";
  static const String _rowDataCaptura = "data_captura";
  static const String tableSql = 'CREATE TABLE $_tableName ('
      '$_rowId INTEGER PRIMARY KEY, '
      '$_rowPokeNome TEXT, '
      '$_rowPokeNumero INTEGER,'
      '$_rowDataCaptura TEXT )';

  Future<Database> getDataBase() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, "pokebank.db");
    return openDatabase(
      path,
      onCreate: (db, version) {
        db.execute(tableSql);
      },
      version: 1,
      // onDowngrade: onDatabaseDowngradeDelete,
    );
  }

  Future<int?> save(Pokemon pokemon) async {
    final Database db = await getDataBase();
    Map<String, dynamic> pokemonMap = _toMap(pokemon);
    return db.insert(_tableName, pokemonMap);
  }

  Future<List<Pokemon>> findAll() async {
    final Database db = await getDataBase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Pokemon> pokemons = _toList(result);
    return pokemons;
  }

  // Metodos da de uso interno
  List<Pokemon> _toList(List<Map<String, dynamic>> result) {
    final List<Pokemon> pokemons = [];
    for (Map<String, dynamic> row in result) {
      final Pokemon pokemon = Pokemon(row[_rowPokeNome], row[_rowPokeNumero]);
      pokemons.add(pokemon);
    }
    return pokemons;
  }

  Map<String, dynamic> _toMap(Pokemon pokemon) {
    final Map<String, dynamic> pokemonMap = Map();
    pokemonMap[_rowPokeNome] = pokemon.pokemonName;
    pokemonMap[_rowPokeNumero] = pokemon.pokedexId;
    print(pokemonMap);
    return pokemonMap;
  }
}
