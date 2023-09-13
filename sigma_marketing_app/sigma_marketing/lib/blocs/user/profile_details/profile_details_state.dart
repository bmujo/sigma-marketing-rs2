part of '../../../../../blocs/user/profile_details/profile_details_bloc.dart';

abstract class ProfileDetailsState extends Equatable {
  const ProfileDetailsState();
}

class ProfileInitial extends ProfileDetailsState {
  @override
  List<Object> get props => [];
}

class ProfileLoading extends ProfileDetailsState {
  @override
  List<Object> get props => [];
}

class ProfileLoaded extends ProfileDetailsState {
  final ProfileDetails profileDetails;

  ProfileLoaded({required this.profileDetails});

  @override
  List<Object> get props => [profileDetails];
}

class ProfileError extends ProfileDetailsState {
  final String message;

  ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
