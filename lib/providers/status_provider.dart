import 'package:current_cases_app/models/status_model.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:flutter/cupertino.dart';

class StatusProvider extends ChangeNotifier {
  Status statusData = Status();
  bool loading = false;

  getStatusData() async {
    loading = true;
    statusData = await OntarioService().getStatusData();
    loading = false;

    notifyListeners();
  }
}
