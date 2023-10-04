import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ugd_bloc/bloc/form_submission_state.dart';
import 'package:ugd_bloc/bloc/register_event.dart';
import 'package:ugd_bloc/bloc/register_state.dart';
import 'package:ugd_bloc/repository/register_repository.dart';

class LoginBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository = RegisterRepository();
  LoginBloc() : super(RegisterState()) {
    on<IsPasswordVisibleChanged>(
        (event, emit) => _onIsPasswordVisibleChanged(event, emit));
    on<FormSubmitted>((event, emit) => _onFormSubmitted(event, emit));
  }
  void _onIsPasswordVisibleChanged(
      IsPasswordVisibleChanged event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
      formSubmissionState: const InitialFormState(),
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(formSubmissionState: FormSubmitting()));
    try {
      await registerRepository.login(event.username, event.password);
      emit(state.copyWith(formSubmissionState: SubmissionSuccess()));
    } on FailedRegister catch (e) {
      emit(state.copyWith(
          formSubmissionState: SubmissionFailed(e.errorMessage())));
    } on String catch (e) {
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e)));
    } catch (e) {
      emit(state.copyWith(formSubmissionState: SubmissionFailed(e.toString())));
    }
  }
}
