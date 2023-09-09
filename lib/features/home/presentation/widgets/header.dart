import 'package:flutter/material.dart';

import '../../../../config/theme/app_theme.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Card(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Points'),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0'),
                    SizedBox(width: 20.0),
                    Icon(Icons.wallet),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton.icon(
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
                    const SizedBox(width: 8),
                    TextButton.icon(
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
                    const VerticalDivider(color: Colors.white),
                    Text(
                      'Basic',
                      style: TextStyle(color: accentColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
