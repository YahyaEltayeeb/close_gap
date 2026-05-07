import 'package:close_gap/config/routing/app_routes.dart';
import 'package:close_gap/core/components/custom_elevated_button.dart';
import 'package:close_gap/core/utils/assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(AppAssets.loogoRemovebgPreview),
          SizedBox(height: 10),
          Image.asset(AppAssets.GeminiGeneratedImage,alignment: AlignmentGeometry.center,),
          SizedBox(height: 75),
          CustomElevatedButton(
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.login);
            },
            widget: Text(
              'Get Start',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
