part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {}

class FetchDataEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class SortListEvent extends HomeEvent {
  final List<Post> list;
  final SortCardItemType label;
  SortListEvent(this.list, this.label);
  @override
  List<Object?> get props => [];
}