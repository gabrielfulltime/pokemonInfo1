import 'package:flutter/material.dart';
import 'package:pokebankv2/models/class/pokemon.dart';

class PokemonItem extends StatelessWidget {
  final Pokemon pokemon;

  PokemonItem(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(pokemon.pokedexId.toString()),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(50),
        ),
        alignment: Alignment.centerLeft,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.red[100], shape: BoxShape.circle),
                    child: Image.network(
                      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${pokemon.pokedexId}.png",
                      height: 50,
                      width: 50
                      // "https://www.pkparaiso.com/imagenes/xy/sprites/animados/${pokemon.pokeNome.toLowerCase()}.gif", width: 50
                      ,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, exception, stackTrace) {
                        return Container(
                          child: Column(
                            children: [
                              Image.asset(
                                "images/pikachu_meme.png",
                                height: 50,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    pokemon.pokemonName,
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Text("Lv. ${pokemon.pokedexId}", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black12),
                      child: Row(
                        children: [
                          Text(
                            "HP ",
                            style: TextStyle(),
                          ),
                          SizedBox(
                              width: 100,
                              height: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent[700], borderRadius: BorderRadius.circular(10)),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "172/172",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}