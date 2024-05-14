part of 'achievement_bloc.dart';

abstract class AchievementState extends Equatable {
  const AchievementState();
}

class AchievementInitial extends AchievementState {
  @override
  List<Object> get props => [];
}

class AchievementLoaded extends AchievementState {
  final AchievementPoint achievementPoint;

  const AchievementLoaded({required this.achievementPoint});

  @override
  List<Object> get props => [achievementPoint];
}

class AchievementError extends AchievementState {
  final String message;

  const AchievementError({required this.message});

  @override
  List<Object> get props => [message];
}
