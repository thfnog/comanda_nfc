part of 'registerdetails_bloc.dart';

@immutable
abstract class RegisterDetailsState {}

class RegisterDetailsInitial extends RegisterDetailsState {}

class RegisterData extends RegisterDetailsState {}

class BackTappedState extends RegisterDetailsState {}

class RegisterCellTappedState extends RegisterDetailsState {
  final Register currentRegister;
  final Register? nextRegister;

  RegisterCellTappedState({
    required this.currentRegister,
    required this.nextRegister,
  });
}
