import 'package:flutter/material.dart';

class InformacoesConta extends ChangeNotifier {
  bool isMasculino;

  String namePerson;

  double money;

  int pokedexCatch;

  String timeInGame = "${DateTime.now().minute}";

  List<int> listaCapturadosDex = [];


  void changeSex(bool toMasculino) {
    if (toMasculino) {
      isMasculino = true;
    } else {
      isMasculino = false;
    }
    notifyListeners();
    return;
  }


  void changeNamePerson({required String newName}) {
    namePerson = newName;
    notifyListeners();
    return;
  }

  void addListPokedex(int pokemonId) {
    assert(pokemonId >0 && pokemonId <899);
    bool estaNaLista = listaCapturadosDex.any((elemento) => elemento == pokemonId);
    if (estaNaLista) {
      return;
    }
    listaCapturadosDex.add(pokemonId);
    pokedexCatch = listaCapturadosDex.length;
    notifyListeners();
    return;
  }

  void addMoney(double money) {
    this.money += money;
    notifyListeners();
    return;
  }

  void subMoney(double money) {
    assert (this.money >= money);
    this.money -= money;
    notifyListeners();
    return;
  }

  InformacoesConta({this.isMasculino = true, this.namePerson = "RED", this.money = 0.0, this.pokedexCatch = 0})
      :assert (money >=0);
}
