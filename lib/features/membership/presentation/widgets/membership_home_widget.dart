import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/utils/formatter.dart';
import '../bloc/membership_bloc.dart';
import '../bloc/membership_state.dart';

class MembershipHomeWidget extends StatefulWidget {
  const MembershipHomeWidget({super.key});

  @override
  State<MembershipHomeWidget> createState() => _MembershipHomeWidgetState();
}

class _MembershipHomeWidgetState extends State<MembershipHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MembershipBloc, MembershipState>(
      builder: (context, state) {
        int points = 0;

        if (state is MembershipDone) {
          points = state.membership!.points!;
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  const WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(Icons.wallet),
                  ),
                  const WidgetSpan(child: SizedBox(width: 8.0)),
                  TextSpan(
                    text: Intl.plural(
                      points,
                      zero: '${UtilsFormatter.decimalFormat(points)} Point',
                      one: '${UtilsFormatter.decimalFormat(points)} Point',
                      other: '${UtilsFormatter.decimalFormat(points)} Points',
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Membership Level',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5.0),
                Text(
                  state is MembershipDone ? state.membership!.name!.toUpperCase() : 'please wait'.toUpperCase(),
                  style: TextStyle(color: accentColor),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
