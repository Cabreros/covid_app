import 'package:current_cases_app/models/new_vaccine_model.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VaccineCubit extends Cubit<NewVaccine> {
  final _dataService = OntarioService();

  VaccineCubit() : super(NewVaccine());

  void getVaccineData() async => emit(await _dataService.getVaccinationData());
}

abstract class VaccineEvent {}

class LoadVaccineEvent extends VaccineEvent {}

class PullToRefreshEvent extends VaccineEvent {}

abstract class VaccineState {}

class LoadingVaccineState extends VaccineState {}

class LoadedVaccineState extends VaccineState {
  NewVaccine vaccine;
  LoadedVaccineState({this.vaccine});
}

class FailedVaccineEvent extends VaccineState {
  Error error;
  FailedVaccineEvent({this.error});
}

class VaccineBloc extends Bloc<VaccineEvent, VaccineState> {
  final _dataService = OntarioService();

  VaccineBloc() : super(LoadingVaccineState());

  @override
  Stream<VaccineState> mapEventToState(VaccineEvent event) async* {
    if (event is LoadVaccineEvent) {
      yield LoadingVaccineState();
    }

    try {
      final data = await _dataService.getVaccinationData();
      yield LoadedVaccineState(vaccine: data);
    } catch (e) {
      yield FailedVaccineEvent(error: e);
    }
  }
}
