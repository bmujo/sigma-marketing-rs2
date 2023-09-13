part of '../../../../../blocs/common/chat/search_users/search_users_bloc.dart';

abstract class SearchUsersEvent extends Equatable {
  const SearchUsersEvent();
}

class GetUsersEvent extends SearchUsersEvent {
  final String query;

  const GetUsersEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class InviteUsersEvent extends SearchUsersEvent {
  final Invite invite;

  const InviteUsersEvent({required this.invite});

  @override
  List<Object> get props => [invite];
}
