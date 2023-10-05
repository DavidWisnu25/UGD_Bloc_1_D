import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ugd_bloc/bloc/form_submission_state.dart';
import 'package:ugd_bloc/bloc/register_bloc.dart';
import 'package:ugd_bloc/bloc/register_event.dart';
import 'package:ugd_bloc/bloc/register_state.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {
  final formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.formSubmissionState is SubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Success'),
              ),
            );
          }
          if (state.formSubmissionState is SubmissionFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text((state.formSubmissionState as SubmissionFailed)
                    .exception
                    .toString()),
              ),
            );
          }
        },
        child:
            BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Username',
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your username' : null,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Email',
                        ),
                        validator: (value) =>
                            value == '' ? 'Please enter your email' : null,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              context.read<RegisterBloc>().add(
                                    IsPasswordVisibleChanged(),
                                  );
                            },
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: state.isPasswordVisible
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                          ),
                        ),
                        obscureText: state.isPasswordVisible,
                        validator: (value) =>
                            value == '' ? 'Please Enter your password' : null,
                      ),
                      //Bagian yang di comment masih error (Untuk noTelpon & pemilihan tanggal), lihat file register_bloc.dart
                      // TextFormField(
                      //   keyboardType: TextInputType.number, // Set keyboard type to number
                      //   decoration: const InputDecoration(
                      //     prefixIcon: Icon(Icons.phone),
                      //     labelText: 'Phone Number',
                      //   ),
                      //   validator: (value) =>
                      //       value.isEmpty ? 'Please enter your phone number' : null,
                      //   onChanged: (value) {
                      //     // Parse the input text as an integer and assign it to noTelpon
                      //     context.read<RegisterBloc>().add(NoTelponChanged(int.tryParse(value) ?? 0));
                      //   },
                      // ),
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     final DateTime pickedDate = await showDatePicker(
                      //       context: context,
                      //       initialDate: selectedDate, // Set the initial date
                      //       firstDate: DateTime(2000),
                      //       lastDate: DateTime(2101),
                      //     );

                      //     if (pickedDate != null && pickedDate != selectedDate) {
                      //       // Update the selectedDate if a new date is picked
                      //       context.read<RegisterBloc>().add(SelectedDateChanged(pickedDate));
                      //     }
                      //   },
                      //   child: Text(
                      //     'Select Date',
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),

                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<RegisterBloc>().add(
                                    FormSubmitted(
                                      username: usernameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      noTelpon: 0,
                                      selectedDate: DateTime.now(),
                                    ),
                                  );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.0, horizontal: 16.0),
                            child: state.formSubmissionState is FormSubmitting
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text("Login"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
