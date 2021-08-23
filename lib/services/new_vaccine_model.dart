class NewVaccine {
  int iId;
  String reportDate;
  int previousDayTotalDosesAdministered;
  int previousDayAtLeastOne;
  int previousDayFullyVaccinated;
  int totalDosesAdministered;
  String totalIndividualsAtLeastOne;
  String totalDosesInFullyVaccinatedIndividuals;
  String totalIndividualsFullyVaccinated;
  double rank;

  NewVaccine(
      {this.iId,
      this.reportDate,
      this.previousDayTotalDosesAdministered,
      this.previousDayAtLeastOne,
      this.previousDayFullyVaccinated,
      this.totalDosesAdministered,
      this.totalIndividualsAtLeastOne,
      this.totalDosesInFullyVaccinatedIndividuals,
      this.totalIndividualsFullyVaccinated,
      this.rank});

  NewVaccine.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    reportDate = json['report_date'];
    previousDayTotalDosesAdministered =
        json['previous_day_total_doses_administered'];
    previousDayAtLeastOne = json['previous_day_at_least_one'];
    previousDayFullyVaccinated = json['previous_day_fully_vaccinated'];
    totalDosesAdministered = json['total_doses_administered'];
    totalIndividualsAtLeastOne = json['total_individuals_at_least_one'];
    totalDosesInFullyVaccinatedIndividuals =
        json['total_doses_in_fully_vaccinated_individuals'];
    totalIndividualsFullyVaccinated =
        json['total_individuals_fully_vaccinated'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['report_date'] = this.reportDate;
    data['previous_day_total_doses_administered'] =
        this.previousDayTotalDosesAdministered;
    data['previous_day_at_least_one'] = this.previousDayAtLeastOne;
    data['previous_day_fully_vaccinated'] = this.previousDayFullyVaccinated;
    data['total_doses_administered'] = this.totalDosesAdministered;
    data['total_individuals_at_least_one'] = this.totalIndividualsAtLeastOne;
    data['total_doses_in_fully_vaccinated_individuals'] =
        this.totalDosesInFullyVaccinatedIndividuals;
    data['total_individuals_fully_vaccinated'] =
        this.totalIndividualsFullyVaccinated;
    data['rank'] = this.rank;
    return data;
  }
}
