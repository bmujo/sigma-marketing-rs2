import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/response/profile/profile_details.dart';
import '../../../data/repositories/repository_impl.dart';

part 'profile_details_event.dart';
part 'profile_details_state.dart';

class ProfileDetailsBloc extends Bloc<ProfileDetailsEvent, ProfileDetailsState> {
  final RepositoryImpl _repository = RepositoryImpl();

  ProfileDetailsBloc() : super(ProfileInitial()) {
    on<GetProfileEvent>(
      _onGetProfileEvent,
    );
  }

  @override
  ProfileDetailsState get initialState => ProfileInitial();

  Future<void> _onGetProfileEvent(
      GetProfileEvent event,
      Emitter<ProfileDetailsState> emit,
      ) async {
    try {
      final profileDetails = await _repository.getProfileDetails();
      emit(ProfileLoaded(profileDetails: profileDetails));
    } catch (error) {
      emit(ProfileError(message: error.toString()));
    }
  }
}
