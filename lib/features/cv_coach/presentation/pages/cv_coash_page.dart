import 'dart:io';
import 'package:close_gap/features/cv_coach/presentation/manager/cv_coash_view_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:close_gap/core/di/di.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:close_gap/features/cv_coach/presentation/manager/cv_coash_event.dart';
import 'package:close_gap/features/cv_coach/presentation/manager/cv_coash_state.dart';
import 'package:close_gap/features/cv_coach/presentation/pages/cv_coash_result_screen.dart';

class CvCoachScreen extends StatelessWidget {
  const CvCoachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CvCoashViewModel>(
      create: (context) =>getIt<CvCoashViewModel>(),
      child: const _CvCoachView(),
    );
  }
}

class _CvCoachView extends StatefulWidget {
  const _CvCoachView();

  @override
  State<_CvCoachView> createState() => _CvCoachViewState();
}

class _CvCoachViewState extends State<_CvCoachView> {
  File? _selectedFile;
  String? _fileName;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  void _submitCv(BuildContext context) {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a CV file first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    context.read<CvCoashViewModel>().doIntent(SumbitCvEvent(file: _selectedFile!));
  }

  Future<void> _watchVideo() async {
    const url = 'https://youtu.be/KGr8fXDWeV4?si=eUQMGxquXGjnm7Ar';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<CvCoashViewModel, CvCoashState>(
        listener: (context, state) {
          if (state.isLoaddingCvCoash) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Cv Analyze...'),
                backgroundColor:Colors.green,
              ),
            );
          }
         if (state.cvAnalysisEntity != null && !state.isLoaddingCvCoash) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => CvCoachResultScreen(cvAnalysisEntity: state.cvAnalysisEntity!),
    ),
  );
}
        },
        builder: (context, state) {
          return Column(
            children: [
              // Blue gradient header
              _buildHeader(context),
              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      // Title
                      const Text(
                        'Get Instant CV\nFeedback',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Upload your CV to see how it scores against\nindustry standards.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Upload box
                      _buildUploadBox(context, state),
                      const SizedBox(height: 24),
                      // OR divider
                      _buildOrDivider(),
                      const SizedBox(height: 24),
                      // AI CV Maker section
                      _buildAiCvMakerSection(context),
                      const SizedBox(height: 24),
                      // Watch video section
                      _buildWatchVideoSection(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Expanded(
                child: Text(
                  'CV Coach',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 48), // balance the back button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadBox(BuildContext context, CvCoashState state) {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 36),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF2196F3),
            width: 1.5,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Upload icon circle
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFFBBDEFB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.upload_rounded,
                color: Color(0xFF2196F3),
                size: 30,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              _fileName ?? 'Upload your CV',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'PDF only, max 10MB',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 18),
            // Upload / Submit button
            SizedBox(
              width: 140,
              height: 40,
              child: state.isLoaddingCvCoash
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF2196F3),
                        strokeWidth: 2,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: _selectedFile != null
                          ? () => _submitCv(context)
                          : _pickFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _selectedFile != null ? 'Analyze' : 'Upload',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade300, thickness: 1)),
      ],
    );
  }

  Widget _buildAiCvMakerSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'AI CV Maker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'If you want AI to help you create a professional\nCV using ATS simply click on Create.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Create CV with ATS way',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to AI CV creation screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWatchVideoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'See how to create a proper CV here:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap:
           _watchVideo,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'CV with ATS way',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'YouTube',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed:
                     _watchVideo,
                    icon: const Icon(Icons.chevron_right, size: 18),
                    label: const Text(
                      'Watch Video',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}