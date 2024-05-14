part of 'layout_bloc.dart';

abstract class LayoutEvent extends Equatable {
  const LayoutEvent();
}

class LayoutFetched extends LayoutEvent {
  @override
  List<Object> get props => [];
}
