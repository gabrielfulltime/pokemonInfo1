import 'package:flutter_test/flutter_test.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';

void main() {
  group("Testes do provider InformacoesConta", () {
    final provider = InformacoesConta();
    final String newName = "RODRIGO";
    final double valueMoney = 10;
    final int pokemonId = 1;
    final bool sexToMale = true;
    final bool sexToFemale = false;
    test("Deve inserir nome", (){
      provider.changeNamePerson(newName: newName);
      expect(provider.namePerson, newName);
    });
    test("Deve ganhar 10 e perder 10", (){
      provider.addMoney(valueMoney);
      expect(provider.money, valueMoney);
      provider.subMoney(valueMoney);
      expect(provider.money, 0);
    });
    test("Deve retornar erro por retirar o que não tem", (){
      expect(() =>provider.subMoney(100), throwsAssertionError);
    });
    test("Deve retornar erro quando perder mais dinheiro do que possui", (){
      expect(() => InformacoesConta(money: -100), throwsAssertionError);
    });
    test("Deve adicionar pokemons na pokedexList", (){
      provider.addListPokedex(pokemonId);
      expect(provider.listaCapturadosDex[0], pokemonId );
    });
    test("Deve retornar erro por adicionar um pokemon_list com id inexistente", () {
      expect(() => provider.addListPokedex(100000), throwsAssertionError);
    });
    test("Deve retornar o numero de pokemons conhecidos da pokedex_list", (){
      provider.addListPokedex(pokemonId);
      expect(provider.pokedexCatch, 1);
    });
    test("Deve mudar o sexo do personagem mostrado", (){
      provider.changeSex(sexToMale);
      expect(provider.isMasculino, true);
      provider.changeSex(sexToFemale);
      expect(provider.isMasculino, false);
    });
  });
}
