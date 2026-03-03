import 'package:flutter/material.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/utils/assets.dart';

class AuthLogo extends StatelessWidget {
  final String pross;
  final String desc;
  const AuthLogo({super.key, required this.pross, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: context.width * 0.9,

            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme.of(context).brightness == Brightness.light
                    ? Image.asset(AppAssets.appLogoLight,)
                    : Image.asset(AppAssets.appLogoDark),
                Text(
                  pross,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(desc),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
