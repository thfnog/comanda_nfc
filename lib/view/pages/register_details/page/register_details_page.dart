import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/register.dart' as data;
import '../bloc/registerdetails_bloc.dart';
import '../widget/register_details_content.dart';

class RegisterDetailsPage extends StatelessWidget {
  final List<data.Register> register;
  RegisterDetailsPage({required this.register});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<RegisterDetailsBloc> _buildContext(BuildContext context) {
    return BlocProvider<RegisterDetailsBloc>(
      create: (context) => RegisterDetailsBloc(register: register),
      child: BlocConsumer<RegisterDetailsBloc, RegisterDetailsState>(
        buildWhen: (_, currState) => currState is WorkoutDetailsInitial,
        builder: (context, state) {
          return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              body: RegisterDetailsContent(register: register));
        },
        listenWhen: (_, currState) => currState is BackTappedState || currState is RegisterCellTappedState,
        listener: (context, state) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
