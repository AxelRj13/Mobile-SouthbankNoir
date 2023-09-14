import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/dialog.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/components/radio_button.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/constants/enum.dart';
import '../../../../core/utils/validator_extension.dart';
import '../../../../injection_container.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';

class ProfileEditForm extends StatefulWidget {
  const ProfileEditForm({super.key});

  @override
  State<ProfileEditForm> createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _picker = ImagePicker();

  ImageProvider profilePicture =
      const AssetImage('assets/img/profile-default.png');
  late DateTime selectedDate;
  Gender selectedGender = Gender.male;

  Future selectImageFromGallery(ImageSource imageSource) async {
    final pickedFile = await _picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        File image = File(pickedFile.path);
        cropImage(image);
      }
    });
  }

  Future<void> cropImage(File image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 80,
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: appbarColor,
          hideBottomControls: true,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );

    if (croppedFile != null) {
      File imageFile = File(croppedFile.path);
      print('IMAGE');
      print(imageFile);
      if (mounted) {
        BlocProvider.of<ProfileBloc>(context).add(SetPhoto(image: imageFile));
      }
    }
  }

  void selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(selectedDate.year + 10),
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

  Future<void> loadPrefs() async {
    final prefs = getIt.get<SharedPreferences>();

    final dob = prefs.getString('dob') != null
        ? DateTime.parse(prefs.getString('dob')!)
        : DateTime.now();

    profilePicture = prefs.getString('photo') != null
        ? NetworkImage(prefs.getString('photo')!)
        : profilePicture;

    selectedDate = dob;

    print('Selected init date: $selectedDate');

    _firstNameController.text = prefs.getString('firstName') ?? '';
    _lastNameController.text = prefs.getString('lastName') ?? '';
    _dobController.text = DateFormat.yMMMMd().format(dob);
    _cityController.text = prefs.getString('city') ?? '';
    _phoneController.text = prefs.getString('phone') ?? '';

    selectedGender = prefs.getString('gender')?.toLowerCase() == 'female'
        ? Gender.female
        : Gender.male;
  }

  @override
  void initState() {
    super.initState();

    loadPrefs();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) async {
        if (state is ProfileUpdateMessage) {
          loadPrefs();

          await basicDialog(
            context,
            state.message!.title,
            state.message!.message,
          );
        }

        if (state is ProfileUpdateError) {
          if (context.mounted) await exceptionDialog(context);
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectImageFromGallery(ImageSource.gallery);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                    child: Stack(
                      clipBehavior: Clip.none,
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.2,
                          backgroundImage: state is ProfilePhotoSet
                              ? FileImage(state.image!)
                              : profilePicture,
                        ),
                        Positioned(
                          bottom: -10,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {
                              selectImageFromGallery(ImageSource.gallery);
                            },
                            elevation: 2.0,
                            fillColor: accentColor,
                            padding: const EdgeInsets.all(10.0),
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
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
                const SizedBox(height: 30.0),
                SBButton(
                  onPressed: (state is ProfileLoading)
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());

                            print('Selected btn date: $selectedDate');

                            final String dob =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                            final String gender = selectedGender == Gender.male
                                ? 'male'
                                : 'female';

                            BlocProvider.of<ProfileBloc>(context).add(
                              UpdateProfile(
                                firstName: _firstNameController.text,
                                lastName: _lastNameController.text,
                                dob: dob,
                                city: _cityController.text,
                                gender: gender,
                                phone: _phoneController.text,
                              ),
                            );
                          }
                        },
                  child: (state is ProfileLoading)
                      ? const Center(
                          child: SBLoading(),
                        )
                      : const Text(
                          'Save',
                          style: TextStyle(fontSize: 16.0),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
