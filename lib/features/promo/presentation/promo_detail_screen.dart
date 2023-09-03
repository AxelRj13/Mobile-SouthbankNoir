import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';
import 'bloc/promo/promo_bloc.dart';
import 'widgets/promo_detail.dart';

class PromoDetailScreen extends StatefulWidget {
  final String id;

  const PromoDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<PromoDetailScreen> createState() => _PromoDetailScreenState();
}

class _PromoDetailScreenState extends State<PromoDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promo'),
      ),
      body: BlocProvider<PromoBloc>(
        create: (BuildContext context) => getIt.get<PromoBloc>(),
        child: PromoDetail(
          id: widget.id,
        ),
      ),
    );
  }
}
