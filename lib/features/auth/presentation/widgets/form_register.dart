import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/checkbox.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/components/radio_button.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/constants/enum.dart';
import '../../../../core/utils/validator_extension.dart';
import '../bloc/auth/remote/auth_bloc.dart';
import '../bloc/auth/remote/auth_event.dart';
import '../bloc/auth/remote/auth_state.dart';

class FormRegister extends StatefulWidget {
  final Function() onFormSwitchTap;

  const FormRegister({super.key, required this.onFormSwitchTap});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();

  DateTime initialDate = DateTime.now();

  DateTime selectedDate = DateTime.now();
  Gender selectedGender = Gender.male;
  bool passwordObsecure = true;
  bool confirmObsecure = true;
  bool agreement = false;

  void selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(initialDate.year + 10),
      builder: (BuildContext context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: accentColor,
              onPrimary: Colors.white,
              surface: backgroundColor,
            ),
            dialogBackgroundColor: backgroundColor,
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      _dobController
        ..text = DateFormat.yMMMMd().format(selectedDate)
        ..selection = TextSelection.fromPosition(
          TextPosition(
            offset: _dobController.text.length,
            affinity: TextAffinity.upstream,
          ),
        );
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              SBTextFormField(
                controller: _firstNameController,
                hintText: 'First Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the first name field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              SBTextFormField(
                controller: _lastNameController,
                hintText: 'Last Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the last name field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15.0),
              SBTextFormField(
                controller: _dobController,
                hintText: 'Date of Birth',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the date of birth field';
                  }
                  return null;
                },
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  selectDate(context);
                },
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    selectDate(context);
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              SBTextFormField(
                controller: _cityController,
                hintText: 'City',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the city field';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gender',
                    style: TextStyle(color: Colors.grey, fontSize: 16.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SBRadioButton<Gender>(
                          label: 'Male',
                          value: Gender.male,
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: SBRadioButton<Gender>(
                          label: 'Female',
                          value: Gender.female,
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value;
                            });
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SBTextFormField(
                controller: _emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the email field';
                  }
                  if (!value.isEmail) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15.0),
              SBTextFormField(
                controller: _phoneController,
                hintText: 'Phone Number',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the phone number field';
                  }
                  if (value.length < 9) {
                    return 'The phone number must have a minimum of 9 digits';
                  }
                  if (value.length > 14) {
                    return 'The phone number must have a maximum of 14 digits';
                  }
                  if (!value.isPhone) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 15.0),
              SBTextFormField(
                controller: _passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the password field';
                  }
                  if (value.length < 6) {
                    return 'The password must have at least 6 character';
                  }
                  if (!value.hasUppercase) {
                    return 'The password must have at least one uppercase character';
                  }
                  if (!value.hasLowercase) {
                    return 'The password must have at least one lowercase character';
                  }
                  if (!value.hasNumber) {
                    return 'The password must have at least one number';
                  }
                  if (!value.hasSpecialChar) {
                    return 'The password must have at least one special character';
                  }
                  return null;
                },
                isPassword: passwordObsecure,
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordObsecure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordObsecure = !passwordObsecure;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              SBTextFormField(
                controller: _confirmationController,
                hintText: 'Confirm Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please fill in the password field';
                  }
                  if (value != _passwordController.text) {
                    return 'The password confirmation does not match';
                  }
                  return null;
                },
                isPassword: confirmObsecure,
                suffixIcon: IconButton(
                  icon: Icon(
                    confirmObsecure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      confirmObsecure = !confirmObsecure;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              SBCheckbox(
                label:
                    'By registering, you agree to the Terms & Conditions and Privacy Policy',
                value: agreement,
                onChanged: (value) {
                  setState(() {
                    agreement = !agreement;
                  });
                },
              ),
              const SizedBox(height: 30.0),
              SBButton(
                color: Colors.black,
                onPressed: (state is AuthLoading)
                    ? null
                    : () {
                        if (_formKey.currentState!.validate() && agreement) {
                          FocusScope.of(context).requestFocus(FocusNode());

                          final String dob =
                              DateFormat('yyyy-MM-dd').format(selectedDate);
                          final String gender =
                              selectedGender == Gender.male ? 'male' : 'female';

                          BlocProvider.of<AuthBloc>(context).add(
                            Register(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              dob: dob,
                              city: _cityController.text,
                              gender: gender,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              password: _passwordController.text,
                              confirmPassword: _confirmationController.text,
                            ),
                          );
                        }
                      },
                child: (state is AuthLoading)
                    ? const Center(
                        child: SBLoading(),
                      )
                    : const Text(
                        'Register',
                        style: TextStyle(fontSize: 16.0),
                      ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a member?'),
                  const SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: widget.onFormSwitchTap,
                    child: Text(
                      'Login instead',
                      style: TextStyle(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
