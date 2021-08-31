import 'package:current_cases_app/models/hospital_model.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:flutter/cupertino.dart';

class HospitalProvider extends ChangeNotifier {
  Hospital hospital = Hospital();
  bool loading = false;

  getHospitalData() async {
    loading = true;
    hospital = await OntarioService().getHospitalData();
    loading = false;

    notifyListeners();
  }
}
