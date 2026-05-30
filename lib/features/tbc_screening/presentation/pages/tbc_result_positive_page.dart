import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../widgets/tbc_result_layout.dart';

class TbcResultPositivePage extends StatelessWidget {
  final Map<String, dynamic> resultData;

  const TbcResultPositivePage({
    super.key,
    required this.resultData,
  });

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      context.pop();
      return;
    }

    context.goNamed(RouteNames.homeTbcScreeningFormTwo);
  }

  void _handleDone(BuildContext context) {
    context.goNamed(RouteNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return TbcResultLayout(
      onBack: () => _handleBack(context),
      onPrimaryAction: () => _handleDone(context),
      illustration: const TbcPositiveIllustration(),
      resultText: 'Anda Terduga TBC',
      resultColor: const Color(0xFFFF2156),
      resultSubtitle: 'Segera lakukan pemeriksaan\ndan penanganan lanjutan!',
      patientName:
      resultData['nama_pasien'] ?? '-',

      screeningDate:
      resultData['screening_date'] ?? '-',
    );
  }
}
