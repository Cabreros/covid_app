import 'package:current_cases_app/models/case_model.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:flutter/cupertino.dart';

class CaseProvider extends ChangeNotifier {
  CaseData caseData = CaseData();
  bool loading = false;

  getCaseData() async {
    loading = true;
    caseData = await OntarioService().getCaseData();
    loading = false;

    notifyListeners();
  }

  bool get isLoaded {
    // that is a very simple check
    return caseData == null;
  }
}
