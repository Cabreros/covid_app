import 'package:current_cases_app/services/new_vaccine_model.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VaccineCubit extends Cubit<NewVaccine> {
  final _dataService = OntarioService();

  VaccineCubit() : super(NewVaccine());

  void getVaccineData() async => emit(await _dataService.getVaccinationData());
}
