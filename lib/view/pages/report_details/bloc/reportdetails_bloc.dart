import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../../model/report.dart';

part 'reportdetails_event.dart';
part 'reportdetails_state.dart';

class ReportDetailsBloc extends Bloc<ReportEvent, ReportDetailsState> {
  final List<Report> report;

  ReportDetailsBloc({required this.report}) : super(ReportDetailsInitial());

  @override
  Stream<ReportDetailsState> mapEventToState(
    ReportEvent event,
  ) async* {
    if (event is BackTappedEvent) {
      yield BackTappedState();
    } else if (event is RegisterCellTappedEvent) {
      yield ReportCellTappedState(
        currentReport: event.currentReport,
        nextReport: event.nextReport,
      );
    }
  }
}
