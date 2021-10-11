import 'package:flutter/material.dart';
import 'package:pokebankv2/models/provider/informacoes_conta.dart';
import 'package:provider/provider.dart';

class NameView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerName = TextEditingController();
    print("Re build");
    _controllerName.text = Provider.of<InformacoesConta>(context, listen: false).namePerson;
    final Key containerPersonagemMasculinoKey = Key("containerPersonagemMasculinoKey");
    final Key containerPersonagemFemininoKey = Key("containerPersonagemFemininoKey");

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controllerName,
                decoration: InputDecoration(labelText: ("Nome que deseja ser chamado")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<InformacoesConta>(
                builder: (context, informacoesConta, child) {
                  print("Consumer");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        key: containerPersonagemMasculinoKey,
                        borderRadius: BorderRadius.circular(10),
                        color: informacoesConta.isMasculino ? Colors.blue[100]: Colors.red[100] ,
                        child: InkWell(
                          onTap: () {
                            informacoesConta.changeSex(true);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Masculino",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Container(
                                    child: Image.asset(
                                      "images/red.png",
                                      height: 140,
                                      width: 140,
                                    ),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        key: containerPersonagemFemininoKey,
                        borderRadius: BorderRadius.circular(10),
                        color: informacoesConta.isMasculino ? Colors.red[100] : Colors.blue[100],
                        child: InkWell(
                          onTap: () {
                            informacoesConta.changeSex(false);
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Feminino"),
                              ),
                              SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Container(
                                    child: Image.asset(
                                      "images/leaf.png",
                                      height: 140,
                                      width: 140,
                                    ),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Provider.of<InformacoesConta>(context, listen: false).changeNamePerson(newName: _controllerName.text);
                  Navigator.pop(context);
                },
                child: Icon(Icons.change_circle))
          ],
        ),
      ),
    );
  }
}
