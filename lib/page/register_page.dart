import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ugd_bloc/bloc/form_submission_state.dart';
import 'package:ugd_bloc/bloc/register_bloc.dart';
import 'package:ugd_bloc/bloc/register_event.dart';
import 'package:ugd_bloc/bloc/register_state.dart';
import 'package:ugd_bloc/page/login_page.dart';

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
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterBloc>(
      create: (context) => RegisterBloc(),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.formSubmissionState is SubmissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Register Success'),
              ),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const Loginview()));
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
                child: Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
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
                            validator: (value) => value == ''
                                ? 'Please enter your username'
                                : null,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email),
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
                                  state.isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: state.isPasswordVisible
                                      ? Colors.grey
                                      : Colors.blue,
                                ),
                              ),
                            ),
                            obscureText: state.isPasswordVisible,
                            validator: (value) => value == ''
                                ? 'Please Enter your password'
                                : null,
                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              labelText: 'Phone Number',
                            ),
                            validator: (value) => value == ''
                                ? 'Please enter your Phone Number'
                                : null,
                          ),
                          TextFormField(
                            controller: dateController,
                            readOnly: true,
                            onTap: () {
                              _showDatePicker();
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.date_range),
                              labelText: 'Born Date',
                              suffixIcon: IconButton(
                                  onPressed: () async {
                                    _showDatePicker();
                                  },
                                  icon: Icon(Icons.date_range_outlined)),
                            ),
                            validator: (value) => value == ''
                                ? 'Please enter your Born Date'
                                : null,
                          ),
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
                                          noTelpon: phoneController.text,
                                          selectedDate: dateController.text,
                                        ),
                                      );
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 16.0),
                                child:
                                    state.formSubmissionState is FormSubmitting
                                        ? const CircularProgressIndicator(
                                            color: Colors.white)
                                        : const Text("Register"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _showDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1000),
        lastDate: DateTime(3000));
    if (pickedDate != null) {
      dateController.text =
          DateFormat('MM-dd-yyyy').format(pickedDate).toString();
    }
  }
}
