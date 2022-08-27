import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../model/enums/cardType.dart';
import '../../../../model/register.dart';

part 'registerdetails_event.dart';
part 'registerdetails_state.dart';

class RegisterDetailsBloc extends Bloc<RegisterEvent, RegisterDetailsState> {
  final CardType? cardType;

  final PanelController panelController = PanelController();

  final nameController = TextEditingController();
  final documentController = TextEditingController();
  final contactController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final quantityController = TextEditingController();
  final valueController = TextEditingController();
  final descriptionController = TextEditingController();

  var uid;

  RegisterDetailsBloc({required this.cardType}) : super(RegisterDetailsInitial());

  @override
  Stream<RegisterDetailsState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is BackTappedEvent) {
      yield BackTappedState();
    } else if (event is RegisterCellTappedEvent) {
      yield RegisterCellTappedState(
        currentRegister: event.currentRegister,
        nextRegister: event.nextRegister,
      );
    }
  }
}
