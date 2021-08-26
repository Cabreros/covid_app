import 'package:current_cases_app/models/new_vaccine_model.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:flutter/cupertino.dart';

class VaccineProvider extends ChangeNotifier {
  NewVaccine newvax = NewVaccine();
  bool loading = false;

  getNewVaccineData() async {
    loading = true;
    newvax = await OntarioService().getVaccinationData();
    loading = false;

    notifyListeners();
  }
}