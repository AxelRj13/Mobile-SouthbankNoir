import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/popup.dart';

abstract class PopupState extends Equatable {
  final PopupModel? popup;
  final DioException? error;

  const PopupState({this.popup, this.error});

  @override
  List<Object> get props => [popup!, error!];
}

class PopupLoading extends PopupState {
  const PopupLoading();
}

class PopupDone extends PopupState {
  const PopupDone({
    required PopupModel popup,
  }) : super(
          popup: popup,
        );
}
