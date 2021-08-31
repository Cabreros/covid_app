class Status {
  int iId;
  String reportedDate;
  Null confirmedNegative;
  Null presumptiveNegative;
  Null presumptivePositive;
  dynamic confirmedPositive;
  dynamic resolved;
  dynamic deaths;
  dynamic totalCases;
  dynamic totalPatientsApprovedForTestingAsOfReportingDate;
  dynamic totalTestsCompletedInTheLastDay;
  dynamic percentPositiveTestsInLastDay;
  dynamic underInvestigation;
  dynamic numberOfPatientsHospitalizedWithCOVID19;
  dynamic numberOfPatientsInICUDueToCOVID19;
  dynamic numberOfPatientsInICUTestingPositiveForCOVID19;
  dynamic numberOfPatientsInICUTestingNegativeForCOVID19;
  dynamic numberOfPatientsInICUOnAVentilatorDueToCOVID19;
  dynamic numOfPatientsInICUOnAVentilatorTestingPositive;
  dynamic numOfPatientsInICUOnAVentilatorTestingNegative;
  dynamic totalPositiveLTCResidentCases;
  dynamic totalPositiveLTCHCWCases;
  dynamic totalLTCResidentDeaths;
  dynamic totalLTCHCWDeaths;
  dynamic totalLineageB117Alpha;
  dynamic totalLineageB1351Beta;
  dynamic totalLineageP1Gamma;
  dynamic totalLineageB16172Delta;

  Status(
      {this.iId,
      this.reportedDate,
      this.confirmedNegative,
      this.presumptiveNegative,
      this.presumptivePositive,
      this.confirmedPositive,
      this.resolved,
      this.deaths,
      this.totalCases,
      this.totalPatientsApprovedForTestingAsOfReportingDate,
      this.totalTestsCompletedInTheLastDay,
      this.percentPositiveTestsInLastDay,
      this.underInvestigation,
      this.numberOfPatientsHospitalizedWithCOVID19,
      this.numberOfPatientsInICUDueToCOVID19,
      this.numberOfPatientsInICUTestingPositiveForCOVID19,
      this.numberOfPatientsInICUTestingNegativeForCOVID19,
      this.numberOfPatientsInICUOnAVentilatorDueToCOVID19,
      this.numOfPatientsInICUOnAVentilatorTestingPositive,
      this.numOfPatientsInICUOnAVentilatorTestingNegative,
      this.totalPositiveLTCResidentCases,
      this.totalPositiveLTCHCWCases,
      this.totalLTCResidentDeaths,
      this.totalLTCHCWDeaths,
      this.totalLineageB117Alpha,
      this.totalLineageB1351Beta,
      this.totalLineageP1Gamma,
      this.totalLineageB16172Delta});

  Status.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    reportedDate = json['Reported Date'];
    confirmedNegative = json['Confirmed Negative'];
    presumptiveNegative = json['Presumptive Negative'];
    presumptivePositive = json['Presumptive Positive'];
    confirmedPositive = json['Confirmed Positive'];
    resolved = json['Resolved'];
    deaths = json['Deaths'];
    totalCases = json['Total Cases'];
    totalPatientsApprovedForTestingAsOfReportingDate =
        json['Total patients approved for testing as of Reporting Date'];
    totalTestsCompletedInTheLastDay =
        json['Total tests completed in the last day'];
    percentPositiveTestsInLastDay = json['Percent positive tests in last day'];
    underInvestigation = json['Under Investigation'];
    numberOfPatientsHospitalizedWithCOVID19 =
        json['Number of patients hospitalized with COVID-19'];
    numberOfPatientsInICUDueToCOVID19 =
        json['Number of patients in ICU due to COVID-19'];
    numberOfPatientsInICUTestingPositiveForCOVID19 =
        json['Number of patients in ICU, testing positive for COVID-19'];
    numberOfPatientsInICUTestingNegativeForCOVID19 =
        json['Number of patients in ICU, testing negative for COVID-19'];
    numberOfPatientsInICUOnAVentilatorDueToCOVID19 =
        json['Number of patients in ICU on a ventilator due to COVID-19'];
    numOfPatientsInICUOnAVentilatorTestingPositive =
        json['Num. of patients in ICU on a ventilator testing positive'];
    numOfPatientsInICUOnAVentilatorTestingNegative =
        json['Num. of patients in ICU on a ventilator testing negative'];
    totalPositiveLTCResidentCases = json['Total Positive LTC Resident Cases'];
    totalPositiveLTCHCWCases = json['Total Positive LTC HCW Cases'];
    totalLTCResidentDeaths = json['Total LTC Resident Deaths'];
    totalLTCHCWDeaths = json['Total LTC HCW Deaths'];
    totalLineageB117Alpha = json['Total_Lineage_B.1.1.7_Alpha'];
    totalLineageB1351Beta = json['Total_Lineage_B.1.351_Beta'];
    totalLineageP1Gamma = json['Total_Lineage_P.1_Gamma'];
    totalLineageB16172Delta = json['Total_Lineage_B.1.617.2_Delta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['Reported Date'] = this.reportedDate;
    data['Confirmed Negative'] = this.confirmedNegative;
    data['Presumptive Negative'] = this.presumptiveNegative;
    data['Presumptive Positive'] = this.presumptivePositive;
    data['Confirmed Positive'] = this.confirmedPositive;
    data['Resolved'] = this.resolved;
    data['Deaths'] = this.deaths;
    data['Total Cases'] = this.totalCases;
    data['Total patients approved for testing as of Reporting Date'] =
        this.totalPatientsApprovedForTestingAsOfReportingDate;
    data['Total tests completed in the last day'] =
        this.totalTestsCompletedInTheLastDay;
    data['Percent positive tests in last day'] =
        this.percentPositiveTestsInLastDay;
    data['Under Investigation'] = this.underInvestigation;
    data['Number of patients hospitalized with COVID-19'] =
        this.numberOfPatientsHospitalizedWithCOVID19;
    data['Number of patients in ICU due to COVID-19'] =
        this.numberOfPatientsInICUDueToCOVID19;
    data['Number of patients in ICU, testing positive for COVID-19'] =
        this.numberOfPatientsInICUTestingPositiveForCOVID19;
    data['Number of patients in ICU, testing negative for COVID-19'] =
        this.numberOfPatientsInICUTestingNegativeForCOVID19;
    data['Number of patients in ICU on a ventilator due to COVID-19'] =
        this.numberOfPatientsInICUOnAVentilatorDueToCOVID19;
    data['Num. of patients in ICU on a ventilator testing positive'] =
        this.numOfPatientsInICUOnAVentilatorTestingPositive;
    data['Num. of patients in ICU on a ventilator testing negative'] =
        this.numOfPatientsInICUOnAVentilatorTestingNegative;
    data['Total Positive LTC Resident Cases'] =
        this.totalPositiveLTCResidentCases;
    data['Total Positive LTC HCW Cases'] = this.totalPositiveLTCHCWCases;
    data['Total LTC Resident Deaths'] = this.totalLTCResidentDeaths;
    data['Total LTC HCW Deaths'] = this.totalLTCHCWDeaths;
    data['Total_Lineage_B.1.1.7_Alpha'] = this.totalLineageB117Alpha;
    data['Total_Lineage_B.1.351_Beta'] = this.totalLineageB1351Beta;
    data['Total_Lineage_P.1_Gamma'] = this.totalLineageP1Gamma;
    data['Total_Lineage_B.1.617.2_Delta'] = this.totalLineageB16172Delta;
    return data;
  }
}
