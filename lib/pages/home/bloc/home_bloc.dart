import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger_beauty/logger_beauty.dart';
import 'package:tienphatcpn_interview/constants/lv_app_enums.dart';
import 'package:tienphatcpn_interview/constants/string_constant.dart';
import 'package:tienphatcpn_interview/extensions/reading_extension.dart';

import '../model/post.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<FetchDataEvent>(_onFetchData);
    on<SortListEvent>(_onSort);
  }

  Future<void> _onSort(SortListEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 2), () {
      logDebug(updatedData);
    });
    switch (event.label) {
      case SortCardItemType.date:
        event.list.sort((a, b) => a.createdDate.compareTo(b.createdDate));
      case SortCardItemType.like:
        event.list.sort((a, b) => a.liked.compareTo(b.liked));
      case SortCardItemType.share:
        event.list.sort((a, b) => a.shared.compareTo(b.shared));
      case SortCardItemType.comment:
        event.list.sort((a, b) => a.comments.compareTo(b.comments));
    }
    emit(HomeFetchDataDone(event.list));  }

  Future<void> _onFetchData(FetchDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 5), () {
      logDebug(updatedData);
    });
    final List<dynamic> response = await readJsonFromAssets(dataFilePath);
    logDebug(response);
    List<Post> lstPost = response.map((e) => Post.fromJson(e)).toList();
    emit(HomeFetchDataDone(lstPost));  }
}

