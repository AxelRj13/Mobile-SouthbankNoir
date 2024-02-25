import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_theme.dart';
import '../../../../core/constants/constants.dart';
import '../../../coupon/presentation/coupon_screen.dart';
import '../../../membership/presentation/bloc/membership_bloc.dart';
import '../../../membership/presentation/bloc/membership_event.dart';
import '../../../membership/presentation/widgets/membership_home_widget.dart';

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
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => const CouponScreen(type: myCoupon),
                          ),
                        )
                            .then(
                          (value) {
                            context.read<MembershipBloc>().add(
                                  const GetMembership(),
                                );
                          },
                        );
                      },
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
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                          MaterialPageRoute(
                            builder: (context) => const CouponScreen(type: buyCoupon),
                          ),
                        )
                            .then(
                          (value) {
                            context.read<MembershipBloc>().add(
                                  const GetMembership(),
                                );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2.0,
              height: 30.0,
            ),
            const MembershipHomeWidget(),
          ],
        ),
      ),
    );
  }
}
