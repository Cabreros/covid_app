class Vaccine {
  final int avaccine;
  final int cumulativeAvaccine;
  var dateVaccineAdministered;
  var province;

  Vaccine({
    this.avaccine,
    this.cumulativeAvaccine,
    this.dateVaccineAdministered,
    this.province,
  });

  factory Vaccine.fromJson(Map<dynamic, dynamic> json) {
    return Vaccine(
        avaccine: json['avaccine'],
        cumulativeAvaccine: json['cumulative_avaccine'],
        dateVaccineAdministered: json['date_vaccine_administered'],
        province: json['province']);
  }
}
