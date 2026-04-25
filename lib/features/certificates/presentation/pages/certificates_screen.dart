import 'package:close_gap/config/theme/colors.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:close_gap/core/helpers/flutter_toast.dart';
import 'package:close_gap/features/certificates/presentation/manager/certificates_cubit.dart';
import 'package:close_gap/features/certificates/presentation/manager/certificates_state.dart';
import 'package:close_gap/features/certificates/presentation/widgets/add_certificate_sheet.dart';
import 'package:close_gap/features/certificates/presentation/widgets/certificate_card.dart';
import 'package:close_gap/features/certificates/presentation/widgets/certificates_loading_view.dart';
import 'package:close_gap/features/certificates/presentation/widgets/empty_certificates_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CertificatesScreen extends StatelessWidget {
  const CertificatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CertificatesCubit>()..loadData(),
      child: const _CertificatesView(),
    );
  }
}

class _CertificatesView extends StatelessWidget {
  const _CertificatesView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CertificatesCubit, CertificatesState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.successMessage != current.successMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          ToastMessage.toastMsg(
            state.errorMessage!,
            backgroundColor: AppColors.red,
          );
          context.read<CertificatesCubit>().clearFeedback();
        }
        if (state.successMessage != null) {
          ToastMessage.toastMsg(state.successMessage!);
          context.read<CertificatesCubit>().clearFeedback();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF6F8FB),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF6F8FB),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            title: const Text(
              'My Certificates',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: state.isSubmitting || state.isLoading
                ? null
                : () => _showAddSheet(context, state),
            backgroundColor: AppColors.lightPrimary,
            icon: const Icon(Icons.add_rounded, color: Colors.white),
            label: const Text(
              'Add Certificate',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => context.read<CertificatesCubit>().loadData(),
            child: state.isLoading
                ? const CertificatesLoadingView()
                : LayoutBuilder(
                    builder: (context, constraints) {
                      return ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
                        children: [
                          Text(
                            'Add certificates using the backend fields: title, skill_id, and course_id.',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 22),
                          if (state.certificates.isEmpty)
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight - 160,
                              ),
                              child: const Center(
                                child: EmptyCertificatesCard(),
                              ),
                            )
                          else
                            ...state.certificates.map(
                              (item) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: CertificateCard(
                                  certificate: item,
                                  skills: state.skills,
                                  courses: state.courses,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Future<void> _showAddSheet(
    BuildContext context,
    CertificatesState state,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<CertificatesCubit>(),
        child: AddCertificateSheet(
          skills: state.skills,
          courses: state.courses,
        ),
      ),
    );
  }
}
