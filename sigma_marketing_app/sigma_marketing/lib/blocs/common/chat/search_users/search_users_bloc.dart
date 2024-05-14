import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/request/invite/invite.dart';
import '../../../../data/models/response/user/search_user.dart';
import '../../../../data/repositories/repository_impl.dart';

part 'search_users_event.dart';
part 'search_users_state.dart';

class SearchUsersBloc extends Bloc<SearchUsersEvent, SearchUsersState> {
  final RepositoryImpl _repository = RepositoryImpl();

  SearchUsersBloc() : super(SearchUsersInitial()) {
    on<GetUsersEvent>(
      _onGetUsersEvent,
    );

    on<InviteUsersEvent>(
      _onInviteUsersEvent,
    );
  }

  Future<void> _onGetUsersEvent(
      GetUsersEvent event,
      Emitter<SearchUsersState> emit,
      ) async {
    try {
      String? queryNullable = event.query;
      if(queryNullable.isEmpty) queryNullable = null;

      final users =
      await _repository.searchUsers(queryNullable);
      emit(SearchUsersLoaded(users: users));
    } catch (error) {
      emit(SearchUsersError(message: error.toString()));
    }
  }

  Future<void> _onInviteUsersEvent(
      InviteUsersEvent event,
      Emitter<SearchUsersState> emit,
      ) async {
    try {
      emit(InviteUsers());
      final isInvited = await _repository.inviteUsers(event.invite);
      emit(InviteUsersDone(isInvited: isInvited));
    } catch (error) {
      emit(InviteUsersError(message: error.toString()));
    }
  }
}
