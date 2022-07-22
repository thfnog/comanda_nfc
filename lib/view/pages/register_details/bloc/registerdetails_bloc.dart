import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../model/register.dart' as data;
import '../../../../model/register.dart';

part 'registerdetails_event.dart';
part 'registerdetails_state.dart';

class RegisterDetailsBloc extends Bloc<RegisterEvent, RegisterDetailsState> {
  final List<data.Register> register;
  final PanelController panelController = PanelController();

  String uid = '';

  final nameController = TextEditingController();
  final documentController = TextEditingController();
  final contactController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final quantityController = TextEditingController();
  final valueController = TextEditingController();
  final descriptionController = TextEditingController();

  RegisterDetailsBloc({required this.register}) : super(WorkoutDetailsInitial());

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
