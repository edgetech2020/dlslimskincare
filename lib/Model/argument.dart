class BuyNowArg {
  final int id;
  final String name;
  final String foto;
  final int harga;

  BuyNowArg(this.id, this.name, this.foto, this.harga);
}

class DetailProductArgument {
  final int id;
  final String name;
  final String foto;
  final String harga;
  final double rating;
  final String deskripsi;

  DetailProductArgument(
      this.id, this.name, this.foto, this.harga, this.rating, this.deskripsi);
}

class NewsArguments {
  final String title;
  final String deskripsi;
  final String foto;

  NewsArguments(this.title, this.deskripsi, this.foto);
}
