import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/complaint/complaint_bloc.dart';
import 'widgets/complaint_form.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint')),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: BlocProvider<ComplaintBloc>(
            create: (BuildContext context) => getIt.get<ComplaintBloc>(),
            child: const ComplaintForm(),
          ),
        ),
      ),
    );
  }
}
