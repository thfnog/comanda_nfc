part of 'reportdetails_bloc.dart';

@immutable
abstract class ReportDetailsState {}

class ReportDetailsInitial extends ReportDetailsState {}

class RegisterData extends ReportDetailsState {}

class BackTappedState extends ReportDetailsState {}

class ReportCellTappedState extends ReportDetailsState {
  final Report currentReport;
  final Report? nextReport;

  ReportCellTappedState({
    required this.currentReport,
    required this.nextReport,
  });
}
