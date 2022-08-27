import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/enums/cardType.dart';
import '../bloc/registerdetails_bloc.dart';
import '../widget/register_details_content.dart';

class RegisterDetailsPage extends StatelessWidget {
  final CardType? cardType;
  const RegisterDetailsPage({super.key, this.cardType});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<RegisterDetailsBloc> _buildContext(BuildContext context) {
    return BlocProvider<RegisterDetailsBloc>(
      create: (context) => RegisterDetailsBloc(cardType: cardType),
      child: BlocConsumer<RegisterDetailsBloc, RegisterDetailsState>(
        buildWhen: (_, currState) => currState is RegisterDetailsInitial,
        builder: (context, state) {
          return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              body: RegisterDetailsContent(cardType: cardType));
        },
        listenWhen: (_, currState) => currState is BackTappedState || currState is RegisterCellTappedState,
        listener: (context, state) {
          Navigator.pop(context);
        },
      ),
    );
  }
}
