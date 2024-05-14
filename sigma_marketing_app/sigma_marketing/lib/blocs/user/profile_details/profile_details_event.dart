part of '../../../../../blocs/user/profile_details/profile_details_bloc.dart';

abstract class ProfileDetailsEvent extends Equatable {
  const ProfileDetailsEvent();
}

class GetProfileEvent extends ProfileDetailsEvent {

  const GetProfileEvent();

  @override
  List<Object> get props => [];
}