import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(accentColor),
                      ),
                      icon: const Icon(
                        Icons.sell,
                        color: Colors.white,
                        size: 14.0,
                      ),
                      label: const Text(
                        'My Coupons',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      onPressed: () {/* ... */},
                    ),
                  ),
                  const VerticalDivider(
                    thickness: 2.0,
                    width: 30.0,
                  ),
                  Expanded(
                    child: TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(accentColor),
                      ),
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 14.0,
                      ),
                      label: const Text(
                        'Buy Coupons',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                      onPressed: () {/* ... */},
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2.0,
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Icon(Icons.wallet),
                      ),
                      WidgetSpan(child: SizedBox(width: 8.0)),
                      TextSpan(text: '0 Points')
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
                    const SizedBox(height: 10.0),
                    Text(
                      'BASIC',
                      style: TextStyle(color: accentColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
