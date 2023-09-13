import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sigma_marketing/data/models/response/campaign/achievement_point.dart';

import '../../../data/models/request/achievement/achievement_submit.dart';
import '../../../data/repositories/repository_impl.dart';

part 'achievement_event.dart';
part 'achievement_state.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  final RepositoryImpl _repository = RepositoryImpl();

  AchievementBloc() : super(AchievementInitial()) {
    on<GetAchievementEvent>(
      _onGetAchievementEvent,
    );

    on<SubmitReviewEvent>(
      _onSubmitReviewEvent,
    );

    on<SubmitRevisionEvent>(
      _onSubmitRevisionEvent,
    );

    on<SubmitCompleteEvent>(
      _onSubmitCompleteEvent,
    );
  }

  Future<void> _onGetAchievementEvent(
    GetAchievementEvent event,
    Emitter<AchievementState> emit,
  ) async {
    try {
      final achievement = await _repository.getAchievementById(event.id);
      emit(AchievementLoaded(achievementPoint: achievement));
    } catch (error) {
      emit(AchievementError(message: error.toString()));
    }
  }

  Future<void> _onSubmitReviewEvent(
    SubmitReviewEvent event,
    Emitter<AchievementState> emit,
  ) async {
    try {
      final achievement = await _repository.submitReview(AchievementSubmit(
        id: event.id,
        comment: event.comment,
      ));
      emit(AchievementLoaded(achievementPoint: achievement));
    } catch (error) {
      emit(AchievementError(message: error.toString()));
    }
  }

  Future<void> _onSubmitRevisionEvent(
    SubmitRevisionEvent event,
    Emitter<AchievementState> emit,
  ) async {
    try {
      final achievement = await _repository.submitRevision(AchievementSubmit(
        id: event.id,
        comment: event.comment,
      ));
      emit(AchievementLoaded(achievementPoint: achievement));
    } catch (error) {
      emit(AchievementError(message: error.toString()));
    }
  }

  Future<void> _onSubmitCompleteEvent(
    SubmitCompleteEvent event,
    Emitter<AchievementState> emit,
  ) async {
    try {
      final achievement = await _repository.completeAchievement(event.id);
      emit(AchievementLoaded(achievementPoint: achievement));
    } catch (error) {
      emit(AchievementError(message: error.toString()));
    }
  }
}
