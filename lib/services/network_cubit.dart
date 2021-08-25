import 'package:current_cases_app/services/case_model.dart';
import 'package:current_cases_app/services/ontario_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'new_vaccine_model.dart';

abstract class NetworkEvent {}

class LoadNetworkEvent extends NetworkEvent {}

class PullToRefreshEvent extends NetworkEvent {}

class GetCaseEvent extends NetworkEvent {
  CaseData data;
  GetCaseEvent({this.data});
}

class GetVaccineEvent extends NetworkEvent {
  NewVaccine data;
  GetVaccineEvent({this.data});
}

abstract class NetworkState {}

class LoadingNetworkState extends NetworkState {}

class LoadedNetworkState extends NetworkState {
  dynamic apiResponse;
  LoadedNetworkState({this.apiResponse});
}

class FailedNetworkEvent extends NetworkState {
  Error error;
  FailedNetworkEvent({this.error});
}

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final _dataService = OntarioService();

  NetworkBloc() : super(LoadingNetworkState());

  @override
  Stream<NetworkState> mapEventToState(NetworkEvent event) async* {
    if (event is LoadNetworkEvent) {
      yield LoadingNetworkState();
    }

    try {
      if (event is GetCaseEvent) {
        final data = await _dataService.getCaseData();
        yield LoadedNetworkState(apiResponse: data);
      } else if (event is GetVaccineEvent) {
        final data = await _dataService.getVaccinationData();
        yield LoadedNetworkState(apiResponse: data);
      }
    } catch (e) {
      yield FailedNetworkEvent(error: e);
    }
  }
}
