import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/router/route_names.dart';
import '../../../../shared/theme/app_colors.dart';

class TbcScreeningFormOnePage extends StatefulWidget {
  const TbcScreeningFormOnePage({super.key});

  @override
  State<TbcScreeningFormOnePage> createState() =>
      _TbcScreeningFormOnePageState();
}

class _TbcScreeningFormOnePageState extends State<TbcScreeningFormOnePage> {
  static const _questions = [
    'Batuk lebih dari 2 minggu',
    'Demam',
    'Berkeringat malam hari tanpa aktivitas',
    'Sesak nafas',
    'Nyeri dada',
    'Ada benjolan di leher/bawah rahang/ bawah telinga/ketiak',
    'Batuk berdarah',
    'Batuk kurang dari 2 minggu',
    'Nafsu makan turun',
    'Berat badan turun',
  ];

  late final Map<String, bool?> _answers;

  @override
  void initState() {
    super.initState();
    _answers = {for (final question in _questions) question: null};
  }

  void _handleBack() {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeTbcPersonalIdentity);
  }

  void _handleNext() {
    context.pushNamed(RouteNames.homeTbcScreeningFormTwo);
  }

  void _setAnswer(String question, bool value) {
    setState(() {
      _answers[question] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FF),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.welcomeAccent,
              padding: const EdgeInsets.fromLTRB(16, 18, 20, 18),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _handleBack,
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(36, 36),
                    ),
                    icon: const Icon(Icons.arrow_back_rounded, size: 30),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Formulir Skrining',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: 0.5,
                              minHeight: 8,
                              backgroundColor: const Color(0xFFD8D8DA),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.welcomeAccent,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          'Formulir 1 dari 2',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.welcomeAccent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Keluhan yang dirasakan',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.welcomeAccent,
                      ),
                    ),
                    const SizedBox(height: 28),
                    ..._questions.map((question) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _ScreeningQuestionCard(
                          question: question,
                          value: _answers[question],
                          onChanged: (value) => _setAnswer(question, value),
                        ),
                      );
                    }),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 20),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: OutlinedButton(
                    onPressed: _handleBack,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.welcomeAccent,
                      side: const BorderSide(
                        color: AppColors.welcomeAccent,
                        width: 1.8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Sebelumnya'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 60,
                  child: FilledButton(
                    onPressed: _handleNext,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.welcomeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    child: const Text('Selanjutnya'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScreeningQuestionCard extends StatelessWidget {
  const _ScreeningQuestionCard({
    required this.question,
    required this.value,
    required this.onChanged,
  });

  final String question;
  final bool? value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF55585E),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _BinaryOptionCard(
                label: 'Ya',
                isSelected: value == true,
                onTap: () => onChanged(true),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _BinaryOptionCard(
                label: 'Tidak',
                isSelected: value == false,
                onTap: () => onChanged(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BinaryOptionCard extends StatelessWidget {
  const _BinaryOptionCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? const Color(0xFFE6F0FF) : const Color(0xFFF0F0F2),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked_rounded
                    : Icons.radio_button_unchecked_rounded,
                size: 30,
                color: isSelected
                    ? AppColors.welcomeAccent
                    : const Color(0xFF9D9D9F),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? AppColors.welcomeAccent
                      : const Color(0xFF9D9D9F),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
