import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/response/campaign/my_campaigns.dart';
import '../../../../data/repositories/repository_impl.dart';

part 'my_campaigns_event.dart';
part 'my_campaigns_state.dart';

class MyCampaignsBloc extends Bloc<MyCampaignsEvent, MyCampaignsState> {
  final RepositoryImpl _repository = RepositoryImpl();

  MyCampaignsBloc() : super(MyCampaignsInitial()) {
    on<GetMyCampaignsEvent>(
      _onGetMyCampaignsEvent,
    );
  }

  @override
  MyCampaignsState get initialState => MyCampaignsInitial();

  Future<void> _onGetMyCampaignsEvent(
      GetMyCampaignsEvent event,
      Emitter<MyCampaignsState> emit,
      ) async {
    try {
      final myCampaigns = await _repository.getMyCampaigns();
      emit(MyCampaignsLoaded(myCampaigns: myCampaigns));
    } catch (error) {
      emit(MyCampaignsError(message: error.toString()));
    }
  }

  @override
  Stream<MyCampaignsState> mapEventToState(GetMyCampaignsEvent event) async* {
    if (event is GetMyCampaignsEvent) {
      yield MyCampaignsInitial();
      try {
        final myCampaigns = await _repository.getMyCampaigns();
        yield MyCampaignsLoaded(myCampaigns: myCampaigns);
      } catch (error) {
        yield MyCampaignsError(message: error.toString());
      }
    }
  }
}
