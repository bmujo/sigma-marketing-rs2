part of '../../../../blocs/common/layout/layout_bloc.dart';

abstract class LayoutState extends Equatable {
  const LayoutState();
}

class LayoutInitial extends LayoutState {
  @override
  List<Object> get props => [];
}

class LayoutLoaded extends LayoutState {
  final int numberMessages;
  final int numberNotifications;

  const LayoutLoaded({
    required this.numberMessages,
    required this.numberNotifications,
  });

  @override
  List<Object> get props => [numberMessages, numberNotifications];
}
