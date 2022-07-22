part of 'reportdetails_bloc.dart';

@immutable
abstract class ReportEvent {}

class BackTappedEvent extends ReportEvent {}

class RegisterCellTappedEvent extends ReportEvent {
  final Report currentReport;
  final Report? nextReport;

  RegisterCellTappedEvent({
    required this.currentReport,
    required this.nextReport,
  });
}
