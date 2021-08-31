class Hospital {
  int iId;
  String date;
  int icuUnvac;
  int icuPartialVac;
  int icuFullVac;
  int hospitalnonicuUnvac;
  int hospitalnonicuPartialVac;
  int hospitalnonicuFullVac;

  Hospital(
      {this.iId,
      this.date,
      this.icuUnvac,
      this.icuPartialVac,
      this.icuFullVac,
      this.hospitalnonicuUnvac,
      this.hospitalnonicuPartialVac,
      this.hospitalnonicuFullVac});

  Hospital.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    date = json['date'];
    icuUnvac = json['icu_unvac'];
    icuPartialVac = json['icu_partial_vac'];
    icuFullVac = json['icu_full_vac'];
    hospitalnonicuUnvac = json['hospitalnonicu_unvac'];
    hospitalnonicuPartialVac = json['hospitalnonicu_partial_vac'];
    hospitalnonicuFullVac = json['hospitalnonicu_full_vac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['date'] = this.date;
    data['icu_unvac'] = this.icuUnvac;
    data['icu_partial_vac'] = this.icuPartialVac;
    data['icu_full_vac'] = this.icuFullVac;
    data['hospitalnonicu_unvac'] = this.hospitalnonicuUnvac;
    data['hospitalnonicu_partial_vac'] = this.hospitalnonicuPartialVac;
    data['hospitalnonicu_full_vac'] = this.hospitalnonicuFullVac;
    return data;
  }
}
