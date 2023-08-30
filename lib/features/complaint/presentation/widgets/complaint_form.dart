import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/components/button.dart';
import '../../../../core/components/dialog.dart';
import '../../../../core/components/loading.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../injection_container.dart';
import '../../data/models/complaint_type.dart';
import '../bloc/complaint/complaint_bloc.dart';
import '../bloc/complaint/complaint_event.dart';
import '../bloc/complaint/complaint_state.dart';
import '../bloc/types/complaint_type_bloc.dart';
import '../bloc/types/complaint_type_event.dart';
import '../bloc/types/complaint_type_state.dart';

class ComplaintForm extends StatefulWidget {
  const ComplaintForm({super.key});

  @override
  State<ComplaintForm> createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? selectedType;

  DateTime selectedDate = DateTime.now();

  void selectType(BuildContext context) async {
    final newSelectedType = await showModalBottomSheet<ComplaintTypeModel>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext _) {
        return BlocProvider.value(
          value: getIt.get<ComplaintTypeBloc>()..add(const GetComplaintTypes()),
          child: BlocBuilder<ComplaintTypeBloc, ComplaintTypeState>(
            builder: (context, state) {
              if (state is ComplaintTypeDone) {
                return Wrap(
                  children: [
                    for (final type in state.types!)
                      ListTile(
                        onTap: () {
                          Navigator.of(context).pop(type);
                        },
                        title: Text(type.name ?? '-'),
                      ),
                  ],
                );
              }

              return const FractionallySizedBox(
                heightFactor: 0.2,
                child: Center(
                  child: SBLoading(),
                ),
              );
            },
          ),
        );
      },
    );

    if (newSelectedType != null) {
      selectedType = newSelectedType.id;
      _typeController.text = newSelectedType.name ?? '';
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
      _dateController.text = DateFormat.yMMMMd().format(selectedDate);
    }
  }

  @override
  void dispose() {
    _typeController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComplaintBloc, ComplaintState>(
      listener: (context, state) async {
        if (state is ComplaintSent) {
          if (state.message!.status) {
            _typeController.text = '';
            _dateController.text = '';
            _descriptionController.text = '';
          }

          await basicDialog(
            context,
            state.message!.title,
            state.message!.message,
          );
        }

        if (state is ComplaintError) {
          if (context.mounted) await exceptionDialog(context);
        }
      },
      child: BlocBuilder<ComplaintBloc, ComplaintState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                SBTextFormField(
                  controller: _typeController,
                  hintText: 'Type',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill in the type field';
                    }
                    return null;
                  },
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    selectType(context);
                  },
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    onPressed: () {
                      selectType(context);
                    },
                  ),
                ),
                const SizedBox(height: 15.0),
                SBTextFormField(
                  controller: _dateController,
                  hintText: 'Date of Visit',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill in the date of visit field';
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
                  controller: _descriptionController,
                  hintText: 'Please describe what we can do better...',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill in the description field';
                    }
                    return null;
                  },
                  isMultiline: true,
                ),
                const SizedBox(height: 30.0),
                SBButton(
                  onPressed: (state is ComplaintLoading)
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).requestFocus(FocusNode());

                            final String date =
                                DateFormat('yyyy-MM-dd').format(selectedDate);

                            BlocProvider.of<ComplaintBloc>(context).add(
                              SendComplaint(
                                type: selectedType ?? '0',
                                date: date,
                                store: 1.toString(),
                                description: _descriptionController.text,
                              ),
                            );
                          }
                        },
                  child: (state is ComplaintLoading)
                      ? const Center(
                          child: SBLoading(color: Colors.white),
                        )
                      : const Text('Submit'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
