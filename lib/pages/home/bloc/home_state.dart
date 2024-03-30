part of 'home_bloc.dart';

abstract class HomeState{
}

class HomeFetchDataDone extends HomeState{
  final List<Post> data;
  HomeFetchDataDone(this.data);
}

class HomeLoading extends HomeState{}
