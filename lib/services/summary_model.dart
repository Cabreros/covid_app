import 'dart:convert';

class Summary {
  final int activeCases;
  final int activeCasesChanges;
  final double activeVaccine;
  final int cases;
  final double culActiveVaccine;
  final int culCases;
  final double culVaccine;
  final double culDeaths;
  final double culDVaccine;
  final double culRecovered;
  final double culTesting;
  final double cVaccine;
  final String date;
  final double deaths;
  final double dVaccine;
  final String province;
  final double recovered;
  final double testing;
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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'activeCases': activeCases,
  //     'activeCasesChanges': activeCasesChanges,
  //     'activeVaccine': activeVaccine,
  //     'cases': cases,
  //     // 'culActiveVaccine': culActiveVaccine,
  //     // 'culCases': culCases,
  //     // 'culVaccinel': culVaccinel,
  //     // 'culDeaths': culDeaths,
  //     // 'culDVaccine': culDVaccine,
  //     // 'culRecovered': culRecovered,
  //     // 'culTesting': culTesting,
  //     // 'cVaccine': cVaccine,
  //     // 'date': date,
  //     // 'deaths': deaths,
  //     // 'dVaccine': dVaccine,
  //     // 'province': province,
  //     // 'recovered': recovered,
  //     // 'testing': testing,
  //   };
  // }

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      activeCases: json['activeCases'],
      activeCasesChanges: json['activeCasesChanges'],
      activeVaccine: json['activeVaccine'],
      cases: json['cases'],
      culActiveVaccine: json['culActiveVaccine'],
      culCases: json['culCases'],
      culVaccine: json['culVaccinel'],
      culDeaths: json['culDeaths'],
      culDVaccine: json['culDVaccine'],
      culRecovered: json['culRecovered'],
      culTesting: json['culTesting'],
      cVaccine: json['cVaccine'],
      date: json['date'],
      deaths: json['deaths'],
      dVaccine: json['dVaccine'],
      province: json['province'],
      recovered: json['recovered'],
      testing: json['testing'],
    );
  }
}
