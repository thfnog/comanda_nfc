part of 'registerdetails_bloc.dart';

@immutable
abstract class RegisterEvent {}

class BackTappedEvent extends RegisterEvent {}

class OnTextChangedEvent extends RegisterEvent {}

class RegisterCellTappedEvent extends RegisterEvent {
  final Register currentRegister;
  final Register? nextRegister;

  RegisterCellTappedEvent({
    required this.currentRegister,
    required this.nextRegister,
  });
}
