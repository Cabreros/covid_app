import 'package:current_cases_app/models/new_vaccine_model.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:flutter/cupertino.dart';

class VaccineProvider extends ChangeNotifier {
  NewVaccine newvax = NewVaccine();
  bool loading = false;

  Future getNewVaccineData() async {
    loading = true;
    newvax = await OntarioService().getVaccinationData();
    loading = false;

    notifyListeners();
  }

  bool get isLoaded {
    // that is a very simple check
    return newvax == null;
  }

  // Future<NewVaccine> returnNewVax() async {
  //   await getNewVaccineData();
  //   return newvax;
  // }
}

class VaccineGroupProvider extends ChangeNotifier {
  Map vaxGroup = Map();
  bool loading = false;

  Future getNewVaccineData() async {
    loading = true;
    vaxGroup = await OntarioService().getVaccineGroupData();
    loading = false;

    notifyListeners();
  }

  bool get isLoaded {
    // that is a very simple check
    return vaxGroup == null;
  }
}
