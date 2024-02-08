import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:southbank/config/theme/app_theme.dart';

class SBRefreshIndicator extends StatefulWidget {
  final Future<void> Function() onRefresh;
  final List<Widget> items;

  const SBRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.items,
  });

  @override
  State<SBRefreshIndicator> createState() => _SBRefreshIndicatorState();
}

class _SBRefreshIndicatorState extends State<SBRefreshIndicator> {
  Widget _buildWidgetListDataIOS() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: widget.onRefresh,
        ),
        SliverList(
          delegate: SliverChildListDelegate(widget.items),
        ),
      ],
    );
  }

  Widget _buildWidgetListDataAndroid() {
    return RefreshIndicator(
      color: accentColor,
      onRefresh: widget.onRefresh,
      child: ListView(
        children: widget.items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? _buildWidgetListDataIOS() : _buildWidgetListDataAndroid();
  }
}
