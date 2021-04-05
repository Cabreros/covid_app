class Summary {
  var activeCases;
  var activeCasesChanges;
  var activeVaccine;
  var cases;
  var culActiveVaccine;
  var culCases;
  var culVaccine;
  var culDeaths;
  var culDVaccine;
  var culRecovered;
  var culTesting;
  var cVaccine;
  var date;
  var deaths;
  var dVaccine;
  var province;
  var recovered;
  var testing;
  Summary({
    this.activeCases,
    this.activeCasesChanges,
    this.activeVaccine,
    this.cases,
    this.culActiveVaccine,
    this.culCases,
    this.culVaccine,
    this.culDeaths,
    this.culDVaccine,
    this.culRecovered,
    this.culTesting,
    this.cVaccine,
    this.date,
    this.deaths,
    this.dVaccine,
    this.province,
    this.recovered,
    this.testing,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      activeCases: json['active_cases'],
      activeCasesChanges: json['active_cases_change'],
      activeVaccine: json['avaccine'],
      cases: json['cases'],
      culActiveVaccine: json['cumulative_avaccine'],
      culCases: json['cumulative_cases'],
      culVaccine: json['cumulative_cvaccine'],
      culDeaths: json['cumulative_deaths'],
      culDVaccine: json['cumulative_dvaccine'],
      culRecovered: json['cumulative_recovered'],
      culTesting: json['cumulative_testing'],
      cVaccine: json['cvaccine'],
      date: json['date'],
      deaths: json['deaths'],
      dVaccine: json['dvaccine'],
      province: json['province'],
      recovered: json['recovered'],
      testing: json['testing'],
    );
  }
}
