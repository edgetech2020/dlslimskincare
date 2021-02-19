class SearchModel {
  final int id;
  final String name;
  final String image;
  final String price;
  final String rating;
  final String deskripsi;

  SearchModel(
      {this.id,
      this.name,
      this.image,
      this.price,
      this.rating,
      this.deskripsi});

  factory SearchModel.json(Map<String, dynamic> obj) {
    return SearchModel(
        id: obj['id'],
        name: obj['name'],
        price: obj['price'],
        image: obj['image'],
        rating: obj['']);
  }
}
