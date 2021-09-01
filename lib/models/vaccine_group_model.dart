class VaccineGroup {
  int iId;
  String date;
  String agegroup;
  int atLeastOneDoseCumulative;
  int secondDoseCumulative;
  int totalPopulation;
  double percentAtLeastOneDose;
  double percentFullyVaccinated;

  VaccineGroup(
      {this.iId,
      this.date,
      this.agegroup,
      this.atLeastOneDoseCumulative,
      this.secondDoseCumulative,
      this.totalPopulation,
      this.percentAtLeastOneDose,
      this.percentFullyVaccinated});

  VaccineGroup.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    date = json['Date'];
    agegroup = json['Agegroup'];
    atLeastOneDoseCumulative = json['At least one dose_cumulative'];
    secondDoseCumulative = json['Second_dose_cumulative'];
    totalPopulation = json['Total population'];
    percentAtLeastOneDose = json['Percent_at_least_one_dose'];
    percentFullyVaccinated = json['Percent_fully_vaccinated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['Date'] = this.date;
    data['Agegroup'] = this.agegroup;
    data['At least one dose_cumulative'] = this.atLeastOneDoseCumulative;
    data['Second_dose_cumulative'] = this.secondDoseCumulative;
    data['Total population'] = this.totalPopulation;
    data['Percent_at_least_one_dose'] = this.percentAtLeastOneDose;
    data['Percent_fully_vaccinated'] = this.percentFullyVaccinated;
    return data;
  }
}
