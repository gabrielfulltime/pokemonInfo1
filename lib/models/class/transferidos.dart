class Transfers {
  final String? id;
  final String nomeTransferidos;
  final int idTransferidos;


  @override
  String toString() {
    return 'Transferidos{id: $id, nomeTransferidos: $nomeTransferidos, idTransferidos: $idTransferidos}';
  }

  Transfers.fromJson(Map<String, dynamic> json)
      :
      id = json["id"],
        nomeTransferidos = json["contact"]["name"],
        idTransferidos = json["contact"]["accountNumber"];

  Transfers(this.nomeTransferidos, this.idTransferidos, {this.id});
}