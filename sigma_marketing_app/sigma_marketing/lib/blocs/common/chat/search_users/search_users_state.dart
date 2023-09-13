part of '../../../../../blocs/common/chat/search_users/search_users_bloc.dart';

abstract class SearchUsersState extends Equatable {
  const SearchUsersState();
}

class SearchUsersInitial extends SearchUsersState {
  @override
  List<Object> get props => [];
}

class SearchUsersLoading extends SearchUsersState {
  @override
  List<Object> get props => [];
}

class SearchUsersLoaded extends SearchUsersState {
  final List<SearchUser> users;

  SearchUsersLoaded({required this.users});

  @override
  List<Object> get props => [users];
}

class SearchUsersError extends SearchUsersState {
  final String message;

  SearchUsersError({required this.message});

  @override
  List<Object> get props => [message];
}

class InviteUsers extends SearchUsersState {
  @override
  List<Object> get props => [];
}

class InviteUsersError extends SearchUsersState {
  final String message;

  InviteUsersError({required this.message});

  @override
  List<Object> get props => [message];
}

class InviteUsersDone extends SearchUsersState {
  final isInvited;

  InviteUsersDone({required this.isInvited});

  @override
  List<Object> get props => [isInvited];
}
