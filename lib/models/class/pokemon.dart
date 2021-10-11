class Pokemon {
  String pokemonName;
  int pokedexId;
  String uniqueId = "DEFAULT";
  late final String urlImage;

  Pokemon(this.pokemonName, this.pokedexId) : assert(pokedexId > 0 && pokedexId < 898) {
    this.urlImage = // "https://www.pkparaiso.com/imagenes/xy/sprites/animados/${json["name"]}.gif",
        //     "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/10.svg",
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${this.pokedexId}.png";
  }

  Pokemon.fromJson({required Map<String, dynamic> json, int? i, bool achado = true})
      : pokedexId = i == null ? json["id"] : i,
        pokemonName = json["name"].toUpperCase(),
        urlImage =
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${i == null ? json["id"] : i}.png";
}
