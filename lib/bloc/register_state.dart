import 'package:ugd_bloc/bloc/form_submission_state.dart';

class RegisterState {
  final bool isPasswordVisible;
  final FormSubmissionState formSubmissionState;
  final int noTelpon;
  final DateTime selectedDate;

  RegisterState({
    this.isPasswordVisible = false,
    this.formSubmissionState = const InitialFormState(),
    this.noTelpon =0,
    DateTime? selectedDate,
  }) : selectedDate = selectedDate ?? DateTime.now(); 

  RegisterState copyWith({
    bool? isPasswordVisible,
    FormSubmissionState? formSubmissionState,
    int? noTelpon,
    DateTime? selectedDate,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
      noTelpon: noTelpon ?? this.noTelpon,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
