class ModelVerif {
  final bool ok;
  final String pesan;
  ModelVerif({this.ok, this.pesan});

  factory ModelVerif.createJson(Map<String, dynamic> obj) {
    return ModelVerif(ok: obj['ok'], pesan: obj['msg']);
  }
}
