import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading.dart';
import '../bloc/promo/promo_bloc.dart';
import '../bloc/promo/promo_state.dart';
import 'promo_tile.dart';

class TabPromo extends StatefulWidget {
  const TabPromo({super.key});

  @override
  State<TabPromo> createState() => _TabPromoState();
}

class _TabPromoState extends State<TabPromo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<PromoBloc, PromoState>(
        builder: (_, state) {
          if (state is PromoLoading) {
            return const SBLoading();
          }

          if (state is PromoError) {
            return const Icon(Icons.refresh);
          }

          if (state is PromoListDone) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return PromoTileWidget(promo: state.promoList![index]);
              },
              itemCount: state.promoList!.length,
            );
          }

          return const Text('No data');
        },
      ),
    );
  }
}
