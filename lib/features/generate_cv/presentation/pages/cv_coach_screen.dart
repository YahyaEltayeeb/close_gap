import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/features/generate_cv/common/generate_cv_dimensions.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/generate_cv_cubit.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/generate_cv_state.dart';
import 'package:close_gap/features/generate_cv/presentation/manager/helper_function.dart';
import 'package:close_gap/features/generate_cv/presentation/pages/pdf_viewer_screen.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/cv_status_header.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/generate_cv_appbar.dart';
import 'package:close_gap/features/generate_cv/presentation/widgets/ready_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GenerateCvScreen extends StatelessWidget {
  const GenerateCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GenerateCvCubit>()..generateCv(),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: CvCoachAppBar(
          title: 'CV Coach',
          onBackPressed: () => Navigator.of(context).pop(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: GenerateCvDimensions.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CvStatusHeader(
                  title: 'AI is creating your CV...',
                  subtitle:
                      'Analyze your information and generating your CV\nthis may take a moment...',
                ),
                const SizedBox(height: GenerateCvDimensions.spacingLarge),
                BlocBuilder<GenerateCvCubit, GenerateCvState>(
                  builder: (context, state) {
                    final cubit = context.read<GenerateCvCubit>();

                    return CvReadyCard(
                      onView: () {
                        if (cubit.cachedPdf != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PdfViewerScreen(pdfBytes: cubit.cachedPdf!),
                            ),
                          );
                        }
                      },
                      onDownloadPdf: () async {
                        if (cubit.cachedPdf != null) {
                          await saveAndOpenPdf(cubit.cachedPdf!);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
