class CaseData {
  int iId;
  String date;
  String algomaDistrict;
  String brantCounty;
  String chathamKent;
  String durhamRegion;
  String easternOntario;
  String greyBruce;
  String haldimandNorfolk;
  String haliburtonKawarthaPineRidge;
  String haltonRegion;
  String cityOfHamilton;
  String hastingsPrinceEdward;
  String huronPerth;
  String kFLA;
  String lambtonCounty;
  String leedsGrenvilleLanark;
  String middlesexLondon;
  String niagaraRegion;
  String northBayParrySoundDistrict;
  String northwestern;
  String cityOfOttawa;
  String peelRegion;
  String peterboroughCountyCity;
  String porcupine;
  String waterlooRegion;
  String renfrewCountyAndDistrict;
  String simcoeMuskokaDistrict;
  String southwestern;
  String sudburyAndDistrict;
  String thunderBayDistrict;
  String timiskaming;
  String toronto;
  String wellingtonDufferinGuelph;
  String windsorEssexCounty;
  String yorkRegion;
  int total;
  double rank;

  CaseData(
      {this.iId,
      this.date,
      this.algomaDistrict,
      this.brantCounty,
      this.chathamKent,
      this.durhamRegion,
      this.easternOntario,
      this.greyBruce,
      this.haldimandNorfolk,
      this.haliburtonKawarthaPineRidge,
      this.haltonRegion,
      this.cityOfHamilton,
      this.hastingsPrinceEdward,
      this.huronPerth,
      this.kFLA,
      this.lambtonCounty,
      this.leedsGrenvilleLanark,
      this.middlesexLondon,
      this.niagaraRegion,
      this.northBayParrySoundDistrict,
      this.northwestern,
      this.cityOfOttawa,
      this.peelRegion,
      this.peterboroughCountyCity,
      this.porcupine,
      this.waterlooRegion,
      this.renfrewCountyAndDistrict,
      this.simcoeMuskokaDistrict,
      this.southwestern,
      this.sudburyAndDistrict,
      this.thunderBayDistrict,
      this.timiskaming,
      this.toronto,
      this.wellingtonDufferinGuelph,
      this.windsorEssexCounty,
      this.yorkRegion,
      this.total,
      this.rank});

  CaseData.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    date = json['Date'];
    algomaDistrict = json['Algoma_District'];
    brantCounty = json['Brant_County'];
    chathamKent = json['Chatham_Kent'];
    durhamRegion = json['Durham_Region'];
    easternOntario = json['Eastern_Ontario'];
    greyBruce = json['Grey_Bruce'];
    haldimandNorfolk = json['Haldimand_Norfolk'];
    haliburtonKawarthaPineRidge = json['Haliburton_Kawartha_Pine_Ridge'];
    haltonRegion = json['Halton_Region'];
    cityOfHamilton = json['City_of_Hamilton'];
    hastingsPrinceEdward = json['Hastings_Prince_Edward'];
    huronPerth = json['Huron_Perth'];
    kFLA = json['KFLA'];
    lambtonCounty = json['Lambton_County'];
    leedsGrenvilleLanark = json['Leeds_Grenville_Lanark'];
    middlesexLondon = json['Middlesex_London'];
    niagaraRegion = json['Niagara_Region'];
    northBayParrySoundDistrict = json['North_Bay_Parry_Sound_District'];
    northwestern = json['Northwestern'];
    cityOfOttawa = json['City_of_Ottawa'];
    peelRegion = json['Peel_Region'];
    peterboroughCountyCity = json['Peterborough_County_City'];
    porcupine = json['Porcupine'];
    waterlooRegion = json['Waterloo_Region'];
    renfrewCountyAndDistrict = json['Renfrew_County_and_District'];
    simcoeMuskokaDistrict = json['Simcoe_Muskoka_District'];
    southwestern = json['Southwestern'];
    sudburyAndDistrict = json['Sudbury_and_District'];
    thunderBayDistrict = json['Thunder_Bay_District'];
    timiskaming = json['Timiskaming'];
    toronto = json['Toronto'];
    wellingtonDufferinGuelph = json['Wellington_Dufferin_Guelph'];
    windsorEssexCounty = json['Windsor_Essex_County'];
    yorkRegion = json['York_Region'];
    total = json['Total'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['Date'] = this.date;
    data['Algoma_District'] = this.algomaDistrict;
    data['Brant_County'] = this.brantCounty;
    data['Chatham_Kent'] = this.chathamKent;
    data['Durham_Region'] = this.durhamRegion;
    data['Eastern_Ontario'] = this.easternOntario;
    data['Grey_Bruce'] = this.greyBruce;
    data['Haldimand_Norfolk'] = this.haldimandNorfolk;
    data['Haliburton_Kawartha_Pine_Ridge'] = this.haliburtonKawarthaPineRidge;
    data['Halton_Region'] = this.haltonRegion;
    data['City_of_Hamilton'] = this.cityOfHamilton;
    data['Hastings_Prince_Edward'] = this.hastingsPrinceEdward;
    data['Huron_Perth'] = this.huronPerth;
    data['KFLA'] = this.kFLA;
    data['Lambton_County'] = this.lambtonCounty;
    data['Leeds_Grenville_Lanark'] = this.leedsGrenvilleLanark;
    data['Middlesex_London'] = this.middlesexLondon;
    data['Niagara_Region'] = this.niagaraRegion;
    data['North_Bay_Parry_Sound_District'] = this.northBayParrySoundDistrict;
    data['Northwestern'] = this.northwestern;
    data['City_of_Ottawa'] = this.cityOfOttawa;
    data['Peel_Region'] = this.peelRegion;
    data['Peterborough_County_City'] = this.peterboroughCountyCity;
    data['Porcupine'] = this.porcupine;
    data['Waterloo_Region'] = this.waterlooRegion;
    data['Renfrew_County_and_District'] = this.renfrewCountyAndDistrict;
    data['Simcoe_Muskoka_District'] = this.simcoeMuskokaDistrict;
    data['Southwestern'] = this.southwestern;
    data['Sudbury_and_District'] = this.sudburyAndDistrict;
    data['Thunder_Bay_District'] = this.thunderBayDistrict;
    data['Timiskaming'] = this.timiskaming;
    data['Toronto'] = this.toronto;
    data['Wellington_Dufferin_Guelph'] = this.wellingtonDufferinGuelph;
    data['Windsor_Essex_County'] = this.windsorEssexCounty;
    data['York_Region'] = this.yorkRegion;
    data['Total'] = this.total;
    data['rank'] = this.rank;
    return data;
  }
}
