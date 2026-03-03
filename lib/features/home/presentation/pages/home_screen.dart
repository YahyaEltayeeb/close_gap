import 'package:flutter/material.dart';
import 'package:close_gap/features/home/presentation/widget/custom_banner_widget.dart';
import 'package:close_gap/features/home/presentation/widget/custom_job_widget.dart';
import 'package:close_gap/features/home/presentation/widget/linear_progress_widget.dart';
import 'package:close_gap/features/home/presentation/widget/quick_action_widget.dart';
import 'package:close_gap/features/home/presentation/widget/welcome_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: Icon(Icons.memory)
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WelcomeWidget(),
              CustomBannerWidget(),
              LinearProgressWidget(),
              QuickActionWidget(),
              CustomJobWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
