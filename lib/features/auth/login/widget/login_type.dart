import 'package:flutter/material.dart';
import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/extensions/extensions.dart';
import 'package:close_gap/core/utils/assets.dart';

class LoginType extends StatelessWidget {
  const LoginType({super.key});

  @override
  Widget build(BuildContext context) {
    var locale=context.localization;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {},
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            // ignore: deprecated_member_use
            shadowColor: Colors.black.withOpacity(0.7),
            child: Container(
              width: context.width * 0.35,
              height: context.height * 0.047,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xff454B60), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(AppAssets.google),
                  Text(
                  locale.google  ,
                    style: context.textTheme.displayMedium!.copyWith(
                      color: AppColors.lightProgress,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(10),
            // ignore: deprecated_member_use
            shadowColor: Colors.black.withOpacity(0.7),
            child: Container(
              width: context.width * 0.35,
              height: context.height * 0.047,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.lightProgress,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(AppAssets.facebook),
                  Text(
                    locale.facebook,
                    style: context.textTheme.displayMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
