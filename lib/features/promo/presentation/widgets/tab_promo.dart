import 'package:flutter/material.dart';

import '../../../../core/components/loading.dart';
import '../../../../core/error/not_found.dart';
import '../bloc/promo/promo_state.dart';
import 'promo_tile.dart';

class TabPromo extends StatefulWidget {
  final PromoState state;

  const TabPromo({
    super.key,
    required this.state,
  });

  @override
  State<TabPromo> createState() => _TabPromoState();
}

class _TabPromoState extends State<TabPromo> {
  @override
  Widget build(BuildContext context) {
    if (widget.state is PromoNotFound) {
      return const NotFoundWidget();
    }

    if (widget.state is PromoError) {
      return const Icon(Icons.refresh);
    }

    if (widget.state is PromoListDone) {
      return Column(
        children: widget.state.promoList!
            .map(
              (promo) => PromoTileWidget(promo: promo),
            )
            .toList(),
      );
    }

    return const SBLoading();
  }
}
