abstract class RegisterEvent {}

class IsPasswordVisibleChanged extends RegisterEvent {}

class NoTelponChanged extends RegisterEvent {}

class SelectedDateChanged extends RegisterEvent {}

class FormSubmitted extends RegisterEvent {
  String username;
  String email;
  String password;
  String noTelpon;
  String selectedDate;

  FormSubmitted(
      {required this.username,
      required this.email,
      required this.password,
      required this.noTelpon,
      required this.selectedDate});
}
