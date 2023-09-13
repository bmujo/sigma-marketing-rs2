part of 'achievement_bloc.dart';

abstract class AchievementEvent extends Equatable {
  const AchievementEvent();
}

class GetAchievementEvent extends AchievementEvent {
  final int id;

  const GetAchievementEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class SubmitReviewEvent extends AchievementEvent {
  final int id;
  final String comment;

  const SubmitReviewEvent({required this.id, required this.comment});

  @override
  List<Object> get props => [id, comment];
}

class SubmitRevisionEvent extends AchievementEvent {
  final int id;
  final String comment;

  const SubmitRevisionEvent({required this.id, required this.comment});

  @override
  List<Object> get props => [id, comment];
}

class SubmitCompleteEvent extends AchievementEvent {
  final int id;

  const SubmitCompleteEvent({required this.id});

  @override
  List<Object> get props => [id];
}
