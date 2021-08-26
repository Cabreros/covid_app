class HealthRegion {
  var cases;
  var culCases;
  var culDeaths;
  var date;
  var deaths;
  var healthRegion;
  var province;
  HealthRegion({
    this.cases,
    this.culCases,
    this.culDeaths,
    this.date,
    this.deaths,
    this.healthRegion,
    this.province,
  });

  factory HealthRegion.fromJson(Map<String, dynamic> json) {
    return HealthRegion(
        cases: json['cases'],
        culCases: json['cumulative_cases'],
        culDeaths: json['cumulative_deaths'],
        date: json['date'],
        deaths: json['deaths'],
        healthRegion: json['health_region'],
        province: json['province']);
  }
}
