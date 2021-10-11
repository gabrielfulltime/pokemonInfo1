import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokebankv2/app_dependencies/app_dependencies.dart';
import 'package:pokebankv2/components/progress.dart';
import 'package:pokebankv2/components/response_dialog.dart';
import 'package:pokebankv2/components/transferencias_dialog.dart';
import 'package:pokebankv2/models/class/transferidos.dart';
import 'package:pokebankv2/services/http/transferidos/transfers_api_web.dart';
import 'package:uuid/uuid.dart';

class NovaTransferencia extends StatefulWidget {
  @override
  _NovaTransferenciaState createState() => _NovaTransferenciaState();
}

class _NovaTransferenciaState extends State<NovaTransferencia> {
  final String _idIdempotence = Uuid().v4();
  TextEditingController _controladorId = TextEditingController();
  TextEditingController _controladorNome = TextEditingController();
  bool _visibilidadeProgress = false;

  @override
  Widget build(BuildContext context) {
    final TransfersWeb _transfersWeb = AppDependencies.of(context)!.transfersWeb;
    return Scaffold(
        appBar: AppBar(
          title: Text('Transactions'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              controller: _controladorNome,
              textCapitalization: TextCapitalization.characters,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                labelText: "Nome do amigo Pokemon ",
                hintText: "Ex: Char char",
              ),
              keyboardType: TextInputType.name,
            ),
            TextField(
              controller: _controladorId,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                labelText: "Numero da sorte do Pokemon",
                hintText: "Ex: 3 -> Ivysaur",
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                child: Text("Confirmar"),
                onPressed: () async {
                  if (_controladorNome.text.length > 0 &&
                      _controladorId.text.length > 0) {
                    final Transfers novaTransferencia = Transfers(
                        _controladorNome.text, int.parse(_controladorId.text),
                        id: _idIdempotence);
                    showDialog(
                        context: context,
                        builder: (contextDialog) => TransferenciasDialog(
                              onConfirm: (password) async {
                                await _saveTransfer(
                                    novaTransferencia, password, context, _transfersWeb);
                              },
                            ));
                  }
                },
              ),
            ),
            Visibility(
              visible: _visibilidadeProgress,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Progress("Enviando..."),
                ),
              ),
            )
          ]),
        ));
  }

  Future<void> _saveTransfer(
      Transfers newTransfer, String password, BuildContext context, TransfersWeb transferWeb) {
    setState(() {
      _visibilidadeProgress = true;
      _controladorNome.text = _controladorNome.text;
      _controladorId.text = _controladorId.text;
    });
    return _savarTransferencia(
            newTransfer, password, context, _idIdempotence, transferWeb)
        .catchError((value) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance
            .setCustomKey("Exception", value.toString());
        FirebaseCrashlytics.instance
            .setCustomKey("http_status", value.statusCode.toString());
        FirebaseCrashlytics.instance
            .setCustomKey("http_body", newTransfer.toString());
        FirebaseCrashlytics.instance.recordError(value, null);
      }

      _exceptionDialog(context,
          message:
              "Não foi possivel contatar o professor Carvalho, transfira mais tarde ");
    }, test: (value) => value is TimeoutException).catchError((value) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance
            .setCustomKey("Exception", value.toString());
        FirebaseCrashlytics.instance
            .setCustomKey("http_status", value.statusCode.toString());
        FirebaseCrashlytics.instance
            .setCustomKey("http_body", newTransfer.toString());
        FirebaseCrashlytics.instance.recordError(value, null);
      }
      _exceptionDialog(context, message: value.message);
    }, test: (value) => value is HttpException).catchError((value) {
      if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
        FirebaseCrashlytics.instance
            .setCustomKey("Exception", value.toString());
        FirebaseCrashlytics.instance
            .setCustomKey("http_body", newTransfer.toString());
        FirebaseCrashlytics.instance.recordError(value, null);
      }
      _exceptionDialog(
        context,
        message:
            "Não foi possivel contatar o professor Carvalho, transfira mais tarde",
      );
    }, test: (e) => e is SocketException).catchError((value) {
      _exceptionDialog(context);
    }, test: (e) => e is Exception).whenComplete(() => setState(() {
              _controladorNome.text = _controladorNome.text;
              _controladorId.text = _controladorId.text;
              _visibilidadeProgress = false;
            }));
  }

  Future<dynamic> _exceptionDialog(BuildContext context,
      {String message = "Erro desconhecido"}) {
    return showDialog(
        context: context,
        builder: (contextDialog) {
          return FailureDialog(
            message,
          );
        });
  }

  Future<void> _savarTransferencia(Transfers novaTransferencia,
      String password, BuildContext context, idIdempotencia, TransfersWeb transfersWeb) async {
    final dynamic response = await transfersWeb
        .save(novaTransferencia, password, idIdempotencia)
        .then((transferencia) => {
              if (transferencia != null)
                {
                  showDialog(
                      context: context,
                      builder: (contextDialog) {
                        return SuccessDialog("Transferido com sucesso");
                      }).then((value) => Navigator.pop(context))
                }
            });
  }
}
