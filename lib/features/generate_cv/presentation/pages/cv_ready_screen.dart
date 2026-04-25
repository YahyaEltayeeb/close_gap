import 'dart:typed_data';

import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/helper_function.dart';
import 'package:close_gap/features/generate_cv/presentation/pages/pdf_viewer_screen.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/generate_cv_appbar.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/ready_card.dart';
import 'package:flutter/material.dart';

class CvReadyScreen extends StatelessWidget {
  const CvReadyScreen({super.key, required this.pdfBytes});

  final Uint8List pdfBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CvCoachAppBar(
        title: 'Your CV',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: CvReadyCard(
              onView: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PdfViewerScreen(pdfBytes: pdfBytes),
                  ),
                );
              },
              onDownloadPdf: () => saveAndOpenPdf(pdfBytes),
            ),
          ),
        ),
      ),
    );
  }
}
