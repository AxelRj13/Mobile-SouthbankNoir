import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/complaint/complaint_bloc.dart';
import 'bloc/types/complaint_type_bloc.dart';
import 'bloc/types/complaint_type_event.dart';
import 'widgets/complaint_form.dart';

class ComplaintScreen extends StatelessWidget {
  const ComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint')),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<ComplaintBloc>(
              create: (context) => getIt.get<ComplaintBloc>(),
            ),
            BlocProvider<ComplaintTypeBloc>(
              create: (context) => getIt.get<ComplaintTypeBloc>()..add(const GetComplaintTypes()),
            ),
          ],
          child: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ComplaintForm(),
            ),
          )),
    );
  }
}
