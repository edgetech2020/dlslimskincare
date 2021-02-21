class ModelProfile {
  final String potoDepan;
  final String avatar;
  final String fullname;
  final String email;
  final String potoKiri;
  final String potoKanan;
  final String gender;
  final String skinType;
  final String skinProb;
  final String otherSkinProb;
  final String oldProd;
  ModelProfile(
      {this.potoDepan,
      this.avatar,
      this.fullname,
      this.email,
      this.potoKiri,
      this.potoKanan,
      this.gender,
      this.skinType,
      this.skinProb,
      this.otherSkinProb,
      this.oldProd});

  factory ModelProfile.jsonObject(Map<String, dynamic> obj) {
    return ModelProfile(
      avatar: obj['datas']['avatar_url'],
      fullname: obj['datas']['username'],
      email: obj['datas']['email'],
      gender: obj['datas']['_gender'],
      skinType: obj['datas']['skin_type'],
      skinProb: obj['datas']['skin_problem'],
      otherSkinProb: obj['datas']['other_skin_problem'],
      oldProd: obj['datas']['prev_product'],
      potoDepan: obj['datas']['capture_filename']['front'],
      potoKanan: obj['datas']['capture_filename']['right'],
      potoKiri: obj['datas']['capture_filename']['left'],
    );
  }
}
