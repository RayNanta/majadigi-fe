import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../widgets/tbc_result_layout.dart';

class TbcResultNegativePage extends StatelessWidget {
  const TbcResultNegativePage({super.key});

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
      illustration: const TbcNegativeIllustration(),
      resultText: 'Anda Bukan Terduga TBC',
      resultColor: const Color(0xFF27B36A),
    );
  }
}
