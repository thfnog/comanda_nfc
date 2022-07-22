import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/report.dart';
import '../../report_details/widget/report_details_content.dart';
import '../bloc/reportdetails_bloc.dart';

class ReportDetailsPage extends StatelessWidget {
  final List<Report> reports;
  ReportDetailsPage({required this.reports});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<ReportDetailsBloc> _buildContext(BuildContext context) {
    return BlocProvider<ReportDetailsBloc>(
      create: (context) => ReportDetailsBloc(report: reports),
      child: BlocConsumer<ReportDetailsBloc, ReportDetailsState>(
        buildWhen: (_, currState) => currState is ReportDetailsInitial,
        builder: (context, state) {
          return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              body: ReportDetailsContent(reports: reports));
        },
        listenWhen: (_, currState) => currState is BackTappedState || currState is ReportCellTappedState,
        listener: (context, state) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
